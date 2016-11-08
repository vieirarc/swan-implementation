#!/bin/bash
export MLAB_DIR=/usr/local/MATLAB/MATLAB_Production_Server/R2013a
export MATLAB2013=$MLAB_DIR/bin/matlab
export PATH="$PATH:$MLAB_DIR/bin/"

export workdir=/home/piatam8/Desktop/rafael_ondas/swan/simulacoes_copa
export tpardir=$workdir/tpar
export scripts=/home/piatam8/Desktop/rafael_ondas/swan/script_swan/matlab

hoje=`date +%Y%m%d`
mkdir $workdir/$hoje

cp $tpardir/TPAR_$hoje.txt $workdir/$hoje/TPAR_1.txt
cp $tpardir/TPAR_$hoje.txt $workdir/$hoje/TPAR_2.txt
cp $tpardir/TPAR_$hoje.txt $workdir/$hoje/TPAR_3.txt

arq_swn=$workdir/$hoje/swan_input_copa_cob.swn
cp $tpardir/swan_input_copa_cob.swn $arq_swn


inicio=`date +%Y%m%d -d " -1 day"`
fim=`date +%Y%m%d -d " +4 day"`
cd $workdir/$hoje


sed -i 's/XXXXXXXX/'$inicio'/g' $arq_swn
sed -i 's/FFFFFFFF/'$fim'/g' $arq_swn


swanrun -input swan_input_copa_cob

mkdir resultado
export resultado=$workdir/$hoje/resultado
export series=/home/piatam8/Desktop/rafael_ondas/swan/simulacoes_copa/series/serie_temporal

cd $scripts
matlab -nodesktop -r "script_1_converte_U_V_copa;script_2_carrega_recorta_e_plota_variaveis_copa;quit;"

cd $resultado
scp *.png atmosfera@numa3:/home/atmosfera/WRF/cob/swan/ondas
ssh -t -t  atmosfera@numa3 <<EOF
cd /home/atmosfera/WRF/cob/swan/ondas
sh ./envia_ftp.sh
exit 
EOF

#cd $series
#scp -r $hoje numa8@numa8:/home/numa8/projetos/COB/operacional/copa/serie_temporal
#ssh -t -t  numa8@numa8 <<EOF
#cd /home/numa8/projetos/COB/operacional/copa/scripts
#sh ./envia_site.sh
#exit 
#EOF

corpo_email=$workdir/$hoje/log.txt
printf 'O modelo de ondas rodou hoje' >$corpo_email
mail -s 'Swan rodou' rvieira@lamce.coppe.ufrj.br < $corpo_email

