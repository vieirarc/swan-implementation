
# script teste para uma única imagem#
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt

'''
sio.loadmat -> carrega arquivo .mat
sio.savemat -> salva arquivo .mat
sio.whosmat -> consultas as variaveis que contem no arquivo .mat 
'''

altura_significativa = sio.loadmat('/home/rafael/Documentos/lamce/simulacoes_swan/copacabana_cob/20150921/hs_copa_teste.mat')

hs_teste = altura_significativa['HS_20150923_120000']
hs_teste = np.float64(hs_teste)


fig = plt.figure(figsize=(9, 65),dpi=80)
#fig = plt.gcf()
fig.canvas.set_window_title('ondas_20150923_12')
plt.contourf(hs_teste)
plt.plot(coastline_lon,coastline_lat,'k')
plt.colorbar()
plt.title('Altura significativa de ondas - Baia de Guanabara',fontsize=10)


plt.show()


# script para os campos de altura significativa
import os
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt


hs_21_a_25_setembro = sio.loadmat('/home/rafael/Documentos/lamce/simulacoes_swan/20150921/hs_copa.mat')
# o arquivo e carregado como um dicionario 
# em seguida alguns 'keys' sem utilidade do dicionario sao deletados

del hs_21_a_25_setembro['__header__'],hs_21_a_25_setembro['__globals__'],hs_21_a_25_setembro['__version__'],hs_21_a_25_setembro['HS_20150920_210000']

# os 'keys' dicionario sao ordenados em ordem crescente
l = sorted(hs_21_a_25_setembro.keys())


for key in l:
	fig = plt.figure() #figsize=(20, 65),dpi=80)
	fig.canvas.set_window_title(key)
	plt.contourf(hs_21_a_25_setembro[key])
	plt.colorbar()
	plt.title('Altura significativa de onda - Baia de Guanabara -'+ key)
	plt.savefig(os.path.join('/home/rafael/Documentos/lamce/simulacoes_swan/20150921/teste/',key))



# falta padronizar a escala do colorbar; 
# melhorar a data do titulo;
