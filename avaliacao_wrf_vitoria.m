% Código para avaliar o modelo WRF, calculando RMSE e correlação de Pearson
% em um ponto (No caso, boia vitória) (PRESSÃO E TEMPERATURA)

clear all
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['D:\Dados TCC\avaliar_modelo\'];
path_in3=['D:\Dados TCC\2016\'];
path_in4=['D:\Dados TCC\avaliar_modelo\'];

dadosboia = [path_in,'historico_vitoria.txt'];
dados = readtable(dadosboia);
%d01
% ncfile_veraod01 = [path_in3,'d01_default'];
% ncfile_veraod01sst = [path_in3,'d01_nova_sst']
% ncfile_invernod01 = [path_in2,'d01_default_201607'];
%d02
% ncfile_veraod02 = [path_in2,'d02_default_201601'];
% ncfile_invernod02 = [path_in2,'d02_default_201607'];
% %d03
ncfile_veraod03 = [path_in4,'d03_default_201601'];
ncfile_invernod03 = [path_in4,'d03_default_201607'];

ncfile_veraod03sst = [path_in3,'d03_201601_sst'];
ncfile_invernod03sst = [path_in3,'d03_201607_sst'];

% lendo lat e lon das saídas do WRF
%d01
% lat_verao_wrfd01=ncread(ncfile_veraod01,'XLAT');
% lon_verao_wrfd01=ncread(ncfile_veraod01,'XLONG');
% 
% lat_verao_wrfd01sst=ncread(ncfile_veraod01sst,'XLAT');
% lon_verao_wrfd01sst=ncread(ncfile_veraod01sst,'XLONG');

% lat_inverno_wrfd01=ncread(ncfile_invernod01,'XLAT');
% lon_inverno_wrfd01=ncread(ncfile_invernod01,'XLONG');
%d02
% lat_verao_wrfd02=ncread(ncfile_veraod02,'XLAT');
% lon_verao_wrfd02=ncread(ncfile_veraod02,'XLONG');
% 
% lat_inverno_wrfd02=ncread(ncfile_invernod02,'XLAT');
% lon_inverno_wrfd02=ncread(ncfile_invernod02,'XLONG');
% %d03
lat_verao_wrfd03=ncread(ncfile_veraod03,'XLAT');
lon_verao_wrfd03=ncread(ncfile_veraod03,'XLONG');

lat_inverno_wrfd03=ncread(ncfile_invernod03,'XLAT');
lon_inverno_wrfd03=ncread(ncfile_invernod03,'XLONG');

lat_verao_wrfd03sst=ncread(ncfile_veraod03sst,'XLAT');
lon_verao_wrfd03sst=ncread(ncfile_veraod03sst,'XLONG');

lat_inverno_wrfd03sst=ncread(ncfile_invernod03sst,'XLAT');
lon_inverno_wrfd03sst=ncread(ncfile_invernod03sst,'XLONG');


% Lendo a temperatura do ar a 2m das saídas do WRF
%d01
% t2m_veraod01 = ncread(ncfile_veraod01,'T2')-273;
% % t2m_invernod01 = ncread(ncfile_invernod01,'T2')-273;
% 
% p_veraod01 = ncread(ncfile_veraod01,'PSFC')/100;
% % p_invernod01 = ncread(ncfile_invernod01,'PSFC')/100;
% 
% t2m_veraod01sst = ncread(ncfile_veraod01sst,'T2')-273;
% % t2m_invernod01 = ncread(ncfile_invernod01,'T2')-273;
% 
% p_veraod01sst = ncread(ncfile_veraod01sst,'PSFC')/100;
% p_invernod01 = ncread(ncfile_invernod01,'PSFC')/100;
%d02
% t2m_veraod02 = ncread(ncfile_veraod02,'T2')-273;
% t2m_invernod02 = ncread(ncfile_invernod02,'T2')-273;
% 
% p_veraod02 = ncread(ncfile_veraod02,'PSFC')/100;
% p_invernod02 = ncread(ncfile_invernod02,'PSFC')/100;
% %d03
t2m_veraod03 = ncread(ncfile_veraod03,'T2')-273;
t2m_invernod03 = ncread(ncfile_invernod03,'T2')-273;

p_veraod03 = ncread(ncfile_veraod03,'PSFC')/100;
p_invernod03 = ncread(ncfile_invernod03,'PSFC')/100;

t2m_veraod03sst = ncread(ncfile_veraod03sst,'T2')-273;
t2m_invernod03sst = ncread(ncfile_invernod03sst,'T2')-273;

p_veraod03sst = ncread(ncfile_veraod03sst,'PSFC')/100;
p_invernod03sst = ncread(ncfile_invernod03sst,'PSFC')/100;
% Convertendo a tabela para entender que são dados temporais
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
atmp_verao = TT2_verao.Atmp;
pres_verao = TT2_verao.Pres;
atmp_inverno = TT2_inverno.Atmp;
pres_inverno = TT2_inverno.Pres;
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
%d01verao
% lon_verao_wrf_fd01 = double(lon_verao_wrfd01(:,:,i));
% lat_verao_wrf_fd01 = double(lat_verao_wrfd01(:,:,i));
% t2m_verao_fd01 = double(t2m_veraod01(:,:,i));
% p_verao_fd01 = double(p_veraod01(:,:,i));

% lon_verao_wrf_fd01sst = double(lon_verao_wrfd01sst(:,:,i));
% lat_verao_wrf_fd01sst = double(lat_verao_wrfd01sst(:,:,i));
% t2m_verao_fd01sst = double(t2m_veraod01sst(:,:,i));
% p_verao_fd01sst = double(p_veraod01sst(:,:,i));
%d02verao
% lon_verao_wrf_fd02 = double(lon_verao_wrfd02(:,:,i));
% lat_verao_wrf_fd02 = double(lat_verao_wrfd02(:,:,i));
% t2m_verao_fd02 = double(t2m_veraod02(:,:,i));
% p_verao_fd02 = double(p_veraod02(:,:,i));
%d03verao
lon_verao_wrf_fd03 = double(lon_verao_wrfd03(:,:,i));
lat_verao_wrf_fd03 = double(lat_verao_wrfd03(:,:,i));
t2m_verao_fd03 = double(t2m_veraod03(:,:,i));
p_verao_fd03 = double(p_veraod03(:,:,i));

lon_verao_wrf_fd03sst = double(lon_verao_wrfd03sst(:,:,i));
lat_verao_wrf_fd03sst = double(lat_verao_wrfd03sst(:,:,i));
t2m_verao_fd03sst = double(t2m_veraod03sst(:,:,i));
p_verao_fd03sst = double(p_veraod03sst(:,:,i));

lat_inverno_boia_f = lat_inverno_boia(i);
lon_inverno_boia_f = lon_inverno_boia(i);
% %d01inverno
% lon_inverno_wrf_fd01 = double(lon_inverno_wrfd01(:,:,i));
% lat_inverno_wrf_fd01 = double(lat_inverno_wrfd01(:,:,i));
% t2m_inverno_fd01 = double(t2m_invernod01(:,:,i));
% p_inverno_fd01 = double(p_invernod01(:,:,i));
%d02inverno
% lon_inverno_wrf_fd02 = double(lon_inverno_wrfd02(:,:,i));
% lat_inverno_wrf_fd02 = double(lat_inverno_wrfd02(:,:,i));
% t2m_inverno_fd02 = double(t2m_invernod02(:,:,i));
% p_inverno_fd02 = double(p_invernod02(:,:,i));
%d03inverno
lon_inverno_wrf_fd03 = double(lon_inverno_wrfd03(:,:,i));
lat_inverno_wrf_fd03 = double(lat_inverno_wrfd03(:,:,i));
t2m_inverno_fd03 = double(t2m_invernod03(:,:,i));
p_inverno_fd03 = double(p_invernod03(:,:,i));

lon_inverno_wrf_fd03sst = double(lon_inverno_wrfd03sst(:,:,i));
lat_inverno_wrf_fd03sst = double(lat_inverno_wrfd03sst(:,:,i));
t2m_inverno_fd03sst = double(t2m_invernod03sst(:,:,i));
p_inverno_fd03sst = double(p_invernod03sst(:,:,i));


%d01verao
% Ft_veraod01 = scatteredInterpolant(lon_verao_wrf_fd01(:),lat_verao_wrf_fd01(:),t2m_verao_fd01(:));
% Fp_veraod01 = scatteredInterpolant(lon_verao_wrf_fd01(:),lat_verao_wrf_fd01(:),p_verao_fd01(:));
% t2m_wrf2boia_veraod01(i) = Ft_veraod01(lon_verao_boia_f,lat_verao_boia_f);
% p_wrf2boia_veraod01(i) = Fp_veraod01(lon_verao_boia_f,lat_verao_boia_f);
% 
% Ft_veraod01sst = scatteredInterpolant(lon_verao_wrf_fd01sst(:),lat_verao_wrf_fd01sst(:),t2m_verao_fd01sst(:));
% Fp_veraod01sst = scatteredInterpolant(lon_verao_wrf_fd01sst(:),lat_verao_wrf_fd01sst(:),p_verao_fd01sst(:));
% t2m_wrf2boia_veraod01sst(i) = Ft_veraod01sst(lon_verao_boia_f,lat_verao_boia_f);
% p_wrf2boia_veraod01sst(i) = Fp_veraod01sst(lon_verao_boia_f,lat_verao_boia_f);
%d02verao
% Ft_veraod02 = scatteredInterpolant(lon_verao_wrf_fd02(:),lat_verao_wrf_fd02(:),t2m_verao_fd02(:));
% Fp_veraod02 = scatteredInterpolant(lon_verao_wrf_fd02(:),lat_verao_wrf_fd02(:),p_verao_fd02(:));
% t2m_wrf2boia_veraod02(i) = Ft_veraod02(lon_verao_boia_f,lat_verao_boia_f);
% p_wrf2boia_veraod02(i) = Fp_veraod02(lon_verao_boia_f,lat_verao_boia_f);
% %d03verao
Ft_veraod03 = scatteredInterpolant(lon_verao_wrf_fd03(:),lat_verao_wrf_fd03(:),t2m_verao_fd03(:));
Fp_veraod03 = scatteredInterpolant(lon_verao_wrf_fd03(:),lat_verao_wrf_fd03(:),p_verao_fd03(:));
t2m_wrf2boia_veraod03(i) = Ft_veraod03(lon_verao_boia_f,lat_verao_boia_f);
p_wrf2boia_veraod03(i) = Fp_veraod03(lon_verao_boia_f,lat_verao_boia_f);

Ft_veraod03sst = scatteredInterpolant(lon_verao_wrf_fd03sst(:),lat_verao_wrf_fd03sst(:),t2m_verao_fd03sst(:));
Fp_veraod03sst = scatteredInterpolant(lon_verao_wrf_fd03sst(:),lat_verao_wrf_fd03sst(:),p_verao_fd03sst(:));
t2m_wrf2boia_veraod03sst(i) = Ft_veraod03sst(lon_verao_boia_f,lat_verao_boia_f);
p_wrf2boia_veraod03sst(i) = Fp_veraod03sst(lon_verao_boia_f,lat_verao_boia_f);

%d01inverno
% Ft_invernod01 = scatteredInterpolant(lon_inverno_wrf_fd01(:),lat_inverno_wrf_fd01(:),t2m_inverno_fd01(:));
% Fp_invernod01 = scatteredInterpolant(lon_inverno_wrf_fd01(:),lat_inverno_wrf_fd01(:),p_inverno_fd01(:));
% t2m_wrf2boia_invernod01(i) = Ft_invernod01(lon_inverno_boia_f,lat_inverno_boia_f);
% p_wrf2boia_invernod01(i) = Fp_invernod01(lon_inverno_boia_f,lat_inverno_boia_f);
%d02inverno
% Ft_invernod02 = scatteredInterpolant(lon_inverno_wrf_fd02(:),lat_inverno_wrf_fd02(:),t2m_inverno_fd02(:));
% Fp_invernod02 = scatteredInterpolant(lon_inverno_wrf_fd02(:),lat_inverno_wrf_fd02(:),p_inverno_fd02(:));
% t2m_wrf2boia_invernod02(i) = Ft_invernod02(lon_inverno_boia_f,lat_inverno_boia_f);
% p_wrf2boia_invernod02(i) = Fp_invernod02(lon_inverno_boia_f,lat_inverno_boia_f);
% %d03inverno
Ft_invernod03 = scatteredInterpolant(lon_inverno_wrf_fd03(:),lat_inverno_wrf_fd03(:),t2m_inverno_fd03(:));
Fp_invernod03 = scatteredInterpolant(lon_inverno_wrf_fd03(:),lat_inverno_wrf_fd03(:),p_inverno_fd03(:));
t2m_wrf2boia_invernod03(i) = Ft_invernod03(lon_inverno_boia_f,lat_inverno_boia_f);
p_wrf2boia_invernod03(i) = Fp_invernod03(lon_inverno_boia_f,lat_inverno_boia_f);

Ft_invernod03sst = scatteredInterpolant(lon_inverno_wrf_fd03sst(:),lat_inverno_wrf_fd03sst(:),t2m_inverno_fd03sst(:));
Fp_invernod03sst = scatteredInterpolant(lon_inverno_wrf_fd03sst(:),lat_inverno_wrf_fd03sst(:),p_inverno_fd03sst(:));
t2m_wrf2boia_invernod03sst(i) = Ft_invernod03sst(lon_inverno_boia_f,lat_inverno_boia_f);
p_wrf2boia_invernod03sst(i) = Fp_invernod03sst(lon_inverno_boia_f,lat_inverno_boia_f);


end
% t2m_wrf_verao(i-1) = interp2(t2m_verao(:,:,i),md_lon_verao,md_lat_verao); 
% t2m_wrf_verao(i-1) = interp2(lon_verao_wrf(:,:,i),lat_verao_wrf(:,:,i),t2m_verao(:,:,i),md_lon_verao,md_lat_verao); 


% t2m_wrf2boia_veraod01 = t2m_wrf2boia_veraod01';
% % t2m_wrf2boia_invernod01 = t2m_wrf2boia_invernod01';
% p_wrf2boia_veraod01 = p_wrf2boia_veraod01';
% % p_wrf2boia_invernod01 = p_wrf2boia_invernod01';
% t2m_wrf2boia_veraod01sst = t2m_wrf2boia_veraod01sst';
% % t2m_wrf2boia_invernod01 = t2m_wrf2boia_invernod01';
% p_wrf2boia_veraod01sst = p_wrf2boia_veraod01sst';
% p_wrf2boia_invernod01 = p_wrf2boia_invernod01';
% 
% t2m_wrf2boia_veraod02 = t2m_wrf2boia_veraod02';
% t2m_wrf2boia_invernod02 = t2m_wrf2boia_invernod02';
% p_wrf2boia_veraod02 = p_wrf2boia_veraod02';
% p_wrf2boia_invernod02 = p_wrf2boia_invernod02';
% 
t2m_wrf2boia_veraod03 = t2m_wrf2boia_veraod03';
t2m_wrf2boia_invernod03 = t2m_wrf2boia_invernod03';
p_wrf2boia_veraod03 = p_wrf2boia_veraod03';
p_wrf2boia_invernod03 = p_wrf2boia_invernod03';

t2m_wrf2boia_veraod03sst = t2m_wrf2boia_veraod03sst';
t2m_wrf2boia_invernod03sst = t2m_wrf2boia_invernod03sst';
p_wrf2boia_veraod03sst = p_wrf2boia_veraod03sst';
p_wrf2boia_invernod03sst = p_wrf2boia_invernod03sst';


figure(1)
subplot(2,1,1);
plot(time_verao,atmp_verao,'k','linewidth',2);
hold on 
plot(time_verao,t2m_wrf2boia_veraod03,'b','linewidth',2,'linestyle',':');
hold on
plot(time_verao,t2m_wrf2boia_veraod03sst,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_verao,t2m_wrf2boia_veraod02,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_verao,t2m_wrf2boia_veraod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D03 WRF Default','D03 WRF RTG-SST','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Temperatura do ar a 2 m (°C)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_verao) max(time_verao)])

subplot(2,1,2);
plot(time_inverno,atmp_inverno,'k','linewidth',2);
hold on 
plot(time_inverno,t2m_wrf2boia_invernod03,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,t2m_wrf2boia_invernod03sst,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_inverno,t2m_wrf2boia_invernod02,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_inverno,t2m_wrf2boia_invernod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D03 WRF Default','D03 WRF RTG-SST','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Temperatura do ar a 2 m (°C)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_inverno) max(time_inverno)]);

figure(2)
subplot(2,1,1);
plot(time_verao,pres_verao,'k','linewidth',2);
hold on 
plot(time_verao,p_wrf2boia_veraod03,'b','linewidth',2,'linestyle',':');
hold on
plot(time_verao,p_wrf2boia_veraod03sst,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_verao,p_wrf2boia_veraod02,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_verao,p_wrf2boia_veraod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D01 WRF Default','D01 WRF RTG-SST','Location','northwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Pressão (hPa)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_verao) max(time_verao)])

subplot(2,1,2);
plot(time_inverno,pres_inverno,'k','linewidth',2);
hold on 
plot(time_inverno,p_wrf2boia_invernod03,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,p_wrf2boia_invernod03sst,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_inverno,p_wrf2boia_invernod02,'r','linewidth',2,'linestyle',':');
% hold on 
% plot(time_inverno,p_wrf2boia_invernod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D03 WRF Default','D03 WRF RTG-SST','Location','southwest');
% legend('Boia Vitória','D01 WRF Default','D02 WRF Default','D03 WRF Default','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Pressão (hPa)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_inverno) max(time_inverno)])

% RMSE Verao - Inverno (Temperatura)

RMSE_tmp_df_sst_ver = sqrt(mean(t2m_wrf2boia_veraod03 - t2m_wrf2boia_veraod03sst).^2);
RMSE_tmp_df_boia_ver = sqrt(mean(t2m_wrf2boia_veraod03 - atmp_verao).^2);
RMSE_tmp_sst_boia_ver = sqrt(mean(t2m_wrf2boia_veraod03sst - atmp_verao).^2);

RMSE_tmp_df_sst_inv = sqrt(mean(t2m_wrf2boia_invernod03 - t2m_wrf2boia_invernod03sst).^2);
RMSE_tmp_df_boia_inv = sqrt(mean(t2m_wrf2boia_invernod03 - atmp_inverno).^2);
RMSE_tmp_sst_boia_inv = sqrt(mean(t2m_wrf2boia_invernod03sst - atmp_inverno).^2);

% Verao Pearson (temp)

num_tmp_ver_df = sum((t2m_wrf2boia_veraod03 - mean(t2m_wrf2boia_veraod03)).*(atmp_verao - mean(atmp_verao)));
deno_tmp_ver_df = sqrt(sum((t2m_wrf2boia_veraod03 - mean(t2m_wrf2boia_veraod03)).^2)).*sqrt(sum((atmp_verao - mean(atmp_verao)).^2));

pearson_tmp_df_boia_ver = num_tmp_ver_df./deno_tmp_ver_df;

num_tmp_ver_sst = sum((t2m_wrf2boia_veraod03sst - mean(t2m_wrf2boia_veraod03sst)).*(atmp_verao - mean(atmp_verao)));
deno_tmp_ver_sst = sqrt(sum((t2m_wrf2boia_veraod03sst - mean(t2m_wrf2boia_veraod03sst)).^2)).*sqrt(sum((atmp_verao - mean(atmp_verao)).^2));

pearson_tmp_sst_boia_ver = num_tmp_ver_sst./deno_tmp_ver_sst;

% Inverno Pearson (temp)

num_tmp_inv_df = sum((t2m_wrf2boia_invernod03 - mean(t2m_wrf2boia_invernod03)).*(atmp_inverno - mean(atmp_inverno)));
deno_tmp_inv_df = sqrt(sum((t2m_wrf2boia_invernod03 - mean(t2m_wrf2boia_invernod03)).^2)).*sqrt(sum((atmp_inverno - mean(atmp_inverno)).^2));

pearson_tmp_df_boia_inv = num_tmp_inv_df./deno_tmp_inv_df;

num_tmp_inv_sst = sum((t2m_wrf2boia_invernod03sst - mean(t2m_wrf2boia_invernod03sst)).*(atmp_inverno - mean(atmp_inverno)));
deno_tmp_inv_sst = sqrt(sum((t2m_wrf2boia_invernod03sst - mean(t2m_wrf2boia_invernod03sst)).^2)).*sqrt(sum((atmp_inverno - mean(atmp_inverno)).^2));

pearson_tmp_sst_boia_inv = num_tmp_inv_sst./deno_tmp_inv_sst;


% RMSE Verao - Inverno (pressão)

RMSE_p_df_sst_ver = sqrt(mean(p_wrf2boia_veraod03 - p_wrf2boia_veraod03sst).^2);
RMSE_p_df_boia_ver = sqrt(mean(p_wrf2boia_veraod03 - pres_verao).^2);
RMSE_p_sst_boia_ver = sqrt(mean(p_wrf2boia_veraod03sst - pres_verao).^2);

RMSE_p_df_sst_inv = sqrt(mean(p_wrf2boia_invernod03 - p_wrf2boia_invernod03sst).^2);
RMSE_p_df_boia_inv = sqrt(mean(p_wrf2boia_invernod03 - pres_inverno).^2);
RMSE_p_sst_boia_inv = sqrt(mean(p_wrf2boia_invernod03sst - pres_inverno).^2);

% Verao Pearson (pres)

num_p_ver_df = sum((p_wrf2boia_veraod03 - mean(p_wrf2boia_veraod03)).*(pres_verao - mean(pres_verao)));
deno_p_ver_df = sqrt(sum((p_wrf2boia_veraod03 - mean(p_wrf2boia_veraod03)).^2)).*sqrt(sum((pres_verao - mean(pres_verao)).^2));

pearson_p_df_boia_ver = num_p_ver_df./deno_p_ver_df;

num_p_ver_sst = sum((p_wrf2boia_veraod03sst - mean(p_wrf2boia_veraod03sst)).*(pres_verao - mean(pres_verao)));
deno_p_ver_sst = sqrt(sum((p_wrf2boia_veraod03sst - mean(p_wrf2boia_veraod03sst)).^2)).*sqrt(sum((pres_verao - mean(pres_verao)).^2));

pearson_p_sst_boia_ver = num_p_ver_sst./deno_p_ver_sst;

% Inverno Pearson (pres)

num_p_inv_df = sum((p_wrf2boia_invernod03 - mean(p_wrf2boia_invernod03)).*(pres_inverno - mean(pres_inverno)));
deno_p_inv_df = sqrt(sum((p_wrf2boia_invernod03 - mean(p_wrf2boia_invernod03)).^2)).*sqrt(sum((pres_inverno - mean(pres_inverno)).^2));

pearson_p_df_boia_inv = num_p_inv_df./deno_p_inv_df;

num_p_inv_sst = sum((p_wrf2boia_invernod03sst - mean(p_wrf2boia_invernod03sst)).*(pres_inverno - mean(pres_inverno)));
deno_p_inv_sst = sqrt(sum((p_wrf2boia_invernod03sst - mean(p_wrf2boia_invernod03sst)).^2)).*sqrt(sum((pres_inverno - mean(pres_inverno)).^2));

pearson_p_sst_boia_inv = num_p_inv_sst./deno_p_inv_sst;