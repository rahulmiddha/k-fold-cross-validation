function final = LinearRegression( Xtrain,Ytrain,Xtest )


search = unique(Ytrain);
for i = 1:length(search)
indicator(i,:)=ismember(Ytrain,search(i))';
end

Ytrain = indicator;

B = pinv(Xtrain') * Ytrain'; % (XX')^{-1} X  * Y'
Ytest1 = B' * Xtest; 
[Ytest2value  ,final]= max(Ytest1,[],1);

end
