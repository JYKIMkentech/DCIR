clc;
clear;
close all;

load('optimized2.mat'); % fitting para
load('optimized3.mat'); % fitting para
load('SOC2_inv.mat');
load('soc3_inv.mat');
load('DCIR2_time_Renew.mat'); % Time scale
load('DCIR3_time_Renew.mat'); % Time scale

figure('Position', [0 0 800 600]);

lw = 2;  % Desired line width
msz = 10;  % Marker size

% Define custom colors
color1 = [0, 0.4470, 0.7410];  % Blue
color2 = [0.8500, 0.3250, 0.0980];  % Orange
color3 = [0.4660, 0.6740, 0.1880];  % Green

hold on;  % Enable plotting multiple series on the same figure

% Plot dcir3 data
for i = 1:length(optimized_params3)
    plot(SOC_inv3(i), optimized_params3(i).R1, 'o', 'Color', color1, 'MarkerSize', msz, 'LineWidth', lw)
end

% Plot dcir2 data
for i = 1:length(optimized_params2)
    plot(SOC_inv2(i), optimized_params2(i).R1, 'o', 'Color', color2, 'MarkerSize', msz, 'LineWidth', lw)
end

% Connect the dcir3 data points with lines
plot(SOC_inv3, [optimized_params3.R1], 'Color', color1, 'LineWidth', lw)

% Connect the dcir2 data points with lines
plot(SOC_inv2, [optimized_params2.R1], 'Color', color2, 'LineWidth', lw)

hold off;  % Release the hold on the figure

% Set graph titles
title('DCIR2 vs. DCIR3 Comparison');
xlabel('SOC (State of Charge)');
ylabel('R1 Value');
legend('DCIR3 Data', 'DCIR2 Data');