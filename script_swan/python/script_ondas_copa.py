
'''
Script para gerar as imagens de altura significativa e 
direcao de ondas para a PRAIA DE COPACABANA. As imagens
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


# definicao dos caminhos utilizados
data_atual = datetime.now()
path = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob/%i%i%i' %(data_atual.year, \
				data_atual.month, data_atual.day)

os.makedirs('/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob/%i%i%i/resultado_hs' %(data_atual.year, \
				data_atual.month, data_atual.day))

path_save = '/home/rafael/Documentos/lamce/swan/simulacoes_swan/copacabana_cob/%i%i%i/resultado_hs' %(data_atual.year, \
				data_atual.month, data_atual.day)


# altura significativa de ondas:
# os arquivos sao carregados como dicionarios,
# em seguida alguns 'keys' sem utilidade sao deletados dos dicionarios
hs_copa = sio.loadmat(path +'/hs_copa.mat')
del hs_copa['__header__'],hs_copa['__globals__'],hs_copa['__version__'], hs_copa['HS_20160915_210000']

hs_copa = {key:value[91:121,134:171] for key, value in hs_copa.items()}

# coordenadas
coord_copa = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/lon_lat_100_bg.mat')
del coord_copa['__globals__'], coord_copa['__version__'], coord_copa['__header__']
lon_copa = coord_copa['lon_100_bg']
lon_copa = lon_copa[91:121,134:171]
lat_copa = coord_copa['lat_100_bg']
lat_copa = lat_copa[91:121,134:171]

# linha de costa
coastline_copa = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/lat_lon_costa_copa.mat')
del coastline_copa['__globals__'], coastline_copa['__header__'], coastline_copa['__version__']
coastline_copa_lon = coastline_copa['lon_costa_copa']
coastline_copa_lat = coastline_copa['lat_costa_copa']

# os 'keys' do dicionario hs_copa sao ordenados de forma crescente
lista_crescente = sorted(hs_copa.keys())
del lista_crescente[0] 

# direcao de ondas
dir_copa = sio.loadmat(path+'/dir_copa.mat')
del dir_copa['__header__'],dir_copa['__globals__'],dir_copa['__version__'], dir_copa['DIR_20160915_210000']

dir_copa = {key:value[91:121,134:171] for key, value in dir_copa.items()}

dir_copa = collections.OrderedDict(sorted(dir_copa.items()))


# converte as variaveis de direcao de graus para componentes u - v 
u_componente = {}
v_componente = {}

for keys, values in dir_copa.items():
	U, V = intdir2uv(values)
	u_componente["u_{0}".format(keys[4:])] = U*(-1)
	v_componente["v_{0}".format(keys[4:])] = V*(-1)

# ordena as variaveis dos dicionarios
u_componente = collections.OrderedDict(sorted(u_componente.items()))
v_componente = collections.OrderedDict(sorted(v_componente.items()))
hs_copa = collections.OrderedDict(sorted(hs_copa.items()))


# gera e salva as imagens no diretorio
for x in range(40):
	hs = hs_copa.values()[x]
	u = u_componente.values()[x]
	v = v_componente.values()[x]
	fig = plt.figure()	
	plt.contourf(lon_copa, lat_copa, hs)
	plt.quiver(lon_copa, lat_copa, u, v)
	plt.plot(coastline_copa_lon, coastline_copa_lat, 'k')	
	m = cm.ScalarMappable(cmap=cm.jet) #	mapeia as matrizes hs para usar o colorbar
	m.set_array(hs)
	plt.colorbar(m)
	fig.canvas.set_window_title(hs_copa.keys()[x][3:14])
	ax = plt.gca()
	ax.get_xaxis().get_major_formatter().set_useOffset(False)
	ay = plt.gca()
	ay.get_yaxis().get_major_formatter().set_useOffset(False)
	plt.title('Altura significativa e direcao de onda - Praia de Copacabana - %s/%s/%s - %sH ' %(hs_copa.keys()[x][9:11], \
		hs_copa.keys()[x][7:9], hs_copa.keys()[x][3:7], hs_copa.keys()[x][12:14]), fontsize=10.5)
	plt.savefig(os.path.join(path_save, '%s%s%s_%sH' %(hs_copa.keys()[x][3:7], hs_copa.keys()[x][7:9], \
		hs_copa.keys()[x][9:11], hs_copa.keys()[x][12:14])))