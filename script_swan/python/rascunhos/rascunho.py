import os
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt


hs_21_a_25_setembro = sio.loadmat('/home/rafael/Documentos/lamce/simulacoes_swan/20150921/hs_copa.mat')

del hs_21_a_25_setembro['__header__'],hs_21_a_25_setembro['__globals__'],hs_21_a_25_setembro['__version__'],hs_21_a_25_setembro['HS_20150920_210000']

l = sorted(hs_21_a_25_setembro.keys())

for key in l:
	fig = plt.figure() #figsize=(9, 65),dpi=80)
	fig.canvas.set_window_title(key)
	plt.contourf(hs_21_a_25_setembro[key])
	plt.colorbar()
	plt.title('HS Copacabana')
	plt.savefig(os.path.join('/home/rafael/Documentos/lamce/simulacoes_swan/20150921/teste/',key))


plt.show()



############## NOMES ###########################


for x in range(21,26):
	for y in range(0,22,3):
		x = str(x)
		y = str(y)
		z = '_0'
		if y < 12:
			fig = plt.figure(figsize=(9, 65), dpi=80)
			fig.canvas.set_window_title('ondas_201509'+x+z+y+'0000')
			plt.contourf(value)
			plt.colorbar()
			plt.title('Altura significativa de ondas - Baia de Guanabara - 'x'/09/2015')
			plt.savefig('/home/rafael/Documentos/lamce/simulacoes_swan/20150921/teste/ondas_201509'+x+z+y+'0000.png') 
		else:
			fig = plt.figure(figsize=(9, 65), dpi=80)
			fig.canvas.set_window_title('ondas_201509'+x+'_'+y+'0000')
			plt.contourf(value)
			plt.colorbar()
			plt.title('Altura significativa de ondas - Baia de Guanabara - 'x'/09/2015')
			plt.savefig('/home/rafael/Documentos/lamce/simulacoes_swan/20150921/teste/ondas_201509'+x+'_'+y+'0000')

plt.show()
			


####################

for x in range(21,26):
		for y in range(0,22,3):
			x = str(x)	
			y = str(y)
			z = '_0'

			if y <12:
				fig.canvas.set_window_title('ondas_201509'+x+z+y+'0000')
			else:
				fig.canvas.set_window_title('ondas_201509'+x+'_'+y+'0000')