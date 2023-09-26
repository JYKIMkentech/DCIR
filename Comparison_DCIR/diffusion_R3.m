clc;clear;close all;
% 
% load('dcir_fit2')
% load('BigIC2.mat')

 load('dcir_fit3')
load('BigIC3.mat')

load('optimized2.mat')
load('optimized3.mat')

load('Resistance2_time.mat')
load('Resistance3_time.mat')


for i = 1:length(BigIC)
 R_d3(i) = data(BigIC(i)).R30s - optimized_params3(i).R1 - optimized_params3(i).R2;
end