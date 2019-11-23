Test = readtable('Q2Test.csv');
Train = readtable('Q2Train.csv');    

%% Define Matrix  
A = [ 1 2 2;  
      0 1 2;
      0 0 1;]
     
C = [1 0 0]; 

%% Scatter Plot of Traing Data
figure(1); 
plot(Train.Var2,Train.Var3, '-o'); 
title('Scatter Plot of Data')
xlabel('X Distance')
ylabel('Y Distance')

