# script para os campos de altura significativa de ondas - baia de guanabara

import os
from mpl_toolkits.basemap import Basemap, cm
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt

# definicao dos caminhos
DATA_DIR = raw_input('Digite a data inicial da previsao no formato aaaammdd:')
path = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/baia_de_guanabara/'+ DATA_DIR + '/hs_copa.mat'
os.makedirs('/home/rafael/Documentos/lamce/swan/simulacoes_swan/baia_de_guanabara/'+ DATA_DIR +'/resultado_hs')
path_save = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/baia_de_guanabara/'+ DATA_DIR + '/resultado_hs'

# os arquivos sao carregados como dicionarios
# em seguida alguns 'keys' sem utilidade dentro dos dicionarios sao deletados
hs_copa = sio.loadmat(path)
del hs_copa['__header__'],hs_copa['__globals__'],hs_copa['__version__']


coord = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_bg_laje/lon_lat_bg_laje.mat')
del coord['__globals__'], coord['__version__'], coord['__header__'], coord['filename']
lon_bg_laje = coord['lon_bg_laje']
lat_bg_laje = coord['lat_bg_laje']


coastline = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/coastline_bg.mat')
del coastline['__globals__'], coastline['__header__'], coastline['__version__']
coastline_lon = coastline['lon']
coastline_lat = coastline['lat']


# os 'keys' do dicionario hs_copa sao ordenados em ordem crescente
lista_crescente = sorted(hs_copa.keys())
del lista_crescente[0] 

#m = Basemap(projection='mill', llcrnrlat=-23.0900, llcrnrlon=-43.3140, urcrnrlat=-22.6650, urcrnrlon=-43.0100, resolution='f')


# as variaveis dos dicionarios sao 'plotadas'
for key in lista_crescente:
	fig = plt.figure()
	cmap = plt.cm.jet 
	fig.canvas.set_window_title(key)
	plt.pcolor(lon_bg_laje,lat_bg_laje,hs_copa[key],cmap=cmap)#,vmin=0., vmax=4.)
	plt.plot(coastline_lon,coastline_lat,'k')
	plt.colorbar()
	plt.title('Altura significativa de onda - Baia de Guanabara -'+' '+ key[9:11] +'/'+ key[7:9] +'/'+ key[3:7] +' '+ key[12:14] +'H',fontsize=10.5)
	plt.savefig(os.path.join(path_save,key[:14]))
	

# falta fixar os valores limites do colorbar contourf !!!
