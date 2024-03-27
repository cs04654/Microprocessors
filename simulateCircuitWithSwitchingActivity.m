function [signalE, switchingActivity] = simulateCircuitWithSwitchingActivity(a, b, c)
    
    function s=sp2AND(input1sp, input2sp)
      s = input1sp*input2sp;
      Esw = 2*s*(1-s);
    endfunction
    
    function s = spNOT(inputsp)
      s = 1 - inputsp;
      Esw = 2 * s * (1 - s);
    endfunction
    
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

    % Calculate overall switching activity by multiplying switching activities
    switchingActivity = switchingActivityAB * switchingActivityC_not * switchingActivityD;
    
    % Display final output and switching activities
    printf("Input Signals: a=%f, b=%f, c=%f\n", a, b, c);
    printf("Intermediate Signals e = %f, f = %f\n", signalAB,signalC_not);
    printf("Output Signal d = %f\n", signalD);
    printf("Switching Activity of e = %f\n", switchingActivityAB);
    printf("Switching Activity of f = %f\n", switchingActivityC_not);
    printf("Switching Activity of d = %f\n", switchingActivityD);
    printf("Overall Switching Activity = %f\n", switchingActivity);
    
end


