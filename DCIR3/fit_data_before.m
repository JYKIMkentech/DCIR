function optimized_params_struct = fit_data1()
    % 데이터 로드
    load('BigIC3.mat');
    load('dcir_fit3.mat');

    % 구조체 생성
    optimized_params_struct = struct('R1', [], 'R2', [], 'C', []);

    for i = 1:length(BigIC)
        deltaV_exp = data(BigIC(i)).deltaV;
        time_exp = data(BigIC(i)).t;

        % 최적화를 위한 초기 추정값
        initial_guess = [data(BigIC(i)).R001s, data(BigIC(i)).R10s - data(BigIC(i)).R001s, data(BigIC(i)).C];

        % fmincon을 사용하여 최적화 수행
        options = optimoptions('fmincon', 'Display', 'iter', 'MaxIterations', 100);
        problem = createOptimProblem('fmincon', 'objective', @(params) cost_function(params, time_exp, deltaV_exp), ...
            'x0', initial_guess, 'lb', [0, 0, 0], 'ub', [], 'options', options);
        [opt_params, ~] = fmincon(problem);

        % 최적화된 파라미터 저장
        optimized_params_struct(i).R1 = opt_params(1);
        optimized_params_struct(i).R2 = opt_params(2);
        optimized_params_struct(i).C = opt_params(3);

        % 최적화된 파라미터 출력
        disp("Optimized Parameters for data " + BigIC(i) + ":");
        disp("R1: " + optimized_params_struct(i).R1);
        disp("R2: " + optimized_params_struct(i).R2);
        disp("C: " + optimized_params_struct(i).C);

        % 최적화된 파라미터를 사용하여 모델 예측
        voltage_model = model_func(time_exp, opt_params(1), opt_params(2), opt_params(3));

        % 데이터와 모델 결과를 그래프로 플롯
        figure('Position', [0 0 800 600]);

        lw = 2;  % Desired line width
        msz = 10;  % Marker size

        color1 = [0, 0.4470, 0.7410];  % Blue
        color2 = [0.8500, 0.3250, 0.0980];  % Orange

        % Plot the data with blue solid line
        plot(time_exp, deltaV_exp, 'b-', 'LineWidth', lw, 'Color', color1);
        hold on;

        % Plot the model results with orange dashed line
        plot(time_exp, voltage_model, 'r--', 'LineWidth', lw, 'Color', color2);

        legend('실험 데이터', '모델 결과');
        xlabel('시간 (sec)');
        ylabel('전압 (V)');
        title('실험 데이터와 모델 결과'); % title('실험 데이터와 모델 결과 (데이터 ' + BigIC(i) + ')')

        % Set font size and line width for the axis
        set(gca, 'FontSize', 16, 'LineWidth', 2);
    end
    
    % 구조체 이름 변경
    optimized_params3 = optimized_params_struct;

    save('optimized3.mat','optimized_params3')

    disp("Optimized Parameters for all data:");
    for i = 1:length(BigIC)
        disp("Data " + BigIC(i) + ":");
        disp("R1: " + optimized_params3(i).R1);
        disp("R2: " + optimized_params3(i).R2);
        disp("C: " + optimized_params3(i).C);
    end
end

function cost = cost_function(params, time, deltaV)
    R1 = params(1);
    R2 = params(2);
    C = params(3);
    
    % 모델 함수를 사용하여 예측 전압 계산
    voltage_model = model_func(time, R1, R2, C);
    
    % RMS 오차 계산
    error = deltaV - voltage_model;
    cost = sqrt(mean(error.^2));
end

function voltage = model_func(time, R1, R2, C)
    I = 0.0038;  % 초기에 정의한 I 값을 사용
    a = (R2/R1)+1;  % 초기에 정의한 a 값을 사용
    
    voltage = I * R1 * (R1 + R2) ./ (R1 + R2 .* exp(-a .* time ./ (R1 * C)));
end

