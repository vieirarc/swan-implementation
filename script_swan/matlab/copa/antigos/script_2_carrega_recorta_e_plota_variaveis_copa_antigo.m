
load hs_copa.mat

cd resultado/ 

for j = 16:20    %Dia%
    for i = 0:3:21 %Hora%
     if i<12
        eval(['HS_201609' num2str(j) '_0' num2str(i) '0000 = double(HS_201609' num2str(j) '_0' num2str(i) '0000);']);
     else 
       eval(['HS_201609' num2str(j) '_' num2str(i) '0000 = double(HS_201609' num2str(j) '_' num2str(i) '0000);']);
     end
    end 
end


%% ********* � NECESSARIO CONVERTER AS VARIAVEIS 'DIR' DE GRAUS PARA METROS (U e V) COM O SCRIPT_1 ********** %%
           % APOS CONVERTER, CONTINUAR A PARTIR DAQUI %


%*******************RECORTAR HS_U_V_COPA ********************%

for j = 16:20
for i = 0:3:21
if i < 12
eval(['HS_201609' num2str(j) '_0' num2str(i) '0000 = HS_201609' num2str(j) '_0' num2str(i) '0000(91:120,134:170);'])
else
eval(['HS_201609' num2str(j) '_' num2str(i) '0000 = HS_201609' num2str(j) '_' num2str(i) '0000(91:120,134:170);'])
end
end
end

%********RECORTAR LON_LAT COPA*********%
load lon_100_bg.prn
load lat_100_bg.prn

lon_100_copa = lon_100_bg(91:120,134:170);
lat_100_copa = lat_100_bg(91:120,134:170);


%*********INTERPOLACAO PARA 20 METROS HS, U, e V ************************%

lat_20_bg = -22.9870:20/111112:-22.9610;

lon_20_bg = -43.1955:20/111112:-43.1631;

[mlon20_copa, mlat20_copa] = meshgrid(lon_20_bg,lat_20_bg);


for j = 16:20    %Dia%
   for i = 0:3:21 %Hora%
    if i<12 
     eval(['HS_20_201609' num2str(j) '_0' num2str(i) '0000 =griddata(lon_100_copa,lat_100_copa,HS_201609' num2str(j) '_0' num2str(i) '0000 ,mlon20_copa,mlat20_copa);'])
     eval(['uvel_20_201609' num2str(j) '_0' num2str(i) '0000 =griddata(lon_100_copa,lat_100_copa,uvel_201609' num2str(j) '_0' num2str(i) '0000 ,mlon20_copa,mlat20_copa);'])
     eval(['vvel_20_201609' num2str(j) '_0' num2str(i) '0000 =griddata(lon_100_copa,lat_100_copa,vvel_201609' num2str(j) '_0' num2str(i) '0000 ,mlon20_copa,mlat20_copa);'])
    else 
     eval(['HS_20_201609' num2str(j) '_' num2str(i) '0000 =griddata(lon_100_copa,lat_100_copa,HS_201609' num2str(j) '_' num2str(i) '0000 ,mlon20_copa,mlat20_copa);'])
     eval(['uvel_20_201609' num2str(j) '_' num2str(i) '0000 =griddata(lon_100_copa,lat_100_copa,uvel_201609' num2str(j) '_' num2str(i) '0000 ,mlon20_copa,mlat20_copa);'])
     eval(['vvel_20_201609' num2str(j) '_' num2str(i) '0000 =griddata(lon_100_copa,lat_100_copa,vvel_201609' num2str(j) '_' num2str(i) '0000 ,mlon20_copa,mlat20_copa);'])
   end
   end
end


%***********GERAR FIGURAS E SAVAR - HS_DIR 20 METROS - COPA*******%

load lat_lon_costa_copa


scale = 0.5;
for j = 16:20    %Dia%
   for i = 0:3:21 %Hora%
    if i<12
     f = figure;
     set(f,'name',['COB_ocn_ondas_copa_bg_201609' num2str(j) '_0' num2str(i) '0000_9999'],'numbertitle','off');
     eval(['quiver (mlon20_copa(1:5:end,1:5:end),mlat20_copa(1:5:end,1:5:end),uvel_20_201609' num2str(j) '_0' num2str(i) '0000 (1:5:end,1:5:end),vvel_20_201609' num2str(j) '_0' num2str(i) '0000(1:5:end,1:5:end),scale,''k'')']);
     hold on;
     eval(['pcolor(mlon20_copa,mlat20_copa,HS_20_201609' num2str(j) '_0' num2str(i) '0000); shading interp; axis equal;']);  %Looping com 'eval' variando o nome da vari�vel com 'num2str'%
     eval(['title('' Altura Significativa e Direção de Onda - Praia de Copacabana - ' num2str(j) '/09/2016 - 0' num2str(i) 'H'');']); %Looping com 'eval' variando o dia e hora no t�tulo com 'num2str'%
     h = colorbar;
     contourcmap (0:0.2:4.0,'jet','h','on'); %Escala%
     ylabel(h,'(metros)');
     text(-43.1798,-22.9668,'.','FontSize',60')
     text(-43.1800,-22.96566,'Hotel','FontSize',10')
     text(-43.1800,-22.96636,'Copacabana','FontSize',10')
     text(-43.1800,-22.96706,'Palace','FontSize',10')
     text(-43.1678,-22.9623,'Leme','FontSize',10')
     text(-43.1898,-22.9806,'.','FontSize',60')
     text(-43.1928,-22.9824,'Posto 5','FontSize',10')
     text(-43.193,-22.9856,'Forte de','FontSize',10')
     text(-43.193,-22.9866,'Copacabana','FontSize',10')
     hold on;
     plot(lon_costa_copa,lat_costa_copa,'k','LineWidth',1);
     saveas(f,['COB_ocn_ondas_copa_bg_201609' num2str(j) '_0' num2str(i) '0000_9999'],'png');
     close(['COB_ocn_ondas_copa_bg_201609' num2str(j) '_0' num2str(i) '0000_9999']);
    else
     f = figure;
     set(f,'name',['COB_ocn_ondas_copa_bg_201609' num2str(j) '_' num2str(i) '0000_9999'],'numbertitle','off');
     eval(['quiver (mlon20_copa(1:5:end,1:5:end),mlat20_copa(1:5:end,1:5:end),uvel_20_201609' num2str(j) '_' num2str(i) '0000(1:5:end,1:5:end),vvel_20_201609' num2str(j) '_' num2str(i) '0000(1:5:end,1:5:end),scale,''k'')']); 
     hold on;
     eval(['pcolor(mlon20_copa,mlat20_copa,HS_20_201609' num2str(j) '_' num2str(i) '0000); shading interp; axis equal;'])
     eval(['title('' Altura Significativa e Direção de Onda - Praia de Copacabana - ' num2str(j) '/09/2016 - ' num2str(i) 'H'');']);
     h = colorbar;
     contourcmap (0:0.2:4.0,'jet','h','on'); %Escala
     ylabel(h,'(metros)');
     text(-43.1798,-22.9668,'.','FontSize',60')
     text(-43.1800,-22.96566,'Hotel','FontSize',10')
     text(-43.1800,-22.96636,'Copacabana','FontSize',10')
     text(-43.1800,-22.96706,'Palace','FontSize',10')
     text(-43.1678,-22.9623,'Leme','FontSize',10')
     text(-43.1898,-22.9806,'.','FontSize',60')
     text(-43.1928,-22.9824,'Posto 5','FontSize',10')
     text(-43.193,-22.9856,'Forte de','FontSize',10')
     text(-43.193,-22.9866,'Copacabana','FontSize',10')
     hold on;
     plot(lon_costa_copa,lat_costa_copa,'k','LineWidth',1);
     saveas(f,['COB_ocn_ondas_copa_bg_201609' num2str(j) '_' num2str(i) '0000_9999'],'png');
     close(['COB_ocn_ondas_copa_bg_201609' num2str(j) '_' num2str(i) '0000_9999']);
   end
   end
end

