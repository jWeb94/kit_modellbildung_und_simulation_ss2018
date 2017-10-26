function [meanOf,sumOf]=sumOfThreeValues(a,b,c)
    inputVector = [a,b,c];
    %meanOf = (a+b+c)/3
    meanOf = mean(inputVector);
    sumOf = sum(inputVector);
end
