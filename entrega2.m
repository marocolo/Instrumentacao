clc; close all;
clc; clear; close;
a = arduino('COM6','Uno');  % Declaração do objeto arduino com a porta e modelo
imu = mpu6050(a);
ams=100;                    % Quantidade de amostras
g=9.8106;                   % Valor da aceleração da gravidade usado

acele=zeros(ams,3);

for i=1:ams
   aceler=readAcceleration(imu);
   acele(i,:)=aceler;
end

%% Calibração em X
x_mais=[10.4362976074219;10.4734204101563;10.3812121582031;10.4578527832031;10.3213366699219;10.3979772949219;10.4446801757813;10.4087548828125;10.4386926269531;10.4398901367188;10.4351000976563;10.4362976074219;10.3907922363281;10.4434826660156;10.4422851562500;10.4446801757813;10.2961889648438;10.4710253906250;10.4279150390625;10.4315075683594;10.4207299804688;10.4458776855469;10.3967797851563;10.4506677246094;10.4207299804688;10.4231250000000;10.4602478027344;10.3740270996094;10.4267175292969;10.4434826660156;10.4374951171875;10.3907922363281;10.4315075683594;10.4434826660156;10.4374951171875;10.4087548828125;10.3494781494141;10.4434826660156;10.4818029785156;10.4422851562500;10.3979772949219;10.4686303710938;10.4135449218750;10.4554577636719;10.4794079589844;10.3764221191406;10.4674328613281;10.4710253906250;10.4291125488281;10.4482727050781;10.4291125488281;10.4374951171875;10.4243225097656;10.4279150390625;10.4614453125000;10.3848046875000;10.4482727050781;10.4195324707031;10.4782104492188;10.4063598632813;10.4303100585938;10.3991748046875;10.4255200195313;10.4446801757813;10.4171374511719;10.4099523925781;10.4147424316406;10.4877905273438;10.4003723144531;10.4027673339844;10.4434826660156;10.3871997070313;10.4087548828125;10.3931872558594;10.4530627441406;10.4159399414063;10.4925805664063;10.4386926269531;10.4422851562500;10.3584594726563;10.3536694335938;10.4386926269531;10.4087548828125;10.4458776855469;10.4662353515625;10.3824096679688;10.3860021972656;10.4650378417969;10.4195324707031;10.4470751953125;10.4374951171875;10.3608544921875;10.4422851562500;10.4362976074219;10.4434826660156;10.4171374511719;10.3680395507813;10.3704345703125;10.4303100585938;10.4315075683594]/g;
x_menos=[-9.10466674804688;-9.09867919921875;-9.11783935546875;-9.10227172851563;-9.10586425781250;-9.12382690429688;-9.08430908203125;-9.10107421875000;-9.11664184570313;-9.13460449218750;-9.11903686523438;-9.10586425781250;-9.09388916015625;-9.09269165039063;-9.12981445312500;-9.11065429687500;-9.10466674804688;-9.11664184570313;-9.10107421875000;-9.13101196289063;-9.12502441406250;-9.10107421875000;-9.09628417968750;-9.11544433593750;-9.09867919921875;-9.10227172851563;-9.09269165039063;-9.11065429687500;-9.09149414062500;-9.08909912109375;-9.09867919921875;-9.10107421875000;-9.09029663085938;-9.08670410156250;-9.11424682617188;-9.10466674804688;-9.11185180664063;-9.08790161132813;-9.10346923828125;-9.10586425781250;-9.10706176757813;-9.10466674804688;-9.09867919921875;-9.11783935546875;-9.10227172851563;-9.10586425781250;-9.12382690429688;-9.08430908203125;-9.10107421875000;-9.11664184570313;-9.13460449218750;-9.11903686523438;-9.10586425781250;-9.09388916015625;-9.09269165039063;-9.12981445312500;-9.11065429687500;-9.10466674804688;-9.11664184570313;-9.10107421875000;-9.13101196289063;-9.12502441406250;-9.10107421875000;-9.09628417968750;-9.11544433593750;-9.09867919921875;-9.10227172851563;-9.09269165039063;-9.11065429687500;-9.09149414062500;-9.08909912109375;-9.09867919921875;-9.10107421875000;-9.09029663085938;-9.08670410156250;-9.11424682617188;-9.10466674804688;-9.11185180664063;-9.08790161132813;-9.10346923828125;-9.10586425781250;-9.10706176757813;-9.10466674804688;-9.09867919921875;-9.11783935546875;-9.10227172851563;-9.10586425781250;-9.12382690429688;-9.08430908203125;-9.10107421875000;-9.11664184570313;-9.13460449218750;-9.11903686523438;-9.10586425781250;-9.09388916015625;-9.09269165039063;-9.12981445312500;-9.11065429687500;-9.10466674804688;-9.11664184570313]/g;

media_x_mais=mean(x_mais);
media_x_menos=mean(x_menos);

ganho_x=(media_x_mais-media_x_menos)/2;
offset_x=(media_x_mais+media_x_menos)/2;

% Plot da aceleração na direção +X
figure();
p1=plot(x_mais,'linewidth',1.5);
hold on; grid on;
p2=plot((x_mais-offset_x)/ganho_x,'linewidth',1.5);
hold on;
p3=yline(1,'linewidth',1.5);
xlim([1 100]); xlabel('Amostras','FontSize',16);
ylabel('Aceleração (g)','FontSize',16);
set(gca,'fontsize',14);
legend([p1,p2,p3],'Aceleração medida no sensor','Aceleração compensada','Aceleração de referência','FontSize',12);

% Plot da aceleração na direção -X
figure();
p1=plot(x_menos,'linewidth',1.5);
hold on; grid on;
p2=plot((x_menos-offset_x)/ganho_x,'linewidth',1.5);
hold on;
p3=yline(-1,'linewidth',1.5);
xlim([1 100]); xlabel('Amostras','FontSize',16);
ylabel('Aceleração (g)','FontSize',16);
set(gca,'fontsize',14);
legend([p1,p2,p3],'Aceleração medida no sensor','Aceleração compensada','Aceleração de referência','FontSize',12);

%% Calibração em Y
y_mais=[9.49385742187500;9.51900512695313;9.50822753906250;9.51780761718750;9.49505493164063;9.51182006835938;9.51182006835938;9.52259765625000;9.49385742187500;9.50104248046875;9.48547485351563;9.53098022460938;9.54175781250000;9.50343750000000;9.51661010742188;9.52020263671875;9.54535034179688;9.51421508789063;9.51900512695313;9.50942504882813;9.52020263671875;9.51541259765625;9.48188232421875;9.51182006835938;9.49026489257813;9.50583251953125;9.55133789062500;9.51780761718750;9.47828979492188;9.52619018554688;9.51062255859375;9.52499267578125;9.50942504882813;9.48068481445313;9.49864746093750;9.51301757812500;9.52140014648438;9.48786987304688;9.51541259765625;9.51541259765625;9.51062255859375;9.53098022460938;9.52259765625000;9.50343750000000;9.47948730468750;9.53696777343750;9.54774536132813;9.51062255859375;9.49146240234375;9.53457275390625;9.52379516601563;9.53457275390625;9.52259765625000;9.52020263671875;9.52379516601563;9.50822753906250;9.50463500976563;9.54535034179688;9.52978271484375;9.49864746093750;9.53217773437500;9.51900512695313;9.50703002929688;9.50703002929688;9.51421508789063;9.51900512695313;9.52499267578125;9.52259765625000;9.50583251953125;9.52738769531250;9.51900512695313;9.51062255859375;9.50463500976563;9.55253540039063;9.52978271484375;9.53217773437500;9.52858520507813;9.49146240234375;9.50223999023438;9.52020263671875;9.51780761718750;9.52738769531250;9.49625244140625;9.50223999023438;9.52379516601563;9.49026489257813;9.52020263671875;9.52379516601563;9.50822753906250;9.53217773437500;9.52858520507813;9.49146240234375;9.50223999023438;9.52020263671875;9.51780761718750;9.52738769531250;9.51910612687353;9.51901762812500;9.52149014660438;9.48786927305688]/g;
y_menos=[-9.97046630859375;-9.96687377929688;-9.94292358398438;-9.96687377929688;-9.98723144531250;-9.95849121093750;-9.97046630859375;-9.96447875976563;-9.92975097656250;-9.95968872070313;-9.93813354492188;-9.94172607421875;-9.96447875976563;-9.94052856445313;-9.96567626953125;-9.95729370117188;-9.94771362304688;-9.94891113281250;-9.97166381835938;-9.95729370117188;-9.96208374023438;-9.94412109375000;-9.93214599609375;-9.96567626953125;-9.96926879882813;-9.93094848632813;-9.93573852539063;-9.96328125000000;-9.94891113281250;-9.93094848632813;-9.93573852539063;-9.98124389648438;-9.96567626953125;-9.95370117187500;-9.95609619140625;-9.95849121093750;-9.95370117187500;-9.95609619140625;-9.95609619140625;-9.95968872070313;-9.95968872070313;-9.94172607421875;-9.92615844726563;-9.93334350585938;-9.95250366210938;-9.94531860351563;-9.94531860351563;-9.95849121093750;-9.97166381835938;-9.93573852539063;-9.92975097656250;-9.94172607421875;-9.95968872070313;-9.96088623046875;-9.98124389648438;-9.92975097656250;-9.96687377929688;-9.94052856445313;-9.96208374023438;-9.95250366210938;-9.96447875976563;-9.96926879882813;-9.93933105468750;-9.96687377929688;-9.94531860351563;-9.93214599609375;-9.98124389648438;-9.94771362304688;-9.95370117187500;-9.93693603515625;-9.95729370117188;-9.93933105468750;-9.94412109375000;-9.93573852539063;-9.94651611328125;-9.95849121093750;-9.94891113281250;-9.96447875976563;-9.93454101562500;-9.9477600857656;-9.97765136718750;-9.94651611328125;-9.93454101562500;-9.95609619140625;-9.94891113281250;-9.94651611328125;-9.97525634765625;-9.96328125000000;-9.94771362304688;-9.95849121093750;-9.95609619140625;-9.93693603515625;-9.93573852539063;-9.95609619140625;-9.93693603515625;-9.93573852539063;-9.945145634763665;-9.96229125012890;-9.96686372324688;-9.97753148531150]/g;

media_y_mais=mean(y_mais);
media_y_menos=mean(y_menos);

ganho_y=(media_y_mais-media_y_menos)/2;
offset_y=(media_y_mais+media_y_menos)/2;

% Plot da aceleração na direção +Y
figure();
p1=plot(y_mais,'linewidth',1.5);
hold on; grid on;
p2=plot((y_mais-offset_y)/ganho_y,'linewidth',1.5);
hold on;
p3=yline(1,'linewidth',1.5);
xlim([1 100]); xlabel('Amostras','FontSize',16);
ylabel('Aceleração (g)','FontSize',16);
set(gca,'fontsize',14);
legend([p1,p2,p3],'Aceleração medida no sensor','Aceleração compensada','Aceleração de referência','FontSize',12);

% Plot da aceleração na direção -Y
figure();
p1=plot(y_menos,'linewidth',1.5);
hold on; grid on;
p2=plot((y_menos-offset_y)/ganho_y,'linewidth',1.5);
hold on;
p3=yline(-1,'linewidth',1.5);
xlim([1 100]); xlabel('Amostras','FontSize',16);
ylabel('Aceleração (g)','FontSize',16);
set(gca,'fontsize',14);
legend([p1,p2,p3],'Aceleração medida no sensor','Aceleração compensada','Aceleração de referência','FontSize',12);

%% Calibração de Z
z_mais=[11.9463574218750;11.9343823242188;11.8924694824219;11.9164196777344;11.8948645019531;11.9451599121094;11.9463574218750;11.9547399902344;11.9379748535156;11.9283947753906;11.9104321289063;11.9319873046875;11.9331848144531;11.9236047363281;11.9020495605469;11.9391723632813;11.9427648925781;11.9331848144531;11.9248022460938;11.9391723632813;11.9068395996094;11.9415673828125;11.9068395996094;11.9355798339844;11.9164196777344;11.9571350097656;11.9236047363281;11.9571350097656;11.9595300292969;11.9355798339844;11.8864819335938;11.9128271484375;11.9667150878906;11.8948645019531;11.9164196777344;11.9595300292969;11.9319873046875;11.9715051269531;11.9427648925781;11.9080371093750;11.9499499511719;11.9164196777344;11.9607275390625;11.9499499511719;11.9343823242188;11.9164196777344;11.9451599121094;11.9427648925781;11.9236047363281;11.9092346191406;11.9499499511719;11.9080371093750;11.9295922851563;11.8960620117188;11.9212097167969;11.9631225585938;11.8840869140625;11.9008520507813;11.9355798339844;11.9271972656250;11.9032470703125;11.9475549316406;11.9331848144531;11.9523449707031;11.9307897949219;11.9056420898438;11.6481774902344;11.9619250488281;11.8996545410156;11.9104321289063;11.924478455765625;11.9307897949219;11.8864819335938;11.9092346191406;11.9523449707031;11.9248022460938;11.9379748535156;11.9415673828125;11.9248022460938;11.9032470703125;11.9439624023438;11.9475549316406;11.9152221679688;11.9271972656250;11.9008520507813;11.9379748535156;11.9283947753906;11.9367773437500;11.9487524414063;11.9475549316406;11.8852844238281;11.9427648925781;11.9152221679688;11.9331848144531;11.9200122070313;11.9547399902344;11.8996545410156;11.9116296386719;11.9032470703125;11.9140246582031]/g;
z_menos=[-8.21731201171875;-8.19695434570313;-8.25084228515625;-8.19934936523438;-8.22928710937500;-8.18857177734375;-8.22210205078125;-8.21132446289063;-8.21371948242188;-8.24126220703125;-8.22329956054688;-8.22210205078125;-8.21252197265625;-8.24245971679688;-8.23886718750000;-8.20773193359375;-8.19096679687500;-8.22090454101563;-8.22090454101563;-8.18737426757813;-8.24126220703125;-8.22210205078125;-8.19934936523438;-8.19815185546875;-8.154478759765625;-8.21252197265625;-8.23168212890625;-8.24126220703125;-8.21731201171875;-8.17659667968750;-8.24724975585938;-8.20054687500000;-8.18018920898438;-8.21850952148438;-8.21850952148438;-8.18497924804688;-8.15983154296875;-8.21252197265625;-8.24006469726563;-8.20294189453125;-8.21611450195313;-8.20533691406250;-8.20533691406250;-8.21491699218750;-8.17659667968750;-8.23168212890625;-8.20294189453125;-8.20413940429688;-8.17060913085938;-8.19096679687500;-8.19575683593750;-8.21850952148438;-8.21731201171875;-8.22329956054688;-8.25084228515625;-8.22090454101563;-8.21132446289063;-8.21970703125000;-8.18617675781250;-8.154478759765625;-8.20533691406250;-8.21012695312500;-8.17659667968750;-8.22210205078125;-8.18737426757813;-8.21731201171875;-8.21731201171875;-8.19336181640625;-8.18378173828125;-8.18857177734375;-8.20294189453125;-8.21970703125000;-8.20653442382813;-8.17060913085938;-8.21132446289063;-8.20533691406250;-8.21850952148438;-8.22210205078125;-8.24245971679688;-8.22210205078125;-8.18018920898438;-8.17899169921875;-8.22689208984375;-8.23048461914063;-8.20294189453125;-8.21371948242188;-8.22210205078125;-8.22210205078125;-8.20892944335938;-8.22808959960938;-8.20294189453125;-8.18857177734375;-8.22808959960938;-8.22449707031250;-8.24126220703125;-8.23647216796875;-8.16222656250000;-8.23527465820313;-8.19455932617188;-8.18497924804688]/g;

media_z_mais=mean(z_mais);
media_z_menos=mean(z_menos);

ganho_z=(media_z_mais-media_z_menos)/2;
offset_z=(media_z_mais+media_z_menos)/2;

% Plot da aceleração na direção +Z
figure();
p1=plot(z_mais,'linewidth',1.5);
hold on; grid on;
p2=plot((z_mais-offset_z)/ganho_z,'linewidth',1.5);
hold on;
p3=yline(1,'linewidth',1.5);
xlim([1 100]); xlabel('Amostras','FontSize',16);
ylabel('Aceleração (g)','FontSize',16);
set(gca,'fontsize',14);
legend([p1,p2,p3],'Aceleração medida no sensor','Aceleração compensada','Aceleração de referência','FontSize',12);

% Plot da aceleração na direção -Z
figure();
p1=plot(z_menos,'linewidth',1.5);
hold on; grid on;
p2=plot((z_menos-offset_z)/ganho_z,'linewidth',1.5);
hold on;
p3=yline(-1,'linewidth',1.5);
xlim([1 100]); xlabel('Amostras','FontSize',16);
ylabel('Aceleração (g)','FontSize',16);
set(gca,'fontsize',14);
legend([p1,p2,p3],'Aceleração medida no sensor','Aceleração compensada','Aceleração de referência','FontSize',12);