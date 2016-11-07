%****** CARREGA VARIAVEIS DIR ****%



for j = 17:21    %Dia%
    for i = 0:3:21 %Hora%
     if i<12
        eval(['HS_201602' num2str(j) '_0' num2str(i) '0000 = double(HS_201602' num2str(j) '_0' num2str(i) '0000);']);
     else 
       eval(['HS_201602' num2str(j) '_' num2str(i) '0000 = double(HS_201602' num2str(j) '_' num2str(i) '0000);']);
     end
    end 
end


%% ********* � NECESSARIO CONVERTER AS VARIAVEIS 'DIR' DE GRAUS PARA METROS (U e V) COM O SCRIPT_1 ********** %%
           % APOS CONVERTER, CONTINUAR A PARTIR DAQUI %


%***********GERAR FIGURAS E SAVAR *******%

load lon_bg_laje.prn
load lat_bg_laje.prn
load coastline_bg.mat


scale = 0.9;
for j = 17:21    %Dia%
   for i = 0:3:21 %Hora%
    if i<12
     f = figure;
     set(f,'name',['ondas_201602' num2str(j) '_0' num2str(i) ''],'numbertitle','off');
     eval(['quiver (lon_bg_laje(1:9:end,1:9:end),lat_bg_laje(1:9:end,1:9:end),uvel_201602' num2str(j) '_0' num2str(i) '0000 (1:9:end,1:9:end),vvel_201602' num2str(j) '_0' num2str(i) '0000(1:9:end,1:9:end),scale,''k'')']);
     hold on;
     eval(['pcolor(lon_bg_laje,lat_bg_laje,HS_201602' num2str(j) '_0' num2str(i) '0000); shading interp; axis equal;']);  %Looping com 'eval' variando o nome da vari�vel com 'num2str'%
     eval(['title('' Altura Significativa e Direção de Onda - Baía de Guanabara - ' num2str(j) '/02/2016 - 0' num2str(i) 'H'');']); %Looping com 'eval' variando o dia e hora no t�tulo com 'num2str'%
     h = colorbar;
     contourcmap (0:0.2:3.0,'jet','h','on'); %Escala%
     ylabel(h,'(metros)');
     hold on;
     plot(lon,lat,'k','LineWidth',1);
     saveas(f,['ondas_201602' num2str(j) '_0' num2str(i) ''],'png');
     close(['ondas_201602' num2str(j) '_0' num2str(i) '']);
    else
     f = figure;
     set(f,'name',['ondas_201602' num2str(j) '_' num2str(i) ''],'numbertitle','off');
     eval(['quiver (lon_bg_laje(1:9:end,1:9:end),lat_bg_laje(1:9:end,1:9:end),uvel_201602' num2str(j) '_' num2str(i) '0000(1:9:end,1:9:end),vvel_201602' num2str(j) '_' num2str(i) '0000(1:9:end,1:9:end),scale,''k'')']); 
     hold on;
     eval(['pcolor(lon_bg_laje,lat_bg_laje,HS_201602' num2str(j) '_' num2str(i) '0000); shading interp; axis equal;'])
     eval(['title('' Altura Significativa e Direção de Onda - Baía de Guanabara - ' num2str(j) '/02/2016 - ' num2str(i) 'H'');']);
     h = colorbar;
     contourcmap (0:0.2:3.0,'jet','h','on'); %Escala%
     ylabel(h,'(metros)');
     hold on;
     plot(lon,lat,'k','LineWidth',1);
     saveas(f,['ondas_201602' num2str(j) '_' num2str(i) ''],'png');
     close(['ondas_201602' num2str(j) '_' num2str(i) '']);
   end
   end
end
