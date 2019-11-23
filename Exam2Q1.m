T = readtable('Q1.csv');  
%% Question 1 part a: Scatter Plot of data
h = T.Var3; 
idx = h == 1;
idx2 = h < 1;
Q1a = T(idx,:); 
Q1b = T(idx2,:); 

figure(1);
scatter(Q1a.Var1, Q1a.Var2, 'black', 'x');
hold on;
scatter(Q1b.Var1, Q1b.Var2, 'red', 'o');
hold off; 
title('Scatter Plot of Data')
xlabel('X value')
ylabel('Y value')
%% Splitting data into test and training sets. Max number of splits set as 11, SplitCritetion set to Gini Diversity INdex, PruneCriteriton set to impurity
cvpt = cvpartition(T.Var3, 'HoldOut', 0.1);  
idxTrain =  training(cvpt); 
dataTrain = T(idxTrain,:); 
idxTest = test(cvpt); 
dataTest = T(idxTest,:); 
mdl = fitctree(dataTrain, 'Var3', 'PredictorSelection', 'allsplits', 'MaxNumSplits', 11, 'SplitCriterion', 'gdi','PruneCriterion', 'impurity'); 

% view(mdl,'mode','graph')
label = predict(mdl,dataTest);
confuisionmatrix = confusionmat(dataTest.Var3,label); 

%% Bagging Decisions Tree. 
cvpt2 = cvpartition(T.Var3, 'HoldOut', 0.1);  
idxTest2 = test(cvpt2); 
dataTest2 = T(idxTest2,:);  
mdl2 =  TreeBagger( 7, T , 'Var3', 'InBagFraction', 0.9,'PredictorSelection', 'allsplits', 'MaxNumSplits', 11, 'SplitCriterion', 'gdi','PruneCriterion', 'impurity'); 
% view(mdl2.Trees{1},'Mode','graph')
label2 = predict(mdl2.Trees{1},dataTest2);
label3 = str2double(label2);
confuisionmatrix2 = confusionmat(dataTest2.Var3,label3);
%% Adaboost 
cvpt3 = cvpartition(T.Var3, 'HoldOut', 0.1);  
idxTest3 = test(cvpt3); 
dataTest3 = T(idxTest3,:); 
t = templateTree('MaxNumSplits',11,'PredictorSelection', 'allsplits', 'MaxNumSplits', 11, 'SplitCriterion', 'gdi','PruneCriterion', 'impurity');
mdl3 = fitcensemble(T , 'Var3', 'Method','AdaBoostM1', 'learner', t, 'NumLearningCycles' , 7 );
label4 = predict(mdl3,dataTest3);
view(mdl3.Trained{1},'Mode','graph')
confuisionmatrix3 = confusionmat(dataTest3.Var3,label4)
