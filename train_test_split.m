testPercentage = 20;

% num windows fame policy 0.064s
%numWindow = 19;
% num windows fame policy 0.128s
numWindow = 10;

if ismember('Task1', FeatureTable1.Properties.VariableNames)
    % stratified splitting 80-20
    % fino a 105 normal, da 106 a 153 fault, da 154 a 177 anomaly
    normalTestPercentage = int32(105*testPercentage/100);
    faultTestPercentage = int32((153-105)*testPercentage/100);
    anomalyTestPercentage = int32((177-153)*testPercentage/100);

    trainTable = FeatureTable1;
    
    anomalyTest = trainTable(153*numWindow+1:(anomalyTestPercentage+153)*numWindow,:);
    trainTable(153*numWindow+1:(anomalyTestPercentage+153)*numWindow,:) = [];
    
    faultTest = trainTable(105*numWindow+1:(faultTestPercentage+105)*numWindow,:);
    trainTable(105*numWindow+1:(faultTestPercentage+105)*numWindow,:) = [];
    
    normalTest = trainTable(1:normalTestPercentage*numWindow,:);
    trainTable(1:normalTestPercentage*numWindow,:) = [];
    
    
    testTable = [normalTest; faultTest; anomalyTest];

elseif ismember('Task2', FeatureTable1.Properties.VariableNames)
    % stratified splitting 80-20
    faultTestPercentage = int32(48*testPercentage/100);
    anomalyTestPercentage = int32(24*testPercentage/100);
    
    trainTable = FeatureTable1;
    
    anomalyTest = trainTable(48*numWindow+1:(anomalyTestPercentage+48)*numWindow,:);
    trainTable(48*numWindow+1:(anomalyTestPercentage+48)*numWindow,:) = [];
    
    faultTest = trainTable(1:faultTestPercentage*numWindow,:);
    trainTable(1:faultTestPercentage*numWindow,:) = [];
    
    testTable = [faultTest; anomalyTest];
   
  elseif ismember('Task3', FeatureTable1.Properties.VariableNames)
    featureTable = FeatureTable1;

    trainTable = head(featureTable,16*numWindow);
    testTable = tail(featureTable,8*numWindow);

end