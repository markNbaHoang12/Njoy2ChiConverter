#! /usr/bin/env bash
echo 'NJOY Problem h-1-h2o endf/b-vii1 (ENDF to PENDF)'
echo 'Getting ENDF input tapes and NJOY executable'
ln -fs ../endf/neutron/H1_endf.txt tape21
ln -fs ../endf/neutron_thermal/H_in_H2O_endf.txt tape41
echo 'Running NJOY'
cat>input <<EOF
moder
21 -22
reconr
-22 -23
'pendf tape for h-1-h2o from endf/b-vii1'/
125 3/ MATERIAL NUMBER
0.001/
'h-1-h2o from endf/b-vii1 tape'/
'processed by the njoy nuclear data processing system'/
'see original endf/b-vii1 tape for details of evaluation'/
0/
broadr
-22 -23 -24
125 1 0 0 0/ MATERIAL NUMBER
0.001/
293.6/ TEMPERATURE
0/
unresr
-22 -24 -25
125 1 1 0/ MATERIAL NUMBER
293.6/ TEMPERATURE
0.0
0/
heatr
-22 -25 -90/
125 0/ MATERIAL NUMBER
thermr
0 -90 -26
0 125 16 1 1 0 0 1 221 1/ MATERIAL NUMBER
293.6/ TEMPERATURE
0.001 10.0/
thermr
41 -26 -27
1 125 16 1 2 0 0 2 222 1/ MATERIAL NUMBER
293.6/ TEMPERATURE
0.001 10.0/
groupr
-22 -27 0 -30
125 10 0 5 3 1 1 1 1/ MATERIAL NUMBER
'H-1'/
293.6/
0.0
3/
3 221 'therm scat'/
6/
6 221 'transfer matrix'/
6 222 'H_in_H2O_inelastic matrix'/
0/
0/
moder
-30 31
stop
EOF
njoy<input
echo 'Cleaning up'
rm -f tape* njoy
mv output output_H-1.txt
