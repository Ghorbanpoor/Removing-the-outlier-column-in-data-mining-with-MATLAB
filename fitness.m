function  [Z]=fitness(x)

x=round(x);
nrfolds=10;
[ndata, text, alldata] = xlsread('excel.xlsx');
ss=find(x==1);

if sum(ss)~=0
    Y=ndata(:,17);
    X=ndata(:,ss);
    cvfolds=crossvalind('kfold',Y,nrfolds);
    for i= 1:nrfolds
        testidx = (cvfolds ==i);
        trainidx=~testidx;
        cl=fitcsvm(X(trainidx,:),Y(trainidx),'kernelfunction','rbf','standardize',true,'classnames',[0,1],'boxconstraint',2e-1);%'solver',solver),'boxconstraint',c,'classnames',[0,1],'solver',solver);
        ypred=predict(cl,X(testidx,:));%[ypred,scores]=predict(cl,x(testidx,:));
        cMat = confusionmat(Y(testidx),ypred);
        s=size(cMat);
        if s>1
            Accuracy(i)    = (cMat(1,1)+cMat(2,2))./(cMat(1,1)+cMat(1,2)+cMat(2,1)+cMat(2,2));
        else
            Accuracy(i)    = 1;
        end
    end
    Z=1-mean(Accuracy);
else
    Z=1;
end
    






end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%