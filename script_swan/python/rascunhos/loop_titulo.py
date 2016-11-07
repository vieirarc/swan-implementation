# script para os campos de altura significativa
import os
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt


# os arquivos sao carregado como um dicionarios
# em seguida alguns 'keys' sem utilidade dentro dos dicionarios sao deletados
hs_21_a_25_setembro = sio.loadmat('/home/rafael/Documentos/lamce/simulacoes_swan/copacabana_cob/20150921/hs_copa_teste.mat')
del hs_21_a_25_setembro['__header__'],hs_21_a_25_setembro['__globals__'],hs_21_a_25_setembro['__version__'],hs_21_a_25_setembro['HS_20150920_210000']


coord = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_bg_laje/lon_lat_bg_laje.mat')
del coord['__globals__'], coord['__version__'], coord['__header__'], coord['filename']
lon_bg_laje = coord['lon_bg_laje']
lat_bg_laje = coord['lat_bg_laje']


coastline = sio.loadmat('/home/rafael/Documentos/lamce/dados/bat_100_bg/coastline_bg.mat')
del coastline['__globals__'], coastline['__header__'], coastline['__version__']


coastline_lon = coastline['lon']
coastline_lat = coastline['lat']

# os 'keys' dicionario hs sao ordenados em ordem crescente
lista_crescente = sorted(hs_21_a_25_setembro.keys())

# variaveis titulo
data_inicial = raw_input('Data inicial da previsao:')
mes = raw_input('Mes:')
ano = raw_input('Ano:')
horas = range(0,22,3)
data_inicial = int(data_inicial)
data_final = data_inicial + 5
periodo = range(data_inicial,data_final,1)
dia_titulo = [str(dia) for dia in periodo]
hora_titulo = [str(hora) for hora in horas]

for key in lista_crescente:
	fig = plt.figure() #figsize=(20, 65),dpi=80)
	fig.canvas.set_window_title(key)
	plt.contourf(lon_bg_laje,lat_bg_laje,hs_21_a_25_setembro[key])#,vmin=0., vmax=4.)
	plt.plot(coastline_lon,coastline_lat,'k')
	plt.colorbar()
		
x = []

for dia in dia_titulo: 
	for hora in hora_titulo:
		data_titulo = dia + '/' + mes + '/' + ano +' '+ hora +'H'	
		x.append(data_titulo)

	

for name in x:
	plt.title('Altura significativa de onda - Baia de Guanabara -'+' '+ name ,fontsize=10)


for key in lista_crescente:
	plt.savefig(os.path.join('/home/rafael/Documentos/lamce/simulacoes_swan/copacabana_cob/20150921/teste/',key))
	

#	plt.title('Altura significativa de onda - Baia de Guanabara -'+' '+ data_titulo,fontsize=10)
	