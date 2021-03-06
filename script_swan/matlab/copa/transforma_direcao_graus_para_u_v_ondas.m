clear all, close all, clc

load direção.mat

kk = isnan(dir);   
int = ones(size(dir));  

for i = 1:464
    for j = 1:350
        if kk (i,j) == 1;     
%             int (kk) = NaN;  
            dir (kk) = 0; 
            int (kk) = 0; 
        end
    end
end


uu = [];  
vv = [];

for j = 1:350
    d = squeeze(dir(:,j));  
    i = squeeze(int(:,j));
    [u v] = compass2cart(d,i);
    uu = [uu,u];
    vv = [vv,v];
end
 
% uu = uu';
% vv = vv';

for i = 1:464
    for j = 1:350
        if kk (i,j) == 1;
            uu (kk) = NaN;
            vv (kk) = NaN;
        end
    end
end

uvel = uu * (-1);
vvel = vv * (-1);

quiver(uvel,vvel)
