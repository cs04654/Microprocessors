function SwitchingActivity = MCOR4(N)
    %% for dynamic power computation, we need the switching activity
    %% Let's consider a 4-input OR gate with the following truth table:

    %% I1 I2 I3 I4 | O
    %%  X  X  X  1 | 1 
    %%  X  X  1  X | 1 
    %%  X  1  X  X | 1 
    %%  1  X  X  X | 1 
    %%  0  0  0  0 | 0

    %% and let's try to find the power consumption of the following workload (remember workload is program)

    Workload=[0 0 0 0; 1 1 1 1; 0 0 0 1; 1 1 1 1; 0 1 0 1];

    MonteCarloSize=N
    for i = 1:MonteCarloSize
        Workload=[Workload; round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2))];
    end
    vectorsNumber=size(Workload, 1);
    gateInputsNumber=size(Workload, 2);
    gateOutput= 0 | 0 | 0 | 0;

    switchesNumber=0;
    for i = 1:vectorsNumber    
        NewGateOutput= Workload(i, 1) | Workload(i, 2) | Workload(i, 3) | Workload(i, 4);
        %NewGateOutput
        if (gateOutput==NewGateOutput)
            continue;
        else
            gateOutput=NewGateOutput;
        end
        
        switchesNumber=switchesNumber+1;
    end
    switchesNumber
    vectorsNumber
    SwitchingActivity=(switchesNumber/vectorsNumber)
    
endfunction
