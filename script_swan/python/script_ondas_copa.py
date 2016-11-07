# script para altura significativa de ondas - copacabana

import os
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt

# definicao dos caminhos
DATA_DIR = raw_input('Digite a data inicial da previsao no formato aaaammdd:')
path = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob/'+ DATA_DIR + '/hs_copa.mat'
os.makedirs('/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob/'+ DATA_DIR +'/resultado_hs')
path_save = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob/'+ DATA_DIR + '/resultado_hs'


# os arquivos sao carregados como dicionarios
# em seguida alguns 'keys' sem utilidade dentro dos dicionarios sao deletados
hs_copa = sio.loadmat(path)
del hs_copa['__header__'],hs_copa['__globals__'],hs_copa['__version__']

hs_copa = {key:value[91:121,134:171] for key, value in hs_copa.items()}


coord_copa = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/lon_lat_100_bg.mat')
del coord_copa['__globals__'], coord_copa['__version__'], coord_copa['__header__']
lon_copa = coord_copa['lon_100_bg']
lon_copa = lon_copa[91:121,134:171]
lat_copa = coord_copa['lat_100_bg']
lat_copa = lat_copa[91:121,134:171]


coastline_copa = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/lat_lon_costa_copa.mat')
del coastline_copa['__globals__'], coastline_copa['__header__'], coastline_copa['__version__']
coastline_copa_lon = coastline_copa['lon_costa_copa']
coastline_copa_lat = coastline_copa['lat_costa_copa']


# os 'keys' do dicionario hs_copa sao ordenados em ordem crescente
lista_crescente = sorted(hs_copa.keys())
del lista_crescente[0] 


# as variaveis dos dicionarios sao 'plotadas'
for key in lista_crescente:
	fig = plt.figure() 
	fig.canvas.set_window_title(key)
	plt.contourf(lon_copa,lat_copa,hs_copa[key])
	plt.plot(coastline_copa_lon,coastline_copa_lat,'k')
	ax = plt.gca()
	ax.get_xaxis().get_major_formatter().set_useOffset(False)
	ay = plt.gca()
	ay.get_yaxis().get_major_formatter().set_useOffset(False)
	plt.colorbar()
	plt.title('Altura significativa de onda - Praia de Copacabana -'+' '+ key[9:11] +'/'+ key[7:9] +'/'+ key[3:7] +' '+ key[12:14] +'H',fontsize=10.5)
	plt.savefig(os.path.join(path_save,key[:14]))
	

# falta fixar os valores limites do contourf !!!
	