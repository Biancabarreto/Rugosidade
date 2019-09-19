%
pkg load image
clear all
close all
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMAGEPATH='../images/8 bits/4cd.bmp';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% STEP 1
IMG = imread(IMAGEPATH);
IMG_BIN=function_check_binary_image(IMG);
figure(1);
imagesc(IMG_BIN); colormap(jet);

%% STEP 2
R = LineDetector(IMG_BIN);      %% Crio um line detector R
R.set_reconstruction_parts(14); %% Estabelecer em quantas partes será reconstruido
R.set_reconstruction_level(0);  %% Estabelecer o nivel de reconstrução
figure(2);
[X Y]=R.calculates_curve();     %% detetar pontos da curva

%% STEP 3 (FINAL)
figure(3);
[XREF YREF]=R.calculates_curve_ref(X);
colormap(jet);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msgbox ('End');
figure(4);
plot_all_results(IMAGEPATH,IMG_BIN,XREF,YREF,X,Y);
