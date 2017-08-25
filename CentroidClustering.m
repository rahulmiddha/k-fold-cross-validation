function Ind = CentroidClustering( trainData,testData,classData )

N = size(trainData,1);
M = size(testData,1);
col = size(trainData,2);

class_name=unique(classData);
noOfClasses=size(class_name,2);
for x = 1:noOfClasses
    rep(x)=histc(classData, class_name(x));
end
rep;
i=1;

for x = 1:size(rep,2)
    sumOf=0;
    for y = 1:rep(x)
        if i <= col
            sumOf = sumOf+trainData(:,i);
            i  = i+1;
        else
            break;
        end
    end
    centroidTrain(:,x) = sumOf ./ rep(x);
end    
    
final= pdist2(centroidTrain',testData');
[Fin,Ind] = min(final,[],1);





% N1 = size(trainData,1);
% M1 = size(trainData,2);
% 
% N2 = size(testData,1);
% M2 = size(testData,2);
% % 
% % arr1 = zeros(1,N1);
% % arr2 = zeros(1,N2);
% % 
% % for row = 1:N1
% %     arr1(1,row) = sum(trainData(row,:))/ M1;
% % end
% % 
% % for row = 1:N2
% %     arr2(1,row) = sum(testData(row,:))/ M2;
% % end  
% % 
% % arr1
% % arr2
% 
% class_name=unique(classData);
% noOfClasses=size(class_name,2);
% for x = 1:noOfClasses
%     rep(x)=histc(classData, class_name(x));
% end
% rep;
% x=1;
% y=0;
% arr=0;
% newSum = mean(trainData,2);
% for row = 1:size(newSum,1)
%     arr = newSum(row,1) + arr;
%     %centroidTrain(1,row) = arr(1,(M1/2));
%     y=y+1;
%     if(y == rep(x))
%         newCentroid(1,x) = arr / rep(x);        
%         x = x+1;
%         y=0;
%         arr=0;
%     end
% end
% newCentroid
% centroidTest= mean(testData,2);
% centroidTest= centroidTest'
% eucli = zeros(size(centroidTest,2),size(newCentroid,2));
% 
% 
% for row = 1:1
%      for col = 1:5
%        eucli(row,col)= sqrt((newCentroid(1,col) -  centroidTest(1,row)).^2);    
%     end
% end
% eucli
% %eucli = transpose(eucli);
% [B,I] = sort(eucli,2);
% I
% final = zeros(1,size(centroidTest,2));
% for row = 1:size(eucli,2)
%     final(1,row)= classData(1,I(1,row));
% end   
% final
