%
pkg load image
clear all
close all
addpath(genpath('lib-mcode'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Só modifica aquí
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMAGEPATH='../images/z510a.bmp';
NORM_UMBRAL=0.80;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% STEP 0
IMG = imread(IMAGEPATH);
if(length(size(IMG))==3)
    IMG = rgb2gray(IMG);
endif
IMG_BIN=(IMG>(NORM_UMBRAL*max(max(IMG))));

%% STEP 1
R = LineDetector(IMG_BIN);

%% STEP 2
R.set_reconstruction_parts(8);
[X Y]=R.calculates_curve();

%% STEP 3 (FINAL)
[XREF YREF]=R.calculates_curve_ref(X);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msgbox ('End');
plot_all_results(IMAGEPATH,IMG_BIN,XREF,YREF,X,Y);
