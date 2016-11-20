
'''
Script para gerar as imagens de altura significativa e 
direcao de ondas para a BAÍA DE GUANABARA. As imagens
sao geradas a partir dos resultados do modelo de propagacao
de ondas SWAN.

Feito por Rafael Vieira - LAMCE/COPPE/UFRJ

'''
import os
from datetime import datetime
import numpy as np
import scipy.io as sio
import collections 
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from intdir2uv import intdir2uv


# definicao dos caminhos
data_atual = datetime.now()
path = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/baia_de_guanabara/%i%i%i' %(data_atual.year, \
				data_atual.month, data_atual.day)

os.makedirs('/home/rafael/Documentos/lamce/swan/simulacoes_swan/baia_de_guanabara/%i%i%i/resultado_hs' %(data_atual.year, \
				data_atual.month, data_atual.day))

path_save = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/baia_de_guanabara/%i%i%i/resultado_hs' %(data_atual.year, \
				data_atual.month, data_atual.day)


# altura significativa de ondas:
# os arquivos sao carregados como dicionarios,
# em seguida alguns 'keys' sem utilidade sao deletados dos dicionarios
hs_copa = sio.loadmat(path +'/hs_copa.mat')
del hs_copa['__header__'],hs_copa['__globals__'],hs_copa['__version__']#, hs_copa['HS_20160216_210000'] # generalizar esta data!

# coordenadas
coord = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_bg_laje/lon_lat_bg_laje.mat')
del coord['__globals__'], coord['__version__'], coord['__header__'], coord['filename']
lon_bg_laje = coord['lon_bg_laje']
lat_bg_laje = coord['lat_bg_laje']

# linha de costa
coastline = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/coastline_bg.mat')
del coastline['__globals__'], coastline['__header__'], coastline['__version__']
coastline_lon = coastline['lon']
coastline_lat = coastline['lat']


# os 'keys' do dicionario hs_copa sao ordenados em ordem crescente
lista_crescente = sorted(hs_copa.keys())
del lista_crescente[0] 


# direcao de ondas
dir_copa = sio.loadmat(path+'/dir_copa.mat')
del dir_copa['__header__'],dir_copa['__globals__'],dir_copa['__version__']#, dir_copa['DIR_20160216_210000'] # generalizar esta data!


# converte as variaveis de direcao de graus para componentes u - v 
u_componente = {}
v_componente = {}

for keys, values in dir_copa.items():
	U, V = intdir2uv(values)
	u_componente["u_{0}".format(keys[4:])] = U*(-1)
	v_componente["v_{0}".format(keys[4:])] = V*(-1)
   
u_componente = collections.OrderedDict(sorted(u_componente.items()))
v_componente = collections.OrderedDict(sorted(v_componente.items()))
hs_copa = collections.OrderedDict(sorted(hs_copa.items()))


# gera e salva as imagens no diretorio
for x in range(40):
	hs = hs_copa.values()[x]
	u = u_componente.values()[x]
	v = v_componente.values()[x]
	fig = plt.figure()
	plt.contourf(lon_bg_laje,lat_bg_laje, hs)
	plt.quiver(lon_bg_laje,lat_bg_laje, u, v)
	plt.plot(coastline_lon,coastline_lat,'k')	
	m = cm.ScalarMappable(cmap=cm.jet) #	mapeia as matrizes hs para usar o colorbar
	m.set_array(hs)
	plt.colorbar(m)
	fig.canvas.set_window_title(hs_copa.keys()[x][3:14])
	plt.title('Altura significativa e direcao de onda - Baia de Guanabara - %s/%s/%s - %sH ' %(hs_copa.keys()[x][9:11], \
		hs_copa.keys()[x][7:9], hs_copa.keys()[x][3:7], hs_copa.keys()[x][12:14]), fontsize=10.5)
	plt.savefig(os.path.join(path_save, '%s%s%s_%sH' %(hs_copa.keys()[x][3:7], hs_copa.keys()[x][7:9], \
		hs_copa.keys()[x][9:11], hs_copa.keys()[x][12:14])))