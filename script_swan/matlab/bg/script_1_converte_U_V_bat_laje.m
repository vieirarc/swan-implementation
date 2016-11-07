
%*****************CARREGAR VARIAVEIS DIRECAO *************************%  



for j = 17:21    %Dia%
    for i = 0:3:21 %Hora%
     if i<12
      eval(['DIR_201602' num2str(j) '_0' num2str(i) '0000 = double(DIR_201602' num2str(j) '_0' num2str(i) '0000);'])
       else 
      eval(['DIR_201602' num2str(j) '_' num2str(i) '0000 = double(DIR_201602' num2str(j) '_' num2str(i) '0000);'])
     end
    end 
end


%% ************ CONVERTE AS VARIAVEIS 'DIR' ******%
% E NECESSARIO ATUALIZAR AS DATAS NOS NOMES DAS VARIAVEIS %


for y = 17:21;     %DIAS%                             
for x = 0:3:21;  %HORAS%
if x < 12;
eval(['kk = isnan(DIR_201602' num2str(y) '_0' num2str(x) '0000);'])   
eval(['int = ones(size(DIR_201602' num2str(y) '_0' num2str(x) '0000));'])  

for i = 1:473
    for j = 1:338
        if kk (i,j) == 1;
%             int (kk) = NaN;
            eval(['DIR_201602' num2str(y) '_0' num2str(x) '0000 (kk) = 0;'])  
            int (kk) = 0;
        end
    end
end


uu = [];
vv = [];

for j = 1:338
    eval(['c = DIR_201602' num2str(y) '_0' num2str(x) '0000;'])  
    d = squeeze(c(:,j));
    i = squeeze(int(:,j));
    [u v] = compass2cart(d,i);
    uu = [uu,u];
    vv = [vv,v];
end
 
% uu = uu';
% vv = vv';

for i = 1:473
    for j = 1:338
        if kk (i,j) == 1;
            uu (kk) = NaN;
            vv (kk) = NaN;
        end
    end
end

eval(['uvel_201602' num2str(y) '_0' num2str(x) '0000 = uu * (-1);']) %*** VARIAVEL RESULTANTE ***%
eval(['vvel_201602' num2str(y) '_0' num2str(x) '0000 = vv * (-1);']) %*** VARIAVEL RESULTANTE ***%
else
eval(['kk = isnan(DIR_201602' num2str(y) '_' num2str(x) '0000);']) 
eval(['int = ones(size(DIR_201602' num2str(y) '_' num2str(x) '0000));'])  

for i = 1:473
    for j = 1:338
        if kk (i,j) == 1;
%             int (kk) = NaN;
            eval(['DIR_201602' num2str(y) '_' num2str(x) '0000 (kk) = 0;'])  
            int (kk) = 0;
        end
    end
end


uu = [];
vv = [];

for j = 1:338
    eval(['c = DIR_201602' num2str(y) '_' num2str(x) '0000;'])  
    d = squeeze(c(:,j));
    i = squeeze(int(:,j));
    [u v] = compass2cart(d,i);
    uu = [uu,u];
    vv = [vv,v];
end
 
% uu = uu';
% vv = vv';

for i = 1:473
    for j = 1:338
        if kk (i,j) == 1;
            uu (kk) = NaN;
            vv (kk) = NaN;
        end
    end
end

eval(['uvel_201602' num2str(y) '_' num2str(x) '0000 = uu * (-1);'])  %*** VARI�VEL RESULTANTE ***%
eval(['vvel_201602' num2str(y) '_' num2str(x) '0000 = vv * (-1);'])  %*** VARI�VEL RESULTANTE ***%
end
end
end
clear *DIR*
