import testing_unlabeled_data.*
import generate_function_task1.*
import generate_function_task2.*
import generate_function_task2_unknown.*
import generate_function_task3.*
import generate_function_task4.*
import generate_function_task5.*
import task1.*
load('classificatori/trainedModel1.mat')
load('classificatori/unknown.mat')
load('classificatori/trainedModel2.mat')
load('classificatori/trainedModel3.mat')
load('classificatori/trainedModel4.mat')
load('classificatori/trainedModel5.mat')



trainPath = '../dataset/train/data/';
labelsPath = '../dataset/train/labels.xlsx';
testPath = '../dataset/test/data/';
answers = 'answer.csv';
answers = readtable(answers, 'VariableNamingRule', 'preserve');


% task 1
[testDataTask1] = task1(testPath, "");
[testFeatureTable1, x] = generate_function_task1(testDataTask1);

[count1, prediction1] = testing_unlabeled_data(10, testFeatureTable1, trainedModel1);
fprintf('Data classified as normal (class 0): %d \n', count1("Class 0"));
fprintf('Data classified as abnormal (class 1): %d \n', count1("Class 1"));

task1Actual = answers.task1'
correctPredictions = task1Actual == prediction1;

% Calculate accuracy
accuracy = sum(correctPredictions) / numel(task1Actual);

% Display accuracy
disp(['Accuracy: ', num2str(accuracy * 100), '%']);

classLabels = {'Normal', 'Abnormal'};

C = confusionmat(task1Actual,prediction1);
confusionchart(C, classLabels)

prediction1 = [answers.ID prediction1']



% task 2, unknown data
idx = prediction1(:,2)==1;
testDataTask2 = [testDataTask1(prediction1(:,2)==1,:) table(prediction1(idx,1))];

[testFeatureTable2Unknown] = generate_function_task2_unknown(testDataTask2(:,1));

[count2Unknown, prediction2Unknown] = testing_unlabeled_data(10, testFeatureTable2Unknown, Mdl);
fprintf('Data classified as not unknown (class 0): %d \n', count2Unknown("Class 0"));
fprintf('Data classified as unknown (class 1): %d \n', count2Unknown("Class 1"));

prediction2Unknown = [testDataTask2(:,2) table(prediction2Unknown')]


idx = prediction1(:,2)==1;


% task 2, bubble, valve
testDataTask2 = testDataTask2(prediction2Unknown == 0, :);
[testFeatureTable2] = generate_function_task2(testDataTask2);
[count2, prediction2] = testing_unlabeled_data(10, testFeatureTable2, trainedModel2);


task2Actual = answers.task2'


correctPredictions = task1Actual == prediction1;

% Calculate accuracy
accuracy = sum(correctPredictions) / numel(task1Actual);

% Display accuracy
disp(['Accuracy: ', num2str(accuracy * 100), '%']);

classLabels = {'Normal', 'Abnormal'};

C = confusionmat(task1Actual,prediction1);
confusionchart(C, classLabels)




% task 3, bubble
testDataTask3 = testDataTask2(prediction2 == 2, :);
[testFeatureTable3] = generate_function_task3(testDataTask3);
[count3, prediction3] = testing_unlabeled_data(10, testFeatureTable3, trainedModel3);


% task 4, valve
testDataTask45 = testDataTask2(prediction2 == 3, :);
[testFeatureTable4] = generate_function_task4(testDataTask45);
[count4, prediction4] = testing_unlabeled_data(10, testFeatureTable4, trainedModel4);


% task 5, valve opening ratio
[testFeatureTable5] = generate_function_task5(testDataTask45);
[count5, prediction5] = testing_unlabeled_data(10, testFeatureTable5, trainedModel5);



% [yfit,scores]=trainedModel1.predictFcn(notUnknownMembers);
% 
%     for i = 1:numWindow:len-numWindow+1
%         countOfTwo = sum(yfit(i:i+numWindow-1) == 2);
%         countOfThree = numWindow-countOfTwo;
%         if countOfTwo>=dueterzi
%             prediction = [prediction, 2];
%         else
%             prediction = [prediction, 3];
%         end
%     end