clear all
close all
clc


path_in=['C:\Users\matheus\Documents\gis4wrf\projects\TCC_TESTE\run_wrf\'];
path_in2=['C:\Users\matheus\Documents\gis4wrf\projects\TCC_TESTE\run_wrf\OSM_BRA_coastline\'];
path_out=['D:\cbnovo\'];
ncfile = [path_in,'wrfout_d02_2016-01-23_16_40_00'];
ncdisp(ncfile);
shpfile = [path_in2, 'LINHA_DE_COSTA_IMAGEM_GEOCOVER_SIRGAS_2000','.shp']
s = shaperead(shpfile,'UseGeoCoords',true)
LAT = (s.Lat);
LON = (s.Lon);

lat=ncread(ncfile,'XLAT');
truelat = lat(:,:,1);
ncdisp(ncfile);
lon=ncread(ncfile,'XLONG');
truelon = lon(:,:,1);
uvel = ncread(ncfile,'U');
true_uvel = uvel(1:36, :, 1, 1);

vvel = ncread(ncfile,'V');
true_vvel = vvel(:, 1:36, 1, 1);


figure(1)

tv = interp2(true_vvel);
tu = interp2(true_uvel);
tlt = interp2(truelat);
tln = interp2(truelon);


velvec = (abs(tu) .* abs(tv))*0.12;

i = 4;
m_proj('lambert','lat',[-24 -16],'lon',[-44 -36]);
m_line(LON(1,:),LAT(1,:),'color','k','linewidth',1.5);
m_grid('box','fancy','linestyle','-','gridcolor','k','fontsize',12,'fontweight','bold');
hold on;
imgg2 = m_contourf(tln,tlt,velvec,70,'edgecolor','none');
c2 = colorbar
colormap hsv
c2.Label.String = 'Velocidade do vento (m/s)';
hold on
imgg = m_quiver(tln(1:i:end,1:i:end),tlt(1:i:end,1:i:end),tu(1:i:end,1:i:end),tv(1:i:end,1:i:end),2,'color','k', 'linewidth',1.4);
xlabel('Longitude','fontsize',14,'fontweight','bold');
ylabel('Latitude','fontsize',14,'fontweight','bold');
title(['Vento a 10m sobre o estado do Espírito Santo    '; 'Modelo WRF (Resolução: 9km) - 23/01/2016 - 16:00'],'fontsize',14,'fontweight','bold');
set(gca,'Fontsize',18,'fontweight','bold')