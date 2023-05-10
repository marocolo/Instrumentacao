#include<Wire.h>

// Endereco I2C
const int MPU = 0x68;

// Variaveis de armazenamento
float AccX, AccY, AccZ, Temp, GyrX, GyrY, GyrZ;

void setup() {
  Serial.begin(9600);
  // Inicializa o MPU-6050
  Wire.begin();
  Wire.beginTransmission(MPU);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);

  // Fundo de escala do giroscópio
  /*
    Wire.write(0b00000000); // fundo de escala em +/-250°/s (FS_FULL=0)
    Wire.write(0b00001000); // fundo de escala em +/-500°/s (FS_FULL=1)
    Wire.write(0b00010000); // fundo de escala em +/-1000°/s (FS_FULL=2)
    Wire.write(0b00011000); // fundo de escala em +/-2000°/s (FS_FULL=3)
  */
  Wire.beginTransmission(MPU);
  Wire.write(0x1B);
  Wire.write(0x00011000);  // Fundo de escala
  Wire.endTransmission();

  // Fundo de escala do acelerômetro
  /*
      Wire.write(0b00000000); // fundo de escala em +/-2g (AFS_FULL=0)
      Wire.write(0b00001000); // fundo de escala em +/-4g (AFS_FULL=1)
      Wire.write(0b00010000); // fundo de escala em +/-8g (AFS_FULL=2)
      Wire.write(0b00011000); // fundo de escala em +/-16g (AFS_FULL=3)
  */
  Wire.beginTransmission(MPU);
  Wire.write(0x1C);
  Wire.write(0b00011000);  // Fundo de escala
  Wire.endTransmission();
}

void loop() {
  // Inicialização da transmissão de dados
  Wire.beginTransmission(MPU);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 14, true);

  // Armazena o valor dos sensores nas variaveis correspondentes
  AccX = Wire.read() << 8 | Wire.read(); //0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)
  AccY = Wire.read() << 8 | Wire.read(); //0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
  AccZ = Wire.read() << 8 | Wire.read(); //0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)
  Temp = Wire.read() << 8 | Wire.read(); //0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L)
  GyrX = Wire.read() << 8 | Wire.read(); //0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
  GyrY = Wire.read() << 8 | Wire.read(); //0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
  GyrZ = Wire.read() << 8 | Wire.read(); //0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)

  // Imprime na Serial os valores obtidos
  /* Alterar divisão de acordo fundo de escala escolhido:
      Acelerômetro
      +/-2g = 16384
      +/-4g = 8192
      +/-8g = 4096
      +/-16g = 2048

      Giroscópio
      +/-250°/s = 131
      +/-500°/s = 65.6
      +/-1000°/s = 32.8
      +/-2000°/s = 16.4
  */
/*
  Serial.print(AccX / 2048);
  Serial.print(" ");
  Serial.print(AccY / 2048);
  Serial.print(" ");
  Serial.println(AccZ / 2048);
*/
  Serial.print(GyrX / 16.4);
  Serial.print(" ");
  Serial.print(GyrY / 16.4);
  Serial.print(" ");
  Serial.println(GyrZ / 16.4);

  delay(100);
}
