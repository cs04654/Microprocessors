function [signalE_avg, switchingActivity_avg] = simulateCircuitMonteCarlo(workloadSize)
    
    function s=sp2AND(input1sp, input2sp)
      s = input1sp*input2sp;
      Esw = 2*s*(1-s);
    endfunction
    
    function s = spNOT(inputsp)
      s = 1 - inputsp;
      Esw = 2 * s * (1 - s);
    endfunction
    
    % Initialize arrays to store results
    signalE_results = zeros(1, workloadSize);
    switchingActivity_results = zeros(1, workloadSize);

    % Perform Monte Carlo simulation for the specified workload size
    for i = 1:workloadSize
        % Generate random inputs for a, b, and c
        a = rand();
        b = rand();
        c = rand();

        % Calculate signal probabilities for inputs a, b, and c
        signalA = a;
        signalB = b;
        signalC = c;

        % Calculate signal probabilities for AND gate between a and b
        signalAB = sp2AND(signalA, signalB);
        switchingActivityAB = 2 * signalAB * (1 - signalAB); % Switching activity of AND gate

        % Calculate signal probability for NOT gate on input c
        signalC_not = spNOT(signalC);
        switchingActivityC_not = 2 * signalC_not * (1 - signalC_not); % Switching activity of NOT gate

        % Calculate signal probabilities for AND gate between (a AND b) and (NOT c)
        signalD = sp2AND(signalAB, signalC_not);
        switchingActivityD = 2 * signalD * (1 - signalD); % Switching activity of final output

        % Store results for this iteration
        signalD_results(i) = signalD;
        
        signalAB_results(i) = signalAB;
        
        signalC_not_results(i) = signalC_not;
        
        switchingActivity_results(i) = switchingActivityD;
        
        switchingActivityAB_results(i) = switchingActivityAB;
        
        switchingActivityC_not_results(i) = switchingActivityC_not;
    end

    % Calculate average signal probability and switching activity
    signalD_avg = mean(signalD_results);
    switchingActivity_avg = mean(switchingActivity_results);

    signalAB_avg = mean(signalAB_results);
    switchingActivityAB_avg = mean(switchingActivityAB_results);
    
    signalC_not_avg = mean(signalC_not_results);
    switchingActivityC_not_avg = mean(switchingActivityC_not_results);
    
    overall_average_average = switchingActivity_avg*switchingActivityAB_avg*switchingActivityC_not_avg;
    
    % Display average results
    printf("Average Output Signal e = %f\n", signalAB_avg);
    printf("Average Switching Activity of e = %f\n", switchingActivityAB_avg);
    
    printf("Average Output Signal f = %f\n", signalC_not_avg);
    printf("Average Switching Activity of f = %f\n", switchingActivityC_not_avg);
    
    printf("Average Output Signal d = %f\n", signalD_avg);
    printf("Average Switching Activity of d = %f\n", switchingActivity_avg);
    
    printf("Overall Average Switching Activity %f\n", overall_average_average);
    
end
