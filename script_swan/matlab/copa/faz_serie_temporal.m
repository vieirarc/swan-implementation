clear all, close all, clc


MyPath = '/home/piatam8/Desktop/rafael_ondas/swan/simulacoes_copa/series';
eval(['cd ',MyPath])
%hoje = datenum(date);

load hs_copa.mat
% load dir_copa.mat

lon = load('lon_100_bg.prn'); lon = lon(1,:);
lat = load('lat_100_bg.prn'); lat = lat(:,1);

eval(['cd ',MyPath,'/serie_temporal'])


var1 = {'00' '03' '06' '09' '12' '15' '18' '21'};
var2 = {'1' '2' '3' '4' '5'};
% d1 = input ('Qual o dia de início da rodada?  ');
% m1 = input ('Qual o mês de início da rodada?  ');
% a1 = input ('Qual o ano de início da rodada?  ');
q1 = datenum(date);

q2 = q1+1; q3 = q1+2; q4 = q1+3;% q5 = q1+4;

q = [q1;q2;q3;q4]; 
dd = datevec(q); clear q*
data = datestr(dd,'yyyymmdd');
ti = datenum(a1,m1,d1,0,0,0);
tf = datenum(a1,m1,d1+3,21,0,0);
tt = linspace(ti,tf,32)'; tt = tt(2:end);

for i = 1:4
    eval(['q',var2{i},'_HS = cat(3,HS_',data(i,:),'_',var1{1},'0000,HS_',...
        data(i,:),'_',var1{2},'0000,HS_',data(i,:),'_',var1{3},'0000,HS_',...
        data(i,:),'_',var1{4},'0000,HS_',data(i,:),'_',var1{5},'0000,HS_',...
        data(i,:),'_',var1{6},'0000,HS_',data(i,:),'_',var1{7},'0000,HS_',...
        data(i,:),'_',var1{8},'0000);']);
end
clear HS*
HS_total = cat(3,q1_HS,q2_HS,q3_HS,q4_HS); HS_total = double(HS_total);
clear q*

P1 = [-22.980509;-43.188027];
P2 = [-22.977552;-43.186094];
P3 = [-22.982737;-43.183707];
P4 = [-22.977552;-43.181367];
P5 = [-22.980509;-43.185058];



for e = 1:5
    eval(['ko',var2{e},' = find(abs(lon - P',var2{e},'(2)) < 0.001); ko',var2{e},' = ko',var2{e},'(1);']);
    eval(['ka',var2{e},' = find(abs(lat - P',var2{e},'(1)) < 0.001); ka',var2{e},' = ka',var2{e},'(1);']);
    eval(['el_p',var2{e},' = squeeze(squeeze(HS_total(ka',var2{e},',ko',var2{e},',2:end)));']);
end

z = linspace(-10,-10,31)';

pasta = fullfile('/home/piatam8/Desktop/rafael_ondas/swan/simulacoes_copa/series/serie_temporal/',datestr(q1,'yyyymmdd'));
mkdir (pasta)
cd (pasta)

for e = 1:5
    
    FigHandle = figure;
    set(FigHandle, 'Position', [100, 100, 900, 350]);
%     set(gcf, 'Position', get(0,'Screensize')); % para abrir a figura em tela cheia
    
    ax(1) = newplot;
    set(gcf,'nextplot','add')
    eval(['h1 = feval(''plot'',tt,el_p',var2{e},',''linewidth'',2);']);
    set(ax(1),'box','on')
    xlim1 = get(ax(1),'xlim');
    ylim1 = get(ax(1),'ylim');
    axis([tt(1) tt(end) 0 3.3])
    grid on
%     datetick('x','HH')
%     datetick('x',16,'keepticks')
    datetick('x','HH','keepticks')
    axis([tt(1) tt(end) 0 3.3])
    xlabel('Tempo (horas)')
    ylabel('Altura Significativa da Onda (m)')
    
    ax(2) = axes('position',get(ax(1),'position'));
    h2 = feval('plot',tt,z);
    set(ax(2),'YAxisLocation','right','color','none', ...
        'xgrid','off','ygrid','off','box','off');
    set(ax(2),'XAxisLocation','top','color','none', ...
        'xgrid','off','ygrid','off','box','off');
    xlim2 = get(ax(1),'xlim');
    ylim2 = get(ax(2),'ylim');
    axis([tt(1) tt(end) 0 3.3])
    datetick('x',19)
    axis([tt(1) tt(end) 0 3.3])
    
    namest = ['COB_ocn_ponto' num2str(e) '_seriesondas_praiacopa_99999999_999999_9999'];
     set(gca,'LooseInset',get(gca,'TightInset'))
     
     set(gcf, 'PaperUnits', 'inches');
     set(gcf, 'PaperSize', [6 2]);
     set(gcf, 'PaperPosition', [0 0 6 2.5]);%No improvement
     saveas(gcf,namest,'png')
     close
    
end


