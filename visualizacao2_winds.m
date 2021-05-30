clear all
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in3=['D:\Dados TCC\'];

ncfile = [path_in3,'d01_sst_rtg'];
ncdisp(ncfile);
shpfile = [path_in2, 'LINHA_DE_COSTA_IMAGEM_GEOCOVER_SIRGAS_2000','.shp']
s = shaperead(shpfile,'UseGeoCoords',true)
LAT = (s.Lat);
LON = (s.Lon);
lat=ncread(ncfile,'XLAT');
truelat = lat(:,:,1);
% ncdisp(ncfile);
lon=ncread(ncfile,'XLONG');
truelon = lon(:,:,1);

tempo = ncread(ncfile,'XTIME');
t2m = ncread(ncfile,'T2');
sfc_pressure = ncread(ncfile,'PSFC');
u10 = ncread(ncfile,'U10');
v10 = ncread(ncfile,'V10');

u10m = u10(:,:,1);
v10m = v10(:,:,1);

% u10m = interp2(u10m);
% v10m = interp2(v10m);

velvec10m = sqrt(u10m.^2 + v10m.^2);


landmask=ncread(ncfile,'LANDMASK');
ld1=landmask(:,:,1);

velvec10m(ld1==1)=nan;
pcolor(truelon, truelat, velvec10m); 
c2 = colorbar
colormap hsv
c2.Label.String = 'Velocidade do Vento (m/s)';
axis equal
hold on
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title('a)','fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')
