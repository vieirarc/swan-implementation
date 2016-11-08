
%%*****************CARREGAR VARIAVEIS DIR *************************%  
mypath='/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob';

hoje = datenum(date);

load(fullfile(mypath,datestr(hoje,'yyyymmdd'),'dir_copa.mat'));



for j = hoje:1/8:hoje+5-3/24
    
     eval(['DIR_',datestr(j,'yyyymmdd_HHMMSS'),' = double(DIR_',datestr(j,'yyyymmdd_HHMMSS'),');'])
end;

x1 = 91;
x2 = 120;
y1 = 134;
y2 = 170;

for j = hoje:1/8:hoje+5-3/24
    
     eval(['DIR_',datestr(j,'yyyymmdd_HHMMSS'),' = DIR_',datestr(j,'yyyymmdd_HHMMSS'),'(x1:x2,y1:y2);'])
end

%% ************ CONVERTE AS VARIAVEIS 'DIR' DE GRAUS PARA METROS (U_V) LOOPING ******%
              % E NECESSARIO ATUALIZAR AS DATAS NOS NOMES DAS VARIAVEIS %

for jj = hoje:1/8:hoje+5-3/24
    
    eval(['kk = find(isnan(DIR_',datestr(jj,'yyyymmdd_HHMMSS'),')==1);'])        %*** VARIAVEL 'DIR' ***%
    eval(['DIR_',datestr(jj,'yyyymmdd_HHMMSS'),'(kk) = 0;'])               %*** VARIAVEL 'DIR' ***%
    eval(['int = ones(size(DIR_',datestr(jj,'yyyymmdd_HHMMSS'),'));'])   %*** VARIAVEL 'DIR' ***%
    int (kk) = 0;





uu = [];
vv = [];

for j = 1:size(int,2)
    eval(['c = DIR_',datestr(jj,'yyyymmdd_HHMMSS'),';'])
    dd = squeeze(c(:,j));
    in = squeeze(int(:,j));
    [u v] = compass2cart(dd,in);
    uu = [uu,u];
    vv = [vv,v];
end
 
uu(kk) = nan;
vv(kk) = nan;

eval(['uvel_',datestr(jj,'yyyymmdd_HHMMSS'),' = uu * (-1);']) %*** VARIAVEL RESULTANTE ***%
eval(['vvel_',datestr(jj,'yyyymmdd_HHMMSS'),' = vv * (-1);']) %*** VARIAVEL RESULTANTE ***%

end
clear *DIR*
