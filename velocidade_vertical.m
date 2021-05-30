% Código para visualização do perfil vertical de vento em algum ponto da
% grade do modelo WRF

clear all 
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['D:\Dados TCC\avaliar_modelo\'];
path_in3=['D:\Dados TCC\2016\'];

ncfile_d03 = [path_in2,'d03_default_201607'];
ncfile_d03sst = [path_in3,'d03_201607_sst'];

U = ncread(ncfile_d03,'U');
V = ncread(ncfile_d03,'V');

Usst = ncread(ncfile_d03sst,'U');
Vsst = ncread(ncfile_d03sst,'V');

hora = 06;
d2 = 24;
dia2 = 0* d2;
dia = 361 + dia2 + hora;

linhamin01 = 96;
colunamin01 = 62;

linhamin07 = 49;
colunamin07 = 38;

linhamax01 = 20;
colunamax01= 2;

% % U = interp3(U(:,:,:,dia));
% % V = interp3(V(:,:,:,dia));
% 
% U_tested03 = U(linhamin07,colunamin07,:,dia);
% V_tested03 = V(linhamin07,colunamin07,:,dia);
% % 
% magv_tested03 = sqrt(U_tested03.^2 + V_tested03.^2);
% % 
% % % Usst = interp3(Usst(:,:,:,dia));
% % % Vsst = interp3(Vsst(:,:,:,dia));
% % 
% U_tested03sst = Usst(linhamin07,colunamin07,:,dia);
% V_tested03sst = Vsst(linhamin07,colunamin07,:,dia);
% 
U_tested03 = U(linhamax01,colunamax01,:,dia);
V_tested03 = V(linhamax01,colunamax01,:,dia);


magv_tested03 = sqrt(U_tested03.^2 + V_tested03.^2);
% 
% % Usst = interp3(Usst(:,:,:,dia));
% % Vsst = interp3(Vsst(:,:,:,dia));
% 
U_tested03sst = Usst(linhamax01,colunamax01,:,dia);
V_tested03sst = Vsst(linhamax01,colunamax01,:,dia);
% 
magv_tested03sst = sqrt(U_tested03sst.^2 + V_tested03sst.^2);

mgvd03 = double(reshape(magv_tested03, [1,20]));
mgvd03sst = double(reshape(magv_tested03sst, [1,29]));

etalevels = ncread(ncfile_d03,'ZNW');
etalevels = etalevels(:,dia)';

etalevelst = ncread(ncfile_d03sst,'ZNW');
etalevelst = etalevelst(:,dia)';

% PH = ncread(ncfile_d03,'PH');
% PHB = ncread(ncfile_d03,'PHB');
% PHdia = PH(36,2,:,dia);
% PHBdia = PHB(36,2,:,dia);
% 
% g = 9.81;
% z = (PHdia + PHBdia)/g;

% PHsst = ncread(ncfile_d03sst,'PH');
% PHBsst = ncread(ncfile_d03sst,'PHB');
% PHdiasst = PHsst(36,2,:,dia);
% PHBdiasst = PHBsst(36,2,:,dia);
% 
g = 9.81;
% zsst = (PHdiasst + PHBdiasst)/g;

PBLH = ncread(ncfile_d03,'PBLH');
PBLHdia = PBLH(20,2,dia);


PBLHsst = ncread(ncfile_d03sst,'PBLH');
PBLHdiasst = PBLHsst(20,2,dia);
% 
% PBLH = ncread(ncfile_d03,'PBLH');
% PBLHdia = PBLH(20,2,dia);
% 
% 
% PBLHsst = ncread(ncfile_d03sst,'PBLH');
% PBLHdiasst = PBLHsst(20,2,dia);

% eta = 1:20;
% zeta = (28/19)*(eta-1)+1

for i=1:20;
     etalevels_c(i) = mean(etalevels(i:i+1));
     
end
for i = 1:29;
    etalevelst_c(i) = mean(etalevelst(i:i+1));
end

etalevels_cp = etalevels_c*1013;
etalevelst_cp = etalevelst_c*1013;

rho = 1.2922;

z_cp = (1013 - etalevels_cp)/rho*g;
z_cpt = (1013 - etalevelst_cp)/rho*g;

% figure(1)
% 
% plot(mgvd03,etalevels_cp,'r','linewidth',2.5)
% hold on 
% plot(mgvd03sst,etalevelst_cp,'b','linewidth',2.5)
% 
% legend('D03 WRF - TSM:GFS','D03 WRF - TSM:RTG','Location','southwest');
% xlabel('Intensidade do vento (m/s)','fontsize',14,'fontweight','bold');
% ylabel('Pressão (hPa)','fontsize',14,'fontweight','bold');
% title(sprintf('15/01/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
% set(gca,'YDir','reverse','Fontsize',16,'fontweight','bold');
% ylim([min(etalevels_cp) max(etalevels_cp)])
% hold off
% xlim([min(time_inverno) max(time_inverno)]);figure(2)


figure2 = figure(2);

subplot(1,2,1)

plot(mgvd03,z_cp,'r','linewidth',2.5)
hold on 
plot(mgvd03sst,z_cpt,'b','linewidth',2.5)
yticks([100 500 1000 2000 3000 4000 5000 6000 7000]);
legend('D03 WRF - TSM:GFS','D03 WRF - TSM:RTG','Location','southwest');
xlabel('Intensidade do vento (m/s)','fontsize',14,'fontweight','bold');
ylabel('Altura (m)','fontsize',14,'fontweight','bold');
title(sprintf('1 - 15/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');

ylim([0 max(z_cp)]);
set(gca,'Fontsize',16,'fontweight','bold');

dim = [0.725 0.171339563862928 0.163020833333333 0.130218068535825];
annotation(figure2,'textbox',dim,...
    'String',{sprintf('Altura da Camada Limite TSM-GFS: %.1f metros \n\nAltura da Camada Limite TSM-RTG: %.1f metros', PBLHdia,PBLHdiasst)},...
    'FitBoxToText','off','Fontsize',14,'fontweight','bold');

linhamin07 = 49;
colunamin07 = 38;

% linhamin01 = 96;
% colunamin01 = 62;
%
U_tested03 = U(linhamin07,colunamin07,:,dia);
V_tested03 = V(linhamin07,colunamin07,:,dia);
%
magv_tested03 = sqrt(U_tested03.^2 + V_tested03.^2);
%
U_tested03sst = Usst(linhamin07,colunamin07,:,dia);
V_tested03sst = Vsst(linhamin07,colunamin07,:,dia);
% 
magv_tested03sst = sqrt(U_tested03sst.^2 + V_tested03sst.^2);

mgvd03 = double(reshape(magv_tested03, [1,20]));
mgvd03sst = double(reshape(magv_tested03sst, [1,29]));

PBLH = ncread(ncfile_d03,'PBLH');
PBLHdia = PBLH(linhamin07,colunamin07,dia);

PBLHsst = ncread(ncfile_d03sst,'PBLH');
PBLHdiasst = PBLHsst(linhamin07,colunamin07,dia);

subplot(1,2,2)

plot(mgvd03,z_cp,'r','linewidth',2.5)
hold on 
plot(mgvd03sst,z_cpt,'b','linewidth',2.5)
yticks([100 500 1000 2000 3000 4000 5000 6000 7000]);
legend('D03 WRF - TSM:GFS','D03 WRF - TSM:RTG','Location','southwest');
xlabel('Intensidade do vento (m/s)','fontsize',14,'fontweight','bold');
ylabel('Altura (m)','fontsize',14,'fontweight','bold');
title(sprintf('2 - 15/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');

ylim([0 max(z_cp)]);
set(gca,'Fontsize',16,'fontweight','bold');

dim = [0.725 0.171339563862928 0.163020833333333 0.130218068535825];
annotation(figure2,'textbox',dim,...
    'String',{sprintf('Altura da Camada Limite TSM-GFS: %.1f metros \n\nAltura da Camada Limite TSM-RTG: %.1f metros', PBLHdia,PBLHdiasst)},...
    'FitBoxToText','off','Fontsize',14,'fontweight','bold');