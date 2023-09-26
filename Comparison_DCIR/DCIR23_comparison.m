load('SOC2_inv.mat');

load('SOC3_inv.mat');

load('optimized2.mat');

load('optimized3.mat');

load('Resistance2_time.mat');

load('Resistance3_time.mat');

% SOC_inv vs optimized resistance , time resistance  
for i = 1:length(optimized_params2)
    DCIR2_R1(i) = optimized_params2(i).R1; % R1 = 100ms (Ohmic 최적화 +resistance)
    DCIR2_R2(i) = optimized_params2(i).R2; % R2 = R10s - R001s (CT resistance) ( 저항 누적값 아님) 
    DCIR2t_R1(i) = Resistance2_time.Ohm2_time(i); % DCIR2time ohmic 
    DCIR2t_R2(i) = Resistance2_time.CT2_time(i); % DCIR2 CT time resistance 
    DCIR2t_dift(i) = Resistance2_time.Dif2_time(i); % Dif = R10s - R001s 
end

for i = 1: length(optimized_params3)
    DCIR3_R1(i) = optimized_params3(i).R1;
    DCIR3_R2(i) = optimized_params3(i).R2;
    DCIR3t_R1(i) = Resistance3_time.Ohm3_time(i); % DCIR3 time ohmic 
    DCIR3t_R2(i) = Resistance3_time.CT3_time(i); % DCIR3 CT time resistance 
    DCIR3t_dift(i) = Resistance3_time.Dif3_time(i); % DCIR3 Dif time resistance
end

% Ohmic resistance (SOC_inv vs optimized , time resistance)

figure('Position', [0 0 800 600]);

lw = 2;  % Desired line width
msz = 10;  % Marker size

plot(SOC_inv3, DCIR3_R1, 'b-o', 'MarkerSize', msz, 'LineWidth', lw); % 최적화 ohmic resistance
hold on;
plot(SOC_inv3, DCIR3t_R1, 'b--o', 'MarkerSize', msz, 'LineWidth', lw); % time ohmic resistance
plot(SOC_inv2, DCIR2_R1, 'r-o', 'MarkerSize', msz, 'LineWidth', lw); % 최적화 ohmic resistance
plot(SOC_inv2, DCIR2t_R1, 'r--o','MarkerSize', msz, 'LineWidth', lw) % time ohmic resistance

title('Ohmic resistance')
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR3', 'DCIR3 (time) ', 'DCIR2', 'DCIR2 (time)');
set(gca, 'FontSize', 16, 'LineWidth', 2);

% Charge Transfer resistance (SOC_inv vs optimized , time resistance)

figure('Position',[0 0 800 600]);

lw = 2;
msz = 8;

plot(SOC_inv3, DCIR3_R2, 'b-o', 'MarkerSize', msz, 'LineWidth', lw);
hold on;
plot(SOC_inv3, DCIR3t_R2, 'b--o', 'MarkerSize', msz, 'LineWidth', lw);
plot(SOC_inv2, DCIR2_R2, 'r-o', 'MarkerSize', msz, 'LineWidth', lw);
plot(SOC_inv2, DCIR2t_R2, 'r--o', 'MarkerSize', msz, 'LineWidth', lw);

title('Charge Tranfer resistance')
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR3', 'DCIR3 (time) ', 'DCIR2', 'DCIR2 (time)');
set(gca, 'FontSize', 16, 'LineWidth', 2);

% Diffusion resistance (SOC_inv vs time resistance)

figure('Position',[0 0 800 600]);

lw = 2;
msz = 8;


plot(SOC_inv3, DCIR3t_dift, 'b--o', 'MarkerSize', msz, 'LineWidth', lw);
hold on;
plot(SOC_inv2, DCIR2t_dift, 'r--o', 'MarkerSize', msz, 'LineWidth', lw);

title('Diffusion resistance')
xlabel('SOC');
ylabel('Resistance (\Omega)');
legend('DCIR3 (time)', 'DCIR2 (time)');
set(gca, 'FontSize', 16, 'LineWidth', 2);


