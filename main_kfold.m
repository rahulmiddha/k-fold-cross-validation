function [] = project2( )
%Select the training data file
[fileName1,pathName1] = uigetfile('*.txt','Select the training data file');
trainData = csvread(strcat(pathName1,fileName1),1,0);
classData = csvread(strcat(pathName1,fileName1),0,0,[0, 0, 0, size(trainData,2)-1]);

trainData = trainData';
class_name=unique(classData);
NoOfClasses = size(class_name,2);

sizeOfClassData = size(classData,2);

%no of instances in each class
for x = 1:NoOfClasses
    rep(x)=histc(classData, class_name(x));
end

prompt = 'Enter value of k for KNN = ';
knn=input(prompt)
partitionArray=zeros(1,sizeOfClassData);

%folds (default value = 5)
k=5; 
    
for i=1:k
    for j=1:NoOfClasses
        y=0;
        while(y< fix(rep(1,j)/k))
            m=j;
            x=(m-1)*rep(1,m)+1;
            z=m*rep(1,m);
            var= randi([x z]);
            if(partitionArray(1,var)==0)
                partitionArray(1,var)=i;
                y = y+1;     
            end
        end
    end
end

for i=1:sizeOfClassData
    if(partitionArray(1,i)==0)
       partitionArray(1,i)=randi([1 k]);
    end
end

accuracyKNN=zeros(1,k);
accuracyCent=zeros(1,k);
accuracyLin=zeros(1,k);
accuracyLibsvm=zeros(1,k);
for j=1:k            
    f=0;
    g=0;
    for i=1:sizeOfClassData
        if partitionArray(1,i)==j
            f=f+1;
            test(f,:)=trainData(i,:);
            classTest(1,f)=classData(1,i);
            
        elseif partitionArray(1,i)~=j
            g=g+1;
            train(g,:)=trainData(i,:);
            classTrain(1,g)=classData(1,i);
                
        end
        
    end
    sizeOfTest=size(test,1);
     KNN = KNN_Classifier(train,test,classTrain,knn);
     centroid_clustering = CentroidClustering(train',test',classTrain);
     Linear = LinearRegression(train',classTrain,test');
     
     %accuracy
     countKNN=0;
     countLin=0;
     countCent=0;
     for r= 1:sizeOfTest
         if(KNN(1,r)~=classTest(1,r))
             countKNN = countKNN+1;
         end    
         if( centroid_clustering(1,r)~= classTest(1,r))
             countCent = countCent+1;
         end
         if(Linear(1,r)~=classTest(1,r))
             countLin = countLin+1;    
         end
     end
     accuracyKNN(1,j)= (sizeOfTest-countKNN)/sizeOfTest;    
     accuracyCent(1,j)= (sizeOfTest-countCent)/sizeOfTest; 
     accuracyLin(1,j)= (sizeOfTest-countLin)/sizeOfTest; 
     
     %using libsvm 
     model = svmtrain(classTrain', train, '-s 1 -t 0');
    [predicted_label, accuracy, dec_values] = svmpredict(classTest', test, model);     
    accuracyLibsvm(1,j)=accuracy(1,1);

end
disp 'KNN accuracy = '
mean(accuracyKNN)*100
disp 'Centroid accuracy = '
mean(accuracyCent)*100
disp 'Linear accuracy = '
mean(accuracyLin)*100 
disp 'Libsvm accuracy = '
mean(accuracyLibsvm)
end

