load('dcir_fit3')
load('BigIC3.mat')

% Ohmic 시간 resistance 추출

for i = 1 : length(BigIC)
    Ohm3_time(i) = data(BigIC(i)).R001s;
end

 
% Charge transfer 시간 resistance 추출
CT3_time = zeros(length(BigIC),1);

for i = 1 : length(BigIC);
    CT3_time(i) = data(BigIC(i)).R10s - data(BigIC(i)).R001s;
end

% Diffusion 시간 resistance 추출


for i = 1 : length(BigIC)
    Dif3_time(i) = data(BigIC(i)).R30s - data(BigIC(i)).R10s;
end

Resistance3_time = struct('Ohm3_time', Ohm3_time, 'CT3_time',CT3_time, 'Dif3_time', Dif3_time);

save('Resistance3_time.mat','Resistance3_time')