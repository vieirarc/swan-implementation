
data_inicial = raw_input('Data inicial da previsao:')
mes = raw_input('Mes:')
ano = raw_input('Ano:')
horas = range(0,22,3)
data_inicial = int(data_inicial)
data_final = data_inicial + 5
periodo = range(data_inicial,data_final,1)
dia_titulo = [str(dia) for dia in periodo]
hora_titulo = [str(hora) for hora in horas]
x = []

for dia in dia_titulo: 
	for hora in hora_titulo:
		data_titulo = dia + '/' + mes + '/' + ano +' '+ hora +'H'	
		x.append(data_titulo)

		
for name in x:
	plt.title('Altura significativa de onda - Baia de Guanabara - %d' % x ,fontsize=10)