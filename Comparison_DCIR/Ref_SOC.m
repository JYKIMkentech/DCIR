clc; clear; close all;

load('[HNE_FCC_06_DCIR3_026].mat') % DCIR3 큰 pulse에 해당하는 data 추출

load('OCV_DCIR.mat')  % OCV2 (reference) data 추출



data(1)=[];
id_cfa = 2; % 1 = cathode, 2 = FCC 3 = anode
I_1C = 0.00482; %[A]

% 충전, 방전 스텝(필드) 구하기 

step_chg = [];
step_dis = [];

for i = 1:length(data)
    % type 필드가 C인지 확인
    if strcmp(data(i).type, 'C')
        % C가 맞으면 idx 1 추가
        step_chg(end+1) = i;
    % type 필드가 D인지 확인
    elseif strcmp(data(i).type, 'D')

        % 맞으면 idx 1 추가
        step_dis(end+1) = i;
    end
end



% STEP 내부에서의 전하량 구하기

for j = 1:length(data)
     %calculate capacities
     data(j).Q = trapz(data(j).t,data(j).I)/3600; %[Ah]
     data(j).cumQ = cumtrapz(data(j).t,data(j).I)/3600; %[Ah]
     

     % data(j).cumQ = abs(cumtrapz(data(j).t,data(j).I))/3600; %[Ah]
     
end

% Total QC, QD값 구하기 ( 전체 전하량 구하기) 
total_QC = sum(abs([data(step_chg).Q]));  % charge 상태 전체 Q값
total_QD = sum(abs([data(step_dis).Q])); % discharge 상태 전체 Q값



% cumsumQ 필드 추가
for i = 1:length(data)
    if i == 1
        data(i).cumsumQ = data(i).cumQ;
    else
        data(i).cumsumQ = data(i-1).cumsumQ(end) + data(i).cumQ;
    end
end

for i = 1 : length(data)
    if id_cfa == 1 || id_cfa == 2
        if id_cfa == 1
            
             data(i).SOC = data(i).cumsumQ/total_QC; % Cathode
            

          
        elseif id_cfa == 2
           
             data(i).SOC = data(i).cumsumQ/total_QC; % FCC
            
            
            
        end
        % 큰 I 가지는 index 추출
        BigI = [];
        for i = 1:length(data)
            if abs(data(i).I) > (1/3 * I_1C)
               BigI = [BigI , i];
            end
        end
        
        if id_cfa == 1 || id_cfa == 2
            % BigIC, BigID 계산
            BigIC = BigI(BigI < step_chg(end));
            BigID = BigI(BigI >= step_chg(end));
        end
    elseif id_cfa == 3 % Anode
        BigI = [];
        for i = 1:length(data)
            data(i).SOC = 1 + data(i).cumsumQ/total_QD;
            if abs(data(i).I) > (1/3 * I_1C)
               BigI = [BigI , i];
               
            end
        end
        % BigI 계산
         BigI = BigI;
       
    else
        error('Invalid id_cfa value. Please choose 1 for cathode, 2 for FCC, or 3 for anode.');
    end
end
% I의 평균을 필드에 저장하기 

for i = 1:length(data)
    data(i).avgI = mean(data(i).I);
end

% V 변화량 구하기
for i = 1 : length(data)
    if i == 1
       data(i).deltaV = zeros(size(data(i).V));
    else
       data(i).deltaV = data(i).V() - data(i-1).V(end);
    end
end

% Resistance 구하기 
for i = 1 : length(data)
    if data(i).avgI == 0
        data(i).R = zeros(size(data(i).V));
    else 
        data(i).R = (data(i).deltaV / data(i).avgI) .* ones(size(data(i).V));
    end
end

% OCV을 이용한 SOC 역추적을 위해, OCV의 마지막 rest 전압 구하기


V_restC = zeros(length(BigIC),1);

for i = 1:length(BigIC)
    V_restC(i) = data(BigIC(i)-1).V(end);    
end

V_restD = zeros(length(BigID),1);

for i = 1:length(BigID)
    V_restD(i) = data(BigID(i)-1).V(end);
end


% 중복되는 SOC을 제거하고, SOC 역추적

[OCV_unique, ind_unique] = unique(OCV_golden.OCVchg(:, 2));
SOC_unique = OCV_golden.OCVchg(ind_unique', 1);

SOC_inv = zeros(size(V_restC));

% Perform extrapolation for the first element
SOC_inv(1) = interp1(OCV_unique, SOC_unique, V_restC(1), 'linear', 'extrap');

% Perform interpolation for the remaining elements
for i = 2:length(BigIC)
    SOC_inv(i) = interp1(OCV_unique, SOC_unique, V_restC(i));
end



figure
hold on
plot(OCV_golden.OCVchg(:,1),OCV_golden.OCVchg(:,2))
plot(OCV_golden.OCVdis(:,1),OCV_golden.OCVdis(:,2))
hold off

save('SOC_ref.mat','SOC_inv')



