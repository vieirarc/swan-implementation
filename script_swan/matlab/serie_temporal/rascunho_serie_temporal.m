%% *** CARREGAR HS *** %%

for j = 19    %Dia%
    for i = 0:3:21 %Hora%
     if i<12
        eval(['DIR_2015080' num2str(j) '_0' num2str(i) '0000 = double(DIR_2015080' num2str(j) '_0' num2str(i) '0000);']);
     else 
       eval(['DIR_2015080' num2str(j) '_' num2str(i) '0000 = double(DIR_2015080' num2str(j) '_' num2str(i) '0000);']);
     end
    end 
end


%% *** ESCREVER OS VALORES DOS PONTOS ****%%

for j = 8;
    for i = 0:3:21;
     if i < 12;
       eval(['DIR_2015080' num2str(j) '_0' num2str(i) '0000 = DIR_2015080' num2str(j) '_0' num2str(i) '0000 (120,213)']);
     else 
       eval(['DIR_2015080' num2str(j) '_' num2str(i) '0000 = DIR_2015080' num2str(j) '_' num2str(i) '0000 (120,213)']);
     end
    end
end


%% VALORES PONTO BOIA RJ-1%%


s_18 = [0.69 0.53 0.58 0.55 0.53 0.58 0.67 0.70]

s_19 = [0.66 0.63 0.66 0.67 0.65 0.65 0.65 0.66]

s_20 = [




% RASCUNHO %
subplot(3,1,1)
plot(s_18);
xlabel('tempo')
ylabel('hs')
title('altura de onda')
axis([0 1 1 8])

%*** DIRECAO BOIA RJ-1 ***%

d_07 = [164.63 150.91 148.10 148.34 148.56 149.30 145.23 142.01];


%% dia 10 a 14 e dia 18 a 22 de agosto %









