% Código para gerar série temporal de dados de saída do WRF e de uma bóia 
% Nessa caso, boia vitória. 

clear all
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['D:\Dados TCC\avaliar_modelo\'];
dadosboia = [path_in,'historico_vitoria.txt'];
dados = readtable(dadosboia);
%d01
ncfile_veraod01 = [path_in2,'d01_default_201601'];
ncfile_invernod01 = [path_in2,'d01_default_201607'];
%d02
ncfile_veraod02 = [path_in2,'d02_default_201601'];
ncfile_invernod02 = [path_in2,'d02_default_201607'];
%d03
ncfile_veraod03 = [path_in2,'d03_default_201601'];
ncfile_invernod03 = [path_in2,'d03_default_201607'];

% lendo lat e lon das saídas do WRF
%d01
lat_verao_wrfd01=ncread(ncfile_veraod01,'XLAT');
lon_verao_wrfd01=ncread(ncfile_veraod01,'XLONG');

lat_inverno_wrfd01=ncread(ncfile_invernod01,'XLAT');
lon_inverno_wrfd01=ncread(ncfile_invernod01,'XLONG');
%d02
lat_verao_wrfd02=ncread(ncfile_veraod02,'XLAT');
lon_verao_wrfd02=ncread(ncfile_veraod02,'XLONG');

lat_inverno_wrfd02=ncread(ncfile_invernod02,'XLAT');
lon_inverno_wrfd02=ncread(ncfile_invernod02,'XLONG');
%d03
lat_verao_wrfd03=ncread(ncfile_veraod03,'XLAT');
lon_verao_wrfd03=ncread(ncfile_veraod03,'XLONG');

lat_inverno_wrfd03=ncread(ncfile_invernod03,'XLAT');
lon_inverno_wrfd03=ncread(ncfile_invernod03,'XLONG');


% Lendo a temperatura do ar a 2m das saídas do WRF
%d01
t2m_veraod01 = ncread(ncfile_veraod01,'T2')-273;
t2m_invernod01 = ncread(ncfile_invernod01,'T2')-273;

p_veraod01 = ncread(ncfile_veraod01,'PSFC')/100;
p_invernod01 = ncread(ncfile_invernod01,'PSFC')/100;
%d02
t2m_veraod02 = ncread(ncfile_veraod02,'T2')-273;
t2m_invernod02 = ncread(ncfile_invernod02,'T2')-273;

p_veraod02 = ncread(ncfile_veraod02,'PSFC')/100;
p_invernod02 = ncread(ncfile_invernod02,'PSFC')/100;
%d03
t2m_veraod03 = ncread(ncfile_veraod03,'T2')-273;
t2m_invernod03 = ncread(ncfile_invernod03,'T2')-273;

p_veraod03 = ncread(ncfile_veraod03,'PSFC')/100;
p_invernod03 = ncread(ncfile_invernod03,'PSFC')/100;
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
lon_verao_wrf_fd01 = double(lon_verao_wrfd01(:,:,i));
lat_verao_wrf_fd01 = double(lat_verao_wrfd01(:,:,i));
t2m_verao_fd01 = double(t2m_veraod01(:,:,i));
p_verao_fd01 = double(p_veraod01(:,:,i));
%d02verao
lon_verao_wrf_fd02 = double(lon_verao_wrfd02(:,:,i));
lat_verao_wrf_fd02 = double(lat_verao_wrfd02(:,:,i));
t2m_verao_fd02 = double(t2m_veraod02(:,:,i));
p_verao_fd02 = double(p_veraod02(:,:,i));
%d03verao
lon_verao_wrf_fd03 = double(lon_verao_wrfd03(:,:,i));
lat_verao_wrf_fd03 = double(lat_verao_wrfd03(:,:,i));
t2m_verao_fd03 = double(t2m_veraod03(:,:,i));
p_verao_fd03 = double(p_veraod03(:,:,i));

lat_inverno_boia_f = lat_inverno_boia(i);
lon_inverno_boia_f = lon_inverno_boia(i);
%d01verao
lon_inverno_wrf_fd01 = double(lon_inverno_wrfd01(:,:,i));
lat_inverno_wrf_fd01 = double(lat_inverno_wrfd01(:,:,i));
t2m_inverno_fd01 = double(t2m_invernod01(:,:,i));
p_inverno_fd01 = double(p_invernod01(:,:,i));
%d02verao
lon_inverno_wrf_fd02 = double(lon_inverno_wrfd02(:,:,i));
lat_inverno_wrf_fd02 = double(lat_inverno_wrfd02(:,:,i));
t2m_inverno_fd02 = double(t2m_invernod02(:,:,i));
p_inverno_fd02 = double(p_invernod02(:,:,i));
%d03verao
lon_inverno_wrf_fd03 = double(lon_inverno_wrfd03(:,:,i));
lat_inverno_wrf_fd03 = double(lat_inverno_wrfd03(:,:,i));
t2m_inverno_fd03 = double(t2m_invernod03(:,:,i));
p_inverno_fd03 = double(p_invernod03(:,:,i));


%d01verao
Ft_veraod01 = scatteredInterpolant(lon_verao_wrf_fd01(:),lat_verao_wrf_fd01(:),t2m_verao_fd01(:));
Fp_veraod01 = scatteredInterpolant(lon_verao_wrf_fd01(:),lat_verao_wrf_fd01(:),p_verao_fd01(:));
t2m_wrf2boia_veraod01(i) = Ft_veraod01(lon_verao_boia_f,lat_verao_boia_f);
p_wrf2boia_veraod01(i) = Fp_veraod01(lon_verao_boia_f,lat_verao_boia_f);
%d02verao
Ft_veraod02 = scatteredInterpolant(lon_verao_wrf_fd02(:),lat_verao_wrf_fd02(:),t2m_verao_fd02(:));
Fp_veraod02 = scatteredInterpolant(lon_verao_wrf_fd02(:),lat_verao_wrf_fd02(:),p_verao_fd02(:));
t2m_wrf2boia_veraod02(i) = Ft_veraod02(lon_verao_boia_f,lat_verao_boia_f);
p_wrf2boia_veraod02(i) = Fp_veraod02(lon_verao_boia_f,lat_verao_boia_f);
%d03verao
Ft_veraod03 = scatteredInterpolant(lon_verao_wrf_fd03(:),lat_verao_wrf_fd03(:),t2m_verao_fd03(:));
Fp_veraod03 = scatteredInterpolant(lon_verao_wrf_fd03(:),lat_verao_wrf_fd03(:),p_verao_fd03(:));
t2m_wrf2boia_veraod03(i) = Ft_veraod03(lon_verao_boia_f,lat_verao_boia_f);
p_wrf2boia_veraod03(i) = Fp_veraod03(lon_verao_boia_f,lat_verao_boia_f);
%d01inverno
Ft_invernod01 = scatteredInterpolant(lon_inverno_wrf_fd01(:),lat_inverno_wrf_fd01(:),t2m_inverno_fd01(:));
Fp_invernod01 = scatteredInterpolant(lon_inverno_wrf_fd01(:),lat_inverno_wrf_fd01(:),p_inverno_fd01(:));
t2m_wrf2boia_invernod01(i) = Ft_invernod01(lon_inverno_boia_f,lat_inverno_boia_f);
p_wrf2boia_invernod01(i) = Fp_invernod01(lon_inverno_boia_f,lat_inverno_boia_f);
%d02inverno
Ft_invernod02 = scatteredInterpolant(lon_inverno_wrf_fd02(:),lat_inverno_wrf_fd02(:),t2m_inverno_fd02(:));
Fp_invernod02 = scatteredInterpolant(lon_inverno_wrf_fd02(:),lat_inverno_wrf_fd02(:),p_inverno_fd02(:));
t2m_wrf2boia_invernod02(i) = Ft_invernod02(lon_inverno_boia_f,lat_inverno_boia_f);
p_wrf2boia_invernod02(i) = Fp_invernod02(lon_inverno_boia_f,lat_inverno_boia_f);
%d03inverno
Ft_invernod03 = scatteredInterpolant(lon_inverno_wrf_fd03(:),lat_inverno_wrf_fd03(:),t2m_inverno_fd03(:));
Fp_invernod03 = scatteredInterpolant(lon_inverno_wrf_fd03(:),lat_inverno_wrf_fd03(:),p_inverno_fd03(:));
t2m_wrf2boia_invernod03(i) = Ft_invernod03(lon_inverno_boia_f,lat_inverno_boia_f);
p_wrf2boia_invernod03(i) = Fp_invernod03(lon_inverno_boia_f,lat_inverno_boia_f);


end
% t2m_wrf_verao(i-1) = interp2(t2m_verao(:,:,i),md_lon_verao,md_lat_verao); 
% t2m_wrf_verao(i-1) = interp2(lon_verao_wrf(:,:,i),lat_verao_wrf(:,:,i),t2m_verao(:,:,i),md_lon_verao,md_lat_verao); 


t2m_wrf2boia_veraod01 = t2m_wrf2boia_veraod01';
t2m_wrf2boia_invernod01 = t2m_wrf2boia_invernod01';
p_wrf2boia_veraod01 = p_wrf2boia_veraod01';
p_wrf2boia_invernod01 = p_wrf2boia_invernod01';

t2m_wrf2boia_veraod02 = t2m_wrf2boia_veraod02';
t2m_wrf2boia_invernod02 = t2m_wrf2boia_invernod02';
p_wrf2boia_veraod02 = p_wrf2boia_veraod02';
p_wrf2boia_invernod02 = p_wrf2boia_invernod02';

t2m_wrf2boia_veraod03 = t2m_wrf2boia_veraod03';
t2m_wrf2boia_invernod03 = t2m_wrf2boia_invernod03';
p_wrf2boia_veraod03 = p_wrf2boia_veraod03';
p_wrf2boia_invernod03 = p_wrf2boia_invernod03';


figure(1)
subplot(2,1,1);
plot(time_verao,atmp_verao,'k','linewidth',2);
hold on 
plot(time_verao,t2m_wrf2boia_veraod01,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_verao,t2m_wrf2boia_veraod02,'r','linewidth',2,'linestyle',':');
hold on 
plot(time_verao,t2m_wrf2boia_veraod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D01 WRF Default','D02 WRF Default','D03 WRF Default','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Temperatura do ar a 2 m (°C)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_verao) max(time_verao)])

subplot(2,1,2);
plot(time_inverno,atmp_inverno,'k','linewidth',2);
hold on 
plot(time_inverno,t2m_wrf2boia_invernod01,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,t2m_wrf2boia_invernod02,'r','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,t2m_wrf2boia_invernod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D01 WRF Default','D02 WRF Default','D03 WRF Default','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Temperatura do ar a 2 m (°C)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_inverno) max(time_inverno)]);

figure(2)
subplot(2,1,1);
plot(time_verao,pres_verao,'r','linewidth',2);
hold on 
plot(time_verao,p_wrf2boia_veraod01,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_verao,p_wrf2boia_veraod02,'r','linewidth',2,'linestyle',':');
hold on 
plot(time_verao,p_wrf2boia_veraod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D01 WRF Default','D02 WRF Default','D03 WRF Default','Location','northwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Pressão (hPa)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_verao) max(time_verao)])

subplot(2,1,2);
plot(time_inverno,pres_inverno,'k','linewidth',2);
hold on 
plot(time_inverno,p_wrf2boia_invernod01,'b','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,p_wrf2boia_invernod02,'r','linewidth',2,'linestyle',':');
hold on 
plot(time_inverno,p_wrf2boia_invernod03,'g','linewidth',2,'linestyle',':');
legend('Boia Vitória','D01 WRF Default','D02 WRF Default','D03 WRF Default','Location','southwest');
xlabel('Data','fontsize',14,'fontweight','bold');
ylabel('Pressão (hPa)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold');
xlim([min(time_inverno) max(time_inverno)])





