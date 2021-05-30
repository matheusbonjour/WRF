% Código para obtenção da diferença de TSM de diferentes entradas no WRF.

clear all
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['C:\Users\matheus\Desktop\TCCfinal\'];

path_in3=['D:\Dados TCC\2016\'];
path_in4=['D:\Dados TCC\avaliar_modelo\'];

ncfile3 = [path_in4,'d03_default_201607'];
ncfile3t = [path_in3,'d03_201607_sst'];


% ncdisp(ncfile);
shpfile = [path_in2, 'LINHA_DE_COSTA_IMAGEM_GEOCOVER_SIRGAS_2000','.shp']
s = shaperead(shpfile,'UseGeoCoords',true)
LAT = (s.Lat);
LON = (s.Lon);

% for hora = 06:12:18;

hora = 06;
d2 = 24;
dia2 = 0* d2;
dia = 361 + dia2 + hora;

lat3=ncread(ncfile3,'XLAT');
truelat3 = lat3(:,:,dia);
% ncdisp(ncfile);
lon3=ncread(ncfile3,'XLONG');
truelon3 = lon3(:,:,dia);

lat3t=ncread(ncfile3t,'XLAT');
truelat3t = lat3t(:,:,dia);
% ncdisp(ncfile);
lon3t=ncread(ncfile3t,'XLONG');
truelon3t = lon3t(:,:,dia);

sst3 = ncread(ncfile3,'SST');
truesst3 = sst3(:,:,dia);
truesst3 = truesst3-273;

sst3t = ncread(ncfile3t,'SST');
truesst3t = sst3t(:,:,dia);
truesst3t = truesst3t-273;

landmask3=ncread(ncfile3,'LANDMASK');
ld3=landmask3(:,:,dia);
sst3=truesst3;
sst3(ld3==1)=nan;

landmask3t=ncread(ncfile3t,'LANDMASK');
ld3t=landmask3t(:,:,dia);
sst3t=truesst3t;
sst3t(ld3t==1)=nan;


% sst3 = interp2(sst3);
% truelat3 = interp2(truelat3);
% truelon3 = interp2(truelon3);
% 
% sst3t = interp2(sst3t);
% truelat3t = interp2(truelat3t);
% truelon3t = interp2(truelon3t);

% figure(3+hora)
% subplot(1,2,1)
% % pcolor(truelon1, truelat1, sst1);caxis([26,28]);colorbar
% % axis equal
% 
% latmin = double(min(min(truelat3)));
% latmax = double(max(max(truelat3)));
% lonmin = double(min(min(truelon3)));
% lonmax = double(max(max(truelon3)));
% % i = 4;
% m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
% m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% hold on;
% imgg2 = m_contourf(truelon3,truelat3,sst3,100,'edgecolor','none');
% c2 = colorbar
% colormap jet
% caxis([25,28]);
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% xlabel('Longitude','fontsize',14,'fontweight','bold');
% ylabel('Latitude','fontsize',14,'fontweight','bold');
% title(sprintf('TSM-GFS (Grade: 3km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
% set(gca,'Fontsize',18,'fontweight','bold')
% 
% hold on
% subplot(1,2,2)
% 
latmin = double(min(min(truelat3t)));
latmax = double(max(max(truelat3t)));
lonmin = double(min(min(truelon3t)));
lonmax = double(max(max(truelon3t)));
% % pcolor(truelon2, truelat2, sst2);caxis([26,28]);colorbar
% m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
% m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% hold on;
% imgg2 = m_contourf(truelon3t,truelat3t,sst3t,100,'edgecolor','none');
% c2 = colorbar
% colormap jet
% caxis([25,28]);
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% xlabel('Longitude','fontsize',14,'fontweight','bold');
% ylabel('Latitude','fontsize',14,'fontweight','bold');
% title(sprintf('TSM-RTG (Grade: 3km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
% set(gca,'Fontsize',18,'fontweight','bold')

figure(1)
tsm_erro = sst3 - sst3t;

% pcolor(truelon2, truelat2, sst2);caxis([26,28]);colorbar
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;

hold on
imgg2 = m_contourf(truelon3t,truelat3t,tsm_erro,100, 'edgecolor','none');
hold on
imgg2 = m_contour(truelon3t,truelat3t,tsm_erro,[0 0],'Showtext','on','color','k');

% imgg2 = m_contour(truelon3t,truelat3t,tsm_erro,[0 0]);
c2 = colorbar
colormap jet
% caxis([25,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('Diferença de TSM (Grade: 3km) - 15/01/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')

figure(2)

[row, column] = find(tsm_erro == min(min(tsm_erro)))
% [row, column] = find(tsm_erro == 0)

figure(2)
% row = 97;
% column = 75;
tsm_erro2 = tsm_erro;
tsm_erro2(row,column) = 10;

m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on
imgg2 = m_contourf(truelon3t,truelat3t,tsm_erro2,100, 'edgecolor','none');
hold on
imgg2 = m_contour(truelon3t,truelat3t,tsm_erro,[0 0],'Showtext','on','color','k');

c2 = colorbar
colormap jet
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('Diferença de TSM (Grade: 3km) - 15/01/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')
