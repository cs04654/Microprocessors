
function s=signalprobs(input1sp, input2sp , input3sp)
  
  inputNsp = [0.5, 0.5, 0.5, 0.5];
  sp2AND(input1sp, input2sp);
  sp2OR(input1sp, input2sp);

  sp2XOR(input1sp, input2sp);
  sp2NAND(input1sp, input2sp);
  sp2NOR(input1sp, input2sp);

  sp3AND(input1sp, input2sp, input3sp);
  sp3OR(input1sp, input2sp, input3sp);
  sp3XOR(input1sp, input2sp, input3sp);
  sp3NAND(input1sp, input2sp, input3sp);
  sp3NOR(input1sp, input2sp, input3sp);
  
  spAND(inputNsp);
  spOR(inputNsp);
  spXOR(inputNsp);
  spNAND(inputNsp);
  spNOR(inputNsp);
  
end
%



% 2-input AND gate truth table
% 0 0:0
% 0 1:0
% 1 0:0
% 1 1:1
%% signal probability calculator for a 2-input AND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2AND(input1sp, input2sp)
  printf("AND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp*input2sp;
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
  endfunction

% 2-input OR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:1
%% signal probability calculator for a 2-input OR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2OR(input1sp, input2sp)
  printf("OR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1-(1-input1sp)*(1-input2sp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction


% 2-input XOR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2XOR(input1sp, input2sp)
  printf("XOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp + input2sp - (2*input2sp*input1sp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction


% 2-input NAND gate truth table
% 0 0:1
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NAND(input1sp, input2sp)
  printf("NAND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1-(input1sp*input2sp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction



% 2-input NOR gate truth table
% 0 0:1
% 0 1:0
% 1 0:0
% 1 1:0
%% signal probability calculator for a 2-input NOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NOR(input1sp, input2sp)
  printf("NOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = (1 - input1sp) * (1 - input2sp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction


% 3-input AND gate truth table
function s = sp3AND(input1sp, input2sp, input3sp)
  printf("3-input AND Gate for input probabilities (%f %f %f):\n", input1sp, input2sp, input3sp)
  s = input1sp * input2sp * input3sp;
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% signal probability calculator for a 3-input OR gate
function s = sp3OR(input1sp, input2sp, input3sp)
  printf("3-input OR Gate for input probabilities (%f %f %f):\n", input1sp, input2sp, input3sp)
  s = 1 - ((1 - input1sp) * (1 - input2sp) * (1 - input3sp));
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% signal probability calculator for a 3-input XOR gate
function s = sp3XOR(input1sp, input2sp, input3sp)
  printf("3-input XOR Gate for input probabilities (%f %f %f):\n", input1sp, input2sp, input3sp)
  s = (1-input1sp)*(1-input2sp)*input3sp + (1-input1sp)*input2sp*(1-input3sp) + input1sp*(1-input2sp)*(1-input3sp) + input1sp*input2sp*input3sp;
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% signal probability calculator for a 3-input NAND gate
function s = sp3NAND(input1sp, input2sp, input3sp)
  printf("3-input NAND Gate for input probabilities (%f %f %f):\n", input1sp, input2sp, input3sp)
  s = 1 - (input1sp * input2sp * input3sp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% signal probability calculator for a 3-input NOR gate
function s = sp3NOR(input1sp, input2sp, input3sp)
  printf("3-input NOR Gate for input probabilities (%f %f %f):\n", input1sp, input2sp, input3sp)
  s = (1 - input1sp) * (1 - input2sp) * (1 - input3sp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% signal probability calculator for an N-input AND gate
function s = spAND(inputNsp)
  n = length(inputNsp);
  printf("%d-input AND Gate for input probabilities (", n);
  for i = 1:n
    printf("%f", inputNsp(i));
    if i < n
      printf(" ");
    end
  end
  printf("):\n");  
  s = prod(inputNsp);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% Signal probability calculator for an N-input OR gate
function s = spOR(inputNsp)
  n = length(inputNsp);
  printf("%d-input OR Gate for input probabilities (", n);
  for i = 1:n
    printf("%f", inputNsp(i));
    if i < n
      printf(" ");
    end
  end
  printf("):\n"); 
  s = 1 - (prod(1-inputNsp)); 
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% Signal probability calculator for an N-input XOR gate
function s = spXOR(inputNsp)
  n = length(inputNsp);
  printf("%d-input XOR Gate for input probabilities (", n);
  for i = 1:n
    printf("%f", inputNsp(i));
    if i < n
      printf(" ");
    end
  end
  printf("):\n");
  s = mod(sum(inputNsp), 2);
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction


%% Signal probability calculator for an N-input NAND gate
function s = spNAND(inputNsp)
  n = length(inputNsp);
  printf("%d-input NAND Gate for input probabilities (", n);
  for i = 1:n
    printf("%f", inputNsp(i));
    if i < n
      printf(" ");
    end
  end
  printf("):\n"); 
  s = 1 - (prod(inputNsp)); 
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

%% Signal probability calculator for an N-input OR gate
function s = spNOR(inputNsp)
  n = length(inputNsp);
  printf("%d-input NOR Gate for input probabilities (", n);
  for i = 1:n
    printf("%f", inputNsp(i));
    if i < n
      printf(" ");
    end
  end
  printf("):\n"); 
  s = (prod(1-inputNsp)); 
  Esw = 2*s*(1-s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n",Esw);
endfunction

% Signal probability calculator for a NOT gate
function s = spNOT(inputsp)
  printf("NOT Gate for input probability (%f):\n", inputsp);
  s = 1 - inputsp;
  Esw = 2 * s * (1 - s);
  printf("Signal Probability = %f\n", s);
  printf("Switching activity Esw = %f \n", Esw);
endfunction
