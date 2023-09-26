clc; close all; clear;


load('SOC2_inv.mat');

load('SOC3_inv.mat');

load('DCIR2_time_Renew.mat');

load('DCIR3_time_Renew.mat');

% DCIR3

figure('Position', [0 0 800 600]);

lw = 2;  % Desired line width
msz = 10;  % Marker size

% Define custom colors
color1 = [0, 0.4470, 0.7410];  % Blue
color2 = [0.8500, 0.3250, 0.0980];  % Orange
color3 = [0.4660, 0.6740, 0.1880];  % Green

% Plot with custom colors
plot(SOC_inv3, DCIR3_time_Renew.DCIR3_001s, 'Color', color1, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
hold on
plot(SOC_inv3, DCIR3_time_Renew.DCIR3_10s, 'Color', color2, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
plot(SOC_inv3, DCIR3_time_Renew.DCIR3_30s, 'Color', color3, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)

title('DCIR2') % 실제 데이터는 DCIR3
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR2 (100ms)' , 'DCIR2 (10s)', 'DCIR2 (30s)');
set(gca, 'FontSize', 16, 'LineWidth', 2);
axis([-0.02 1 0 130])

% DCIR2

figure('Position', [0 0 800 600]);

lw = 2;  % Desired line width
msz = 10;  % Marker size

% Define custom colors
color1 = [0, 0.4470, 0.7410];  % Blue
color2 = [0.8500, 0.3250, 0.0980];  % Orange
color3 = [0.4660, 0.6740, 0.1880];  % Green

plot(SOC_inv2, DCIR2_time_Renew.DCIR2_001s, 'Color', color1, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
hold on
plot(SOC_inv2, DCIR2_time_Renew.DCIR2_10s, 'Color', color2, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)
plot(SOC_inv2, DCIR2_time_Renew.DCIR2_30s, 'Color', color3, 'Marker', 'o', 'MarkerSize', msz, 'LineWidth', lw)


title('DCIR1') % 실제 데이터는 DCIR2
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR1 (100ms)' , 'DCIR1 (10s)', 'DCIR1 (30s)');
set(gca, 'FontSize', 16, 'LineWidth', 2);
axis([0 1 0 130])