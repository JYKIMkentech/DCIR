load('dcir_fit3.mat');

load('BigIC3.mat');

for i = 1 : length(BigIC)
   DCIR3_001s(i) = data(BigIC(i)).R001s;
   DCIR3_10s(i) = data(BigIC(i)).R10s;
   DCIR3_30s(i) = data(BigIC(i)).R30s;
end


DCIR3_time_Renew = struct('DCIR3_001s',DCIR3_001s, 'DCIR3_10s', DCIR3_10s, 'DCIR3_30s', DCIR3_30s );


save('DCIR3_time_Renew.mat', 'DCIR3_time_Renew')