% Código para avaliar o modelo WRF, calculando RMSE e correlação de Pearson
% em um ponto (No caso, boia vitória) (PARA O VENTO)

clear all
close all
clc

path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['D:\Dados TCC\avaliar_modelo\'];
path_in3=['D:\Dados TCC\2016\'];
path_in4=['D:\Dados TCC\avaliar_modelo\'];

dadosboia = [path_in,'historico_vitoria.txt'];
dados = readtable(dadosboia);

ncfile_veraod03 = [path_in4,'d03_default_201601'];
ncfile_invernod03 = [path_in4,'d03_default_201607'];

ncfile_veraod03sst = [path_in3,'d03_201601_sst'];
ncfile_invernod03sst = [path_in3,'d03_201607_sst'];

lat_verao_wrfd03=ncread(ncfile_veraod03,'XLAT');
lon_verao_wrfd03=ncread(ncfile_veraod03,'XLONG');

lat_inverno_wrfd03=ncread(ncfile_invernod03,'XLAT');
lon_inverno_wrfd03=ncread(ncfile_invernod03,'XLONG');

lat_verao_wrfd03sst=ncread(ncfile_veraod03sst,'XLAT');
lon_verao_wrfd03sst=ncread(ncfile_veraod03sst,'XLONG');

lat_inverno_wrfd03sst=ncread(ncfile_invernod03sst,'XLAT');
lon_inverno_wrfd03sst=ncread(ncfile_invernod03sst,'XLONG');

u10_veraod03 = ncread(ncfile_veraod03,'U10');
v10_veraod03 = ncread(ncfile_veraod03,'V10');

u10_invernod03 = ncread(ncfile_invernod03,'U10');
v10_invernod03 = ncread(ncfile_invernod03,'V10');

u10_veraod03sst = ncread(ncfile_veraod03sst,'U10');
v10_veraod03sst = ncread(ncfile_veraod03sst,'V10');

u10_invernod03sst = ncread(ncfile_invernod03sst,'U10');
v10_invernod03sst = ncread(ncfile_invernod03sst,'V10');


magv10m_veraod03 = sqrt(u10_veraod03.^2 + v10_veraod03.^2);

magv10m_invernod03 = sqrt(u10_invernod03.^2 + v10_invernod03.^2);

magv10m_veraod03sst = sqrt(u10_veraod03sst.^2 + v10_veraod03sst.^2);

magv10m_invernod03sst = sqrt(u10_invernod03sst.^2 + v10_invernod03sst.^2);

TT = table2timetable(dados);

% Definindo o início e fim do data range
di_verao = '2016-01-01 00:00:00';
df_verao = '2016-02-01 01:00:00';
di_inverno = '2016-07-01 00:00:00';
df_inverno = '2016-08-01 01:00:00';

% Selecionando os intervalos de dados da boia referentes aos períodos simulados no WRF
tr_verao = timerange(di_verao,df_verao);
TT2_verao = TT(tr_verao,:);
tr_inverno = timerange(di_inverno,df_inverno);
TT2_inverno = TT(tr_inverno,:);

%Dados de velocidade do vento da boia
wvel_verao = TT2_verao.Wspd;
wvel_inverno = TT2_inverno.Wspd;

time_verao = TT2_verao.x_Datetime;
time_inverno = TT2_inverno.x_Datetime;

% Tentativa de calcular uma posição média da boia
lat_verao_boia = TT2_verao.Lat;
lon_verao_boia = TT2_verao.Lon;
lat_inverno_boia = TT2_inverno.Lat;
lon_inverno_boia = TT2_inverno.Lon;


for i=1:745; 
    
lat_verao_boia_f = lat_verao_boia(i);
lon_verao_boia_f = lon_verao_boia(i);

lon_verao_wrf_fd03 = double(lon_verao_wrfd03(:,:,i));
lat_verao_wrf_fd03 = double(lat_verao_wrfd03(:,:,i));
magv10m_verao_fd03 = double(magv10m_veraod03(:,:,i));

lon_verao_wrf_fd03sst = double(lon_verao_wrfd03sst(:,:,i));
lat_verao_wrf_fd03sst = double(lat_verao_wrfd03sst(:,:,i));
magv10m_verao_fd03sst = double(magv10m_veraod03sst(:,:,i));

lat_inverno_boia_f = lat_inverno_boia(i);
lon_inverno_boia_f = lon_inverno_boia(i);

lon_inverno_wrf_fd03 = double(lon_inverno_wrfd03(:,:,i));
lat_inverno_wrf_fd03 = double(lat_inverno_wrfd03(:,:,i));
magv10m_inverno_fd03 = double(magv10m_invernod03(:,:,i));

lon_inverno_wrf_fd03sst = double(lon_inverno_wrfd03sst(:,:,i));
lat_inverno_wrf_fd03sst = double(lat_inverno_wrfd03sst(:,:,i));
magv10m_inverno_fd03sst = double(magv10m_invernod03sst(:,:,i));

% t2m_inverno_fd03sst = double(t2m_invernod03sst(:,:,i));
% p_inverno_fd03sst = double(p_invernod03sst(:,:,i));


Fv_veraod03 = scatteredInterpolant(lon_verao_wrf_fd03(:),lat_verao_wrf_fd03(:),magv10m_verao_fd03(:));
vel_wrf2boia_veraod03(i) = Fv_veraod03(lon_verao_boia_f,lat_verao_boia_f);

Fv_veraod03sst = scatteredInterpolant(lon_verao_wrf_fd03sst(:),lat_verao_wrf_fd03sst(:),magv10m_verao_fd03sst(:));
vel_wrf2boia_veraod03sst(i) = Fv_veraod03sst(lon_verao_boia_f,lat_verao_boia_f);

Fv_invernod03 = scatteredInterpolant(lon_inverno_wrf_fd03(:),lat_inverno_wrf_fd03(:),magv10m_inverno_fd03(:));
vel_wrf2boia_invernod03(i) = Fv_invernod03(lon_inverno_boia_f,lat_inverno_boia_f);


Fv_invernod03sst = scatteredInterpolant(lon_inverno_wrf_fd03sst(:),lat_inverno_wrf_fd03sst(:),magv10m_inverno_fd03sst(:));
vel_wrf2boia_invernod03sst(i) = Fv_invernod03sst(lon_inverno_boia_f,lat_inverno_boia_f);


end

vel_wrf2boia_veraod03 = vel_wrf2boia_veraod03';
vel_wrf2boia_invernod03 = vel_wrf2boia_invernod03';
vel_wrf2boia_veraod03sst = vel_wrf2boia_veraod03sst';
vel_wrf2boia_invernod03sst = vel_wrf2boia_invernod03sst';


figure(1)
subplot(2,1,1);
plot(time_verao,wvel_verao,'k','linewidth',2);
hold on 
plot(time_verao,vel_wrf2boia_veraod03,'b','linewidth',2,'linestyle',':');
hold on
plot(time_verao,vel_wrf2boia_veraod03sst,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_verao,t2m_wrf2boia_veraod02,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_verao,t2m_wrf2boia_veraod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D03 WRF Default','D03 WRF RTG-SST','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Intensidade do vento a 10 m (m/s)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_verao) max(time_verao)])

subplot(2,1,2);
plot(time_inverno,wvel_inverno,'k','linewidth',2);
hold on 
plot(time_inverno,vel_wrf2boia_invernod03,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,vel_wrf2boia_invernod03sst,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_inverno,t2m_wrf2boia_invernod02,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_inverno,t2m_wrf2boia_invernod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D03 WRF Default','D03 WRF RTG-SST','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Intensidade do vento a 10 m (m/s)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_inverno) max(time_inverno)]);


% RMSE Verao - Inverno (Temperatura)

RMSE_vel_df_sst_ver = sqrt(mean(vel_wrf2boia_veraod03 - vel_wrf2boia_veraod03sst).^2);
RMSE_vel_df_boia_ver = sqrt(mean(vel_wrf2boia_veraod03 - wvel_verao).^2);
RMSE_vel_sst_boia_ver = sqrt(mean(vel_wrf2boia_veraod03sst - wvel_verao).^2);

RMSE_vel_df_sst_inv = sqrt(mean(vel_wrf2boia_invernod03 - vel_wrf2boia_invernod03sst).^2);
RMSE_vel_df_boia_inv = sqrt(mean(vel_wrf2boia_invernod03 - wvel_inverno).^2);
RMSE_vel_sst_boia_inv = sqrt(mean(vel_wrf2boia_invernod03sst - wvel_inverno).^2);

% Verao Pearson (temp)

num_vel_ver_df = sum((vel_wrf2boia_veraod03 - mean(vel_wrf2boia_veraod03)).*(wvel_verao - mean(wvel_verao)));
deno_vel_ver_df = sqrt(sum((vel_wrf2boia_veraod03 - mean(vel_wrf2boia_veraod03)).^2)).*sqrt(sum((wvel_verao - mean(wvel_verao)).^2));

pearson_vel_df_boia_ver = num_vel_ver_df./deno_vel_ver_df;

num_vel_ver_sst = sum((vel_wrf2boia_veraod03sst - mean(vel_wrf2boia_veraod03sst)).*(wvel_verao - mean(wvel_verao)));
deno_vel_ver_sst = sqrt(sum((vel_wrf2boia_veraod03sst - mean(vel_wrf2boia_veraod03sst)).^2)).*sqrt(sum((wvel_verao - mean(wvel_verao)).^2));

pearson_vel_sst_boia_ver = num_vel_ver_sst./deno_vel_ver_sst;

% Inverno Pearson (temp)

num_vel_inv_df = sum((vel_wrf2boia_invernod03 - mean(vel_wrf2boia_invernod03)).*(wvel_inverno - mean(wvel_inverno)));
deno_vel_inv_df = sqrt(sum((vel_wrf2boia_invernod03 - mean(vel_wrf2boia_invernod03)).^2)).*sqrt(sum((wvel_inverno - mean(wvel_inverno)).^2));

pearson_vel_df_boia_inv = num_vel_inv_df./deno_vel_inv_df;

num_vel_inv_sst = sum((vel_wrf2boia_invernod03sst - mean(vel_wrf2boia_invernod03sst)).*(wvel_inverno - mean(wvel_inverno)));
deno_vel_inv_sst = sqrt(sum((vel_wrf2boia_invernod03sst - mean(vel_wrf2boia_invernod03sst)).^2)).*sqrt(sum((wvel_inverno - mean(wvel_inverno)).^2));

pearson_vel_sst_boia_inv = num_vel_inv_sst./deno_vel_inv_sst;


