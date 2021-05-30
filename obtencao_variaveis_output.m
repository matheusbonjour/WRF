% Código para extrair algumas variáveis do modelo WRF

clear all
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in3=['D:\Dados TCC\2016\'];
dadosboia = [path_in,'historico_vitoria.txt'];
dados = readtable(dadosboia)
ncfile = [path_in3,'d03_default_201607'];
ncfilet = [path_in3,'d03_201601_sst'];
% ncdisp(ncfile);
shpfile = [path_in2, 'LINHA_DE_COSTA_IMAGEM_GEOCOVER_SIRGAS_2000','.shp']
% s = shaperead(shpfile,'UseGeoCoords',true)
% LAT = (s.Lat);
% LON = (s.Lon);

% t2m = ncread(ncfile,'T2');

% t2mt = ncread(ncfilet,'T2');
% t2m = t2m(:,:,);
% t2mt = t2mt(:,:,1);

% 
% sfc_pressure = ncread(ncfile,'PSFC');
% sfc_pressuret = ncread(ncfilet,'PSFC');

% psfc = sfc_pressure(:,:,1);
% psfct = sfc_pressuret(:,:,1);

% lat=ncread(ncfile,'XLAT');
% truelat = lat(:,:,1);
% % ncdisp(ncfile);
% lon=ncread(ncfile,'XLONG');
% truelon = lon(:,:,1);

lat_sst01=ncread(ncfilet,'XLAT');
% truelatt = lat(:,:,1);
% ncdisp(ncfile);
lon_sst01=ncread(ncfilet,'XLONG');
% truelont = lon(:,:,1);

u10m_sst01 = ncread(ncfilet,'U10');
v10m_sst01 = ncread(ncfilet,'V10');

tempo_sst01 = ncread(ncfilet,'XTIME');

% figure(1)
% pcolor(truelon, truelat, t2m);colorbar
% 
% figure(2)
% pcolor(truelont, truelatt, t2mt);colorbar