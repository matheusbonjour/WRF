% Código criado para visualização dos campos de temperatura da superfície 
% do mar dos dados de entrada no modelo WRF

clear all
close all
clc

% Essas variáveis são definidas pelo próprio usuário, onde estarão os
% diretórios com os dados do WRF e observacionais
path_in=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in2=['C:\Users\matheus\Desktop\TCCfinal\'];
path_in3=['D:\Dados TCC\2016\'];
path_in4=['D:\Dados TCC\avaliar_modelo\'];

% ncfile1 = [path_in4,'d03_default_201607'];
% ncfile1t = [path_in3,'d03_201607_sst'];

ncfile1 = [path_in4,'d01_default_201607'];
ncfile2 = [path_in4,'d02_default_201607'];
ncfile3 = [path_in4,'d03_default_201607'];
ncfile1t = [path_in3,'d01_201607_sst'];    
ncfile2t = [path_in3,'d02_201607_sst'];
ncfile3t = [path_in3,'d03_201607_sst'];
% ncdisp(ncfile);
shpfile = [path_in2, 'LINHA_DE_COSTA_IMAGEM_GEOCOVER_SIRGAS_2000','.shp']
s = shaperead(shpfile,'UseGeoCoords',true)
LAT = (s.Lat);
LON = (s.Lon);

for hora = 00:06:18;
d2 = 24;
dia2 = 7 * d2;
dia = 361 + dia2 + hora;

lat1=ncread(ncfile1,'XLAT');
truelat1 = lat1(:,:,dia);
% ncdisp(ncfile);
lon1=ncread(ncfile1,'XLONG');
truelon1 = lon1(:,:,dia);

lat2=ncread(ncfile2,'XLAT');
truelat2 = lat2(:,:,dia);
% ncdisp(ncfile);
lon2=ncread(ncfile2,'XLONG');
truelon2 = lon2(:,:,dia);

lat3=ncread(ncfile3,'XLAT');
truelat3 = lat3(:,:,dia);
% ncdisp(ncfile);
lon3=ncread(ncfile3,'XLONG');
truelon3 = lon3(:,:,dia);

lat1t=ncread(ncfile1t,'XLAT');
truelat1t = lat1t(:,:,dia);
% ncdisp(ncfile);
lon1t=ncread(ncfile1t,'XLONG');
truelon1t = lon1t(:,:,dia);

lat2t=ncread(ncfile2t,'XLAT');
truelat2t = lat2t(:,:,dia);
% ncdisp(ncfile);
lon2t=ncread(ncfile2t,'XLONG');
truelon2t = lon2t(:,:,dia);

lat3t=ncread(ncfile3t,'XLAT');
truelat3t = lat3t(:,:,dia);
% ncdisp(ncfile);
lon3t=ncread(ncfile3t,'XLONG');
truelon3t = lon3t(:,:,dia);

sst1 = ncread(ncfile1,'SST');
truesst1 = sst1(:,:,dia);
truesst1 = truesst1-273;
sst2 = ncread(ncfile2,'SST');
truesst2 = sst2(:,:,dia);
truesst2 = truesst2-273;
sst3 = ncread(ncfile3,'SST');
truesst3 = sst3(:,:,dia);
truesst3 = truesst3-273;

sst1t = ncread(ncfile1t,'SST');
truesst1t = sst1t(:,:,dia);
truesst1t = truesst1t-273;
sst2t = ncread(ncfile2t,'SST');
truesst2t = sst2t(:,:,dia);
truesst2t = truesst2t-273;
sst3t = ncread(ncfile3t,'SST');
truesst3t = sst3t(:,:,dia);
truesst3t = truesst3t-273;

landmask1=ncread(ncfile1,'LANDMASK');
ld1=landmask1(:,:,dia);
sst1=truesst1;
sst1(ld1==1)=nan;
landmask2=ncread(ncfile2,'LANDMASK');
ld2=landmask2(:,:,dia);
sst2=truesst2;
sst2(ld2==1)=nan;
landmask3=ncread(ncfile3,'LANDMASK');
ld3=landmask3(:,:,dia);
sst3=truesst3;
sst3(ld3==1)=nan;

landmask1t=ncread(ncfile1t,'LANDMASK');
ld1t=landmask1t(:,:,dia);
sst1t=truesst1t;
sst1t(ld1t==1)=nan;
landmask2t=ncread(ncfile2t,'LANDMASK');
ld2t=landmask2t(:,:,dia);
sst2t=truesst2t;
sst2t(ld2t==1)=nan;
landmask3t=ncread(ncfile3t,'LANDMASK');
ld3t=landmask3t(:,:,dia);
sst3t=truesst3t;
sst3t(ld3t==1)=nan;



sst1 = interp2(sst1);
truelat1 = interp2(truelat1);
truelon1 = interp2(truelon1);

sst2 = interp2(sst2);
truelat2 = interp2(truelat2);
truelon2 = interp2(truelon2);

sst3 = interp2(sst3);
truelat3 = interp2(truelat3);
truelon3 = interp2(truelon3);

sst1t = interp2(sst1t);
truelat1t = interp2(truelat1t);
truelon1t = interp2(truelon1t);

sst2t = interp2(sst2t);
truelat2t = interp2(truelat2t);
truelon2t = interp2(truelon2t);

sst3t = interp2(sst3t);
truelat3t = interp2(truelat3t);
truelon3t = interp2(truelon3t);

%1
figure(1+hora)
subplot(1,2,1)

latmin = double(min(min(truelat1)));
latmax = double(max(max(truelat1)));
lonmin = double(min(min(truelon1)));
lonmax = double(max(max(truelon1)));
% i = 4;
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(truelon1,truelat1,sst1,100,'edgecolor','none');
c2 = colorbar
colormap jet
caxis([23,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('TSM-GFS (Grade: 27km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')

hold on
subplot(1,2,2)

latmin = double(min(min(truelat1t)));
latmax = double(max(max(truelat1t)));
lonmin = double(min(min(truelon1t)));
lonmax = double(max(max(truelon1t)));
% pcolor(truelon2, truelat2, sst2);caxis([26,28]);colorbar
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(truelon1t,truelat1t,sst1t,100,'edgecolor','none');
c2 = colorbar
colormap jet
caxis([23,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('TSM-RTG (Grade: 27km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')

figure(2+hora)
subplot(1,2,1)
% pcolor(truelon1, truelat1, sst1);caxis([26,28]);colorbar
% axis equal

latmin = double(min(min(truelat2)));
latmax = double(max(max(truelat2)));
lonmin = double(min(min(truelon2)));
lonmax = double(max(max(truelon2)));
% i = 4;
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(truelon2,truelat2,sst2,100,'edgecolor','none');
c2 = colorbar
colormap jet
caxis([23,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('TSM-GFS (Grade: 9km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')

hold on
subplot(1,2,2)

latmin = double(min(min(truelat2t)));
latmax = double(max(max(truelat2t)));
lonmin = double(min(min(truelon2t)));
lonmax = double(max(max(truelon2t)));
% pcolor(truelon2, truelat2, sst2);caxis([26,28]);colorbar
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(truelon2t,truelat2t,sst2t,100,'edgecolor','none');
c2 = colorbar
colormap jet
caxis([23,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('TSM-RTG (Grade: 9km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')


figure(3+hora)
subplot(1,2,1)
% pcolor(truelon1, truelat1, sst1);caxis([26,28]);colorbar
% axis equal

latmin = double(min(min(truelat3)));
latmax = double(max(max(truelat3)));
lonmin = double(min(min(truelon3)));
lonmax = double(max(max(truelon3)));
% i = 4;
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(truelon3,truelat3,sst3,100,'edgecolor','none');
c2 = colorbar
colormap jet
caxis([23,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('TSM-GFS (Grade: 3km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')

hold on
subplot(1,2,2)

latmin = double(min(min(truelat3t)));
latmax = double(max(max(truelat3t)));
lonmin = double(min(min(truelon3t)));
lonmax = double(max(max(truelon3t)));
% pcolor(truelon2, truelat2, sst2);caxis([26,28]);colorbar
m_proj('lambert','lat',[latmin latmax],'lon',[lonmin lonmax]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(truelon3t,truelat3t,sst3t,100,'edgecolor','none');
c2 = colorbar
colormap jet
caxis([23,28]);
c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(sprintf('TSM-RTG (Grade: 3km) - 22/07/2016 - %02d:00',hora),'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')

end






















% % i = 4;
% % m_proj('lambert','lat',[-21.07 -18.4],'lon',[-41.3 -38.5]);
% % m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% % m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% % hold on;
% % imgg2 = m_contourf(tln,tlt,tsst,70,'edgecolor','none');
% c2 = colorbar
% colormap hsv
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% % hold on
% % % imgg = m_quiver(tln(1:i:end,1:i:end),tlt(1:i:end,1:i:end),tu(1:i:end,1:i:end),tv(1:i:end,1:i:end),2,'color','k', 'linewidth',1.4);
% % xlabel('Longitude','fontsize',14,'fontweight','bold');
% % ylabel('Latitude','fontsize',14,'fontweight','bold');
% % 
% % title(['Temperatura da superfície do mar no litoral Sudeste do Brasil '; 'Modelo WRF (Resolução: 09km) - 01/01/2013 - 00:00             '],'fontsize',14,'fontweight','bold');
% % set(gca,'Fontsize',18,'fontweight','bold')
% %3
% subplot(3,2,5)
% pcolor(truelon3, truelat3, sst3);caxis([26,28]);colorbar
% axis equal
% 
% % i = 4;
% % m_proj('lambert','lat',[-21.07 -18.4],'lon',[-41.3 -38.5]);
% % m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% % m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% % hold on;
% % imgg2 = m_contourf(tln,tlt,tsst,70,'edgecolor','none');
% c2 = colorbar
% colormap hsv
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% hold on
% % hold on
% % % imgg = m_quiver(tln(1:i:end,1:i:end),tlt(1:i:end,1:i:end),tu(1:i:end,1:i:end),tv(1:i:end,1:i:end),2,'color','k', 'linewidth',1.4);
% % xlabel('Longitude','fontsize',14,'fontweight','bold');
% % ylabel('Latitude','fontsize',14,'fontweight','bold');
% % 
% % title(['Temperatura da superfície do mar no litoral Sudeste do Brasil '; 'Modelo WRF (Resolução: 09km) - 01/01/2013 - 00:00             '],'fontsize',14,'fontweight','bold');
% % set(gca,'Fontsize',18,'fontweight','bold')
% %4
% subplot(3,2,2)
% pcolor(truelon1t, truelat1t, sst1t);caxis([26,28]);colorbar
% axis equal
% 
% % i = 4;
% % m_proj('lambert','lat',[-21.07 -18.4],'lon',[-41.3 -38.5]);
% % m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% % m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% % hold on;
% % imgg2 = m_contourf(tln,tlt,tsst,70,'edgecolor','none');
% c2 = colorbar
% colormap hsv
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% hold on
% % % imgg = m_quiver(tln(1:i:end,1:i:end),tlt(1:i:end,1:i:end),tu(1:i:end,1:i:end),tv(1:i:end,1:i:end),2,'color','k', 'linewidth',1.4);
% % xlabel('Longitude','fontsize',14,'fontweight','bold');
% % ylabel('Latitude','fontsize',14,'fontweight','bold');
% % 
% % title(['Temperatura da superfície do mar no litoral Sudeste do Brasil '; 'Modelo WRF (Resolução: 27km) - 01/01/2013 - 00:00             '],'fontsize',14,'fontweight','bold');
% % set(gca,'Fontsize',18,'fontweight','bold')
% %5
% subplot(3,2,4)
% pcolor(truelon2t, truelat2t, sst2t);caxis([26,28]);colorbar
% axis equal
% 
% % i = 4;
% % m_proj('lambert','lat',[-21.07 -18.4],'lon',[-41.3 -38.5]);
% % m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% % m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% % hold on;
% % imgg2 = m_contourf(tln,tlt,tsst,70,'edgecolor','none');
% c2 = colorbar
% colormap hsv
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% hold on
% % hold on
% % % imgg = m_quiver(tln(1:i:end,1:i:end),tlt(1:i:end,1:i:end),tu(1:i:end,1:i:end),tv(1:i:end,1:i:end),2,'color','k', 'linewidth',1.4);
% % xlabel('Longitude','fontsize',14,'fontweight','bold');
% % ylabel('Latitude','fontsize',14,'fontweight','bold');
% % 
% % title(['Temperatura da superfície do mar no litoral Sudeste do Brasil '; 'Modelo WRF (Resolução: 09km) - 01/01/2013 - 00:00             '],'fontsize',14,'fontweight','bold');
% % set(gca,'Fontsize',18,'fontweight','bold')
% %6
% subplot(3,2,6)
% pcolor(truelon3t, truelat3t, sst3t);caxis([26,28]);colorbar
% axis equal
% 
% % i = 4;
% % m_proj('lambert','lat',[-21.07 -18.4],'lon',[-41.3 -38.5]);
% % m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
% % m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
% % hold on;
% % imgg2 = m_contourf(tln,tlt,tsst,70,'edgecolor','none');
% c2 = colorbar
% colormap hsv
% c2.Label.String = 'Temperatura da Superfície do Mar (°C)';
% hold on
% % hold on
% % % imgg = m_quiver(tln(1:i:end,1:i:end),tlt(1:i:end,1:i:end),tu(1:i:end,1:i:end),tv(1:i:end,1:i:end),2,'color','k', 'linewidth',1.4);
% % xlabel('Longitude','fontsize',14,'fontweight','bold');
% % ylabel('Latitude','fontsize',14,'fontweight','bold');
% % 
% % title(['Temperatura da superfície do mar no litoral Sudeste do Brasil '; 'Modelo WRF (Resolução: 09km) - 01/01/2013 - 00:00             '],'fontsize',14,'fontweight','bold');
% % set(gca,'Fontsize',18,'fontweight','bold')

