%
clear all
addpath(genpath('mfiles'))

FILENAME='../mcode/output3dpoint/dataxyz.dat';
OUTPUTDIR='output';
FATOR=[5.0/150 1 0.1];
D=1.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mkdir(OUTPUTDIR);
DATARAW=load(FILENAME);
DATA=DATARAW.*FATOR;

[RR MEAN]=func_calc_rugosidade(DATA,D);

plot_teste_multiple([DATA(:,1) DATA(:,2) RR],OUTPUTDIR,FATOR)

outdatafile=fullfile(OUTPUTDIR,'rugosidade.dat');
save('-ascii',outdatafile,'RR');

outdatafile=fullfile(OUTPUTDIR,'rugosidade-mean.dat');
save('-ascii',outdatafile,'MEAN');


