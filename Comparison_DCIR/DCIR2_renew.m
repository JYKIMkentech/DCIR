load('dcir_fit2.mat');

load('BigIC2.mat');

for i = 1 : length(BigIC)
   DCIR2_001s(i) = data(BigIC(i)).R001s;
   DCIR2_10s(i) = data(BigIC(i)).R10s;
   DCIR2_30s(i) = data(BigIC(i)).R30s;
end

DCIR2_time_Renew = struct('DCIR2_001s',DCIR2_001s, 'DCIR2_10s', DCIR2_10s, 'DCIR2_30s', DCIR2_30s );

save('DCIR2_time_Renew.mat', 'DCIR2_time_Renew')