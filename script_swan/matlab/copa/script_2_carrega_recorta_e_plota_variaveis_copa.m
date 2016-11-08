
%*****************CARREGAR VARIAVEIS HS*************************%  
load(fullfile(mypath,datestr(hoje,'yyyymmdd'),'hs_copa.mat'))

pathbat = '/home/rafael/Documentos/lamce/dados/bat_100_bg';

hoje = datenum(date);

for j = hoje:1/8:hoje+5-3/24
    
     eval(['HS_',datestr(j,'yyyymmdd_HHMMSS'),' = double(HS_',datestr(j,'yyyymmdd_HHMMSS'),');']);
end

x1 = 91;
x2 = 120;
y1 = 134;
y2 = 170;

for j = hoje:1/8:hoje+5-3/24
    
     eval(['HS_',datestr(j,'yyyymmdd_HHMMSS'),' = HS_',datestr(j,'yyyymmdd_HHMMSS'),'(x1:x2,y1:y2);'])
end;



%********RECORTAR LON_LAT COPA*********%
load (fullfile(pathbat,'lon_100_bg.prn'));
load (fullfile(pathbat,'lat_100_bg.prn'));

lon_100_copa = lon_100_bg(x1:x2,y1:y2);
lat_100_copa = lat_100_bg(x1:x2,y1:y2);


%*********INTERPOLACAO PARA 20 METROS HS, U, e V ************************%

lat_20_bg = -22.9870:20/111112:-22.9610;

lon_20_bg = -43.1955:20/111112:-43.1631;

[mlon20_copa mlat20_copa] = meshgrid(lon_20_bg,lat_20_bg);

for j = hoje:1/8:hoje+5-3/24
eval(['HS_20_',datestr(j,'yyyymmdd_HHMMSS'),  '=griddata(lon_100_copa,lat_100_copa,HS_',datestr(j,'yyyymmdd_HHMMSS'),',mlon20_copa,mlat20_copa);'])
eval(['uvel_20_',datestr(j,'yyyymmdd_HHMMSS'),'=griddata(lon_100_copa,lat_100_copa,uvel_',datestr(j,'yyyymmdd_HHMMSS'),',mlon20_copa,mlat20_copa);'])
eval(['vvel_20_',datestr(j,'yyyymmdd_HHMMSS'),'=griddata(lon_100_copa,lat_100_copa,vvel_',datestr(j,'yyyymmdd_HHMMSS'),',mlon20_copa,mlat20_copa);'])
end;

%***********GERAR FIGURAS E SAVAR - HS_DIR 20 METROS - COPA*******%

load (fullfile(pathbat,'lat_lon_costa_copa'));


scale = 0.5;
ds = 10; % skip das setas

for j = hoje:1/8:hoje+5-3/24
    
    f = figure;
    namest = fullfile(mypath,datestr(hoje,'yyyymmdd'),'resultado',['COB_ocn_ondas_copa_bg_',datestr(j,'yyyymmdd_HHMM'),'00_9999.png']);
    eval(['quiver (mlon20_copa(1:ds:end,1:ds:end),mlat20_copa(1:ds:end,1:ds:end),uvel_20_',datestr(j,'yyyymmdd_HHMMSS'),...
        '(1:ds:end,1:ds:end),vvel_20_',datestr(j,'yyyymmdd_HHMMSS'),'(1:ds:end,1:ds:end),scale,''k'')']);
    hold on;
    eval(['pcolor(mlon20_copa,mlat20_copa,HS_20_',datestr(j,'yyyymmdd_HHMMSS'),')'])
    shading interp; axis equal;
    eval(['title('' Altura Significativa e Direção de Onda - Praia de Copacabana - ',datestr(j,'dd/mm/yyyy - HH'),'H'');']);
    h = colorbar;
    contourcmap (0:0.2:4.0,'jet','h','on'); %Escala%
    ylabel(h,'(metros)');
    text(-43.1788,-22.9670,'.','FontSize',60')
    text(-43.1792,-22.96559,'Hotel','FontSize',10')
    text(-43.1792,-22.96629,'Copacabana','FontSize',10')
    text(-43.1792,-22.96699,'Palace','FontSize',10')
    text(-43.1678,-22.9627,'Leme','FontSize',10')
    text(-43.1897,-22.9806,'.','FontSize',60')
    text(-43.1928,-22.9809,'Posto 5','FontSize',10')
    text(-43.193,-22.986,'Forte de','FontSize',10')
    text(-43.193,-22.987,'Copacabana','FontSize',10')
    plot(lon_costa_copa,lat_costa_copa,'k','LineWidth',1);
    saveas(f,namest,'png');
    close all
        
    
end

