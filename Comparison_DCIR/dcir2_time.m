load('dcir_fit2')
load('BigIC2.mat')


% Ohmic 시간 resistance 추출

for i = 1 : length(BigIC)
    Ohm2_time(i) = data(BigIC(i)).R001s;
end

 
% Charge transfer 시간 resistance 추출
CT2_time = zeros(length(BigIC),1);

for i = 1 : length(BigIC);
    CT2_time(i) = data(BigIC(i)).R10s - data(BigIC(i)).R001s;
end

% Diffusion 시간 resistance 추출


for i = 1 : length(BigIC)
    Dif2_time(i) = data(BigIC(i)).R30s - data(BigIC(i)).R10s;
end

Resistance2_time = struct('Ohm2_time', Ohm2_time, 'CT2_time',CT2_time, 'Dif2_time', Dif2_time);

save('Resistance2_time.mat','Resistance2_time')