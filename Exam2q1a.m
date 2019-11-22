T = readtable('Q1.csv'); 
h = T.Var3; 
idx = h == 1;
idx2 = h < 1;
Q1a = T(idx,:); 
Q1b = T(idx2,:); 

figure;
scatter(Q1a.Var1, Q1a.Var2, 'black', 'x');
hold on;
scatter(Q1b.Var1, Q1b.Var2, 'red', 'o');
hold off; 
title('Scatter Plot of Data')
xlabel('X value')
ylabel('Y value')

