%% **** HS Ilha Rasa **** %%

%*****************CARREGAR VARIAVEIS HS*************************%

for j = 17:21    %Dia%
for i = 0:3:21 %Hora%
  if i<12
   eval(['HS_201602' num2str(j) '_0' num2str(i) '0000 = double(HS_201602' num2str(j) '_0' num2str(i) '0000);']);
  else
   eval(['HS_201602' num2str(j) '_' num2str(i) '0000 = double(HS_201602' num2str(j) '_' num2str(i) '0000);']);
  end
end
end

%*******************RECORTAR HS ILHA RASA ********************%

for j = 17:21
for i = 0:3:21
  if i < 12
   eval(['HS_201602' num2str(j) '_0' num2str(i) '0000 = HS_201602' num2str(j) '_0' num2str(i) '0000(1:155,100:300);'])
  else
   eval(['HS_201602' num2str(j) '_' num2str(i) '0000 = HS_201602' num2str(j) '_' num2str(i) '0000(1:155,100:300);'])
  end
end
end

%********RECORTAR LON_LAT ILHA RASA*********%

load lon_100_bg.prn
load lat_100_bg.prn

lon_100_rasa = lon_100_bg(1:155,100:300);
lat_100_rasa = lat_100_bg(1:155,100:300);

%% PLOT ILHA RASA %%

load coastline_bg.mat

scale = 0.4;
for j = 17:21    %Dia%
for i = 0:3:21 %Hora%
  if i<12
   f = figure;
   set(f,'name',['ondas_201602' num2str(j) '_0' num2str(i) ''],'numbertitle','off');
   eval(['quiver (lon_100_rasa(1:10:end,1:10:end),lat_100_rasa(1:10:end,1:10:end),uvel_201602' num2str(j) '_0' num2str(i) '0000 (1:10:end,1:10:end),vvel_201602' num2str(j) '_0' num2str(i) '0000(1:10:end,1:10:end),scale,''k'')']);
   hold on;
   eval(['pcolor(lon_100_rasa,lat_100_rasa,HS_201602' num2str(j) '_0' num2str(i) '0000); shading interp; axis equal;']);  %Looping com 'eval' variando o nome da vari�vel com 'num2str'%
   eval(['title('' Altura Significativa e Direção de Onda - ' num2str(j) '/02/2016 - 0' num2str(i) 'H'',''FontSize'',10'');']); %Looping com 'eval' variando o dia e hora no t�tulo com 'num2str'%
   h = colorbar;
   contourcmap (0:0.2:3.0,'jet','h','on')
   ylabel(h,'(metros)');
   text(-43.1965,-22.9785,'Praia de Copacabana','FontSize',8.2','Rotation',36);
   text(-43.1510,-23.0570,'Ilha Rasa','FontSize',6');
   text(-43.0900,-22.9930,'Ilha do Pai','FontSize',6');
   text(-43.0640,-22.9880,'Ilha da Mãe','FontSize',6');
   hold on;
   plot(lon,lat,'k','LineWidth',1.18);axis([-43.22 -43.05 -23.07 -22.96]);
   saveas(f,['ondas_201602' num2str(j) '_0' num2str(i) ''],'png');
   close(['ondas_201602' num2str(j) '_0' num2str(i) '']);
  else
   f = figure;
   set(f,'name',['ondas_201602' num2str(j) '_' num2str(i) ''],'numbertitle','off');
   eval(['quiver (lon_100_rasa(1:10:end,1:10:end),lat_100_rasa(1:10:end,1:10:end),uvel_201602' num2str(j) '_' num2str(i) '0000(1:10:end,1:10:end),vvel_201602' num2str(j) '_' num2str(i) '0000(1:10:end,1:10:end),scale,''k'')']);
   hold on;
   eval(['pcolor(lon_100_rasa,lat_100_rasa,HS_201602' num2str(j) '_' num2str(i) '0000); shading interp; axis equal;'])
   eval(['title('' Altura Significativa e Direção de Onda - ' num2str(j) '/02/2016 - ' num2str(i) 'H'',''FontSize'',10'');'])
   h = colorbar;
   contourcmap (0:0.2:3.0,'jet','h','on');
   ylabel(h,'(metros)');
   text(-43.1965,-22.9785,'Praia de Copacabana','FontSize',8.2','Rotation',36);
   text(-43.1510,-23.0570,'Ilha Rasa','FontSize',6');
   text(-43.0900,-22.9930,'Ilha do Pai','FontSize',6');
   text(-43.0640,-22.9880,'Ilha da Mãe','FontSize',6');
   hold on;
   plot(lon,lat,'k','LineWidth',1.19);axis([-43.22 -43.05 -23.07 -22.96]);
   saveas(f,['ondas_201602' num2str(j) '_' num2str(i) ''],'png');
   close(['ondas_201602' num2str(j) '_' num2str(i) '']);
   end
end
end

