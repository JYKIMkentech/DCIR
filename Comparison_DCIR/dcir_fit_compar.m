clc;
clear;
close all;

load('optimized2.mat'); % fitting para
load('optimized3.mat'); % fitting para
load('SOC2_inv.mat');
load('soc3_inv.mat');
load('DCIR2_time_Renew.mat'); % Time scale
load('DCIR3_time_Renew.mat'); % Time scale

% DCIR3
figure('Position', [0 0 800 600]);

lw = 2;  % Desired line width
msz = 10;  % Marker size

% Define custom colors
color1 = [0, 0.4470, 0.7410];  % Blue
color2 = [0.8500, 0.3250, 0.0980];  % Orange
color3 = [0.4660, 0.6740, 0.1880];  % Green

% Plot DCIR3 data
plot(SOC_inv3, DCIR3_time_Renew.DCIR3_001s, 'Color', color1, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
hold on
plot(SOC_inv3, DCIR3_time_Renew.DCIR3_10s, 'Color', color2, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
plot(SOC_inv3, DCIR3_time_Renew.DCIR3_30s, 'Color', color3, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)

% Plot optimized DCIR3 parameters
for i = 1:length(optimized_params3)
    plot(SOC_inv3(i), optimized_params3(i).R1, 'Color', color1, 'Marker', 'X', 'MarkerSize', msz, 'LineWidth', lw)
end

title('DCIR3 Comparison') % Update the title
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR3 (100ms)', 'DCIR3 (10s)', 'DCIR3 (30s)', 'Optimized R1 (DCIR3)')
set(gca, 'FontSize', 16, 'LineWidth', 2);
axis([-0.02 1 0 130])

% DCIR2
figure('Position', [0 0 800 600]);

lw = 2;  % Desired line width
msz = 10;  % Marker size

% Plot DCIR2 data (similar to DCIR3, but with DCIR2 data)
plot(SOC_inv2, DCIR2_time_Renew.DCIR2_001s, 'Color', color1, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
hold on
plot(SOC_inv2, DCIR2_time_Renew.DCIR2_10s, 'Color', color2, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
plot(SOC_inv2, DCIR2_time_Renew.DCIR2_30s, 'Color', color3, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)

% Plot optimized DCIR2 parameters

for i = 1:length(optimized_params2)
    plot(SOC_inv2(i), optimized_params2(i).R1, 'Color', color1, 'Marker', 'X', 'MarkerSize', msz, 'LineWidth', lw)
end


title('DCIR2') % Update the title
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR2 (100ms)', 'DCIR2 (10s)', 'DCIR2 (30s)')
set(gca, 'FontSize', 16, 'LineWidth', 2);
axis([0 1 0 130]) 


