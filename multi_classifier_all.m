function [cl,computational_time]=binary_classifier_all(data)
%Used Matlab Classifier Learning application to find the default setting
%for each classifier
%
%                            -----=====INPUT=====----- 
%  data:
%           [Column1=Feature1   Column2=Feature2 ..... Final_Column=Lables]
%           [Row1=Observation1                                            ]
%           [Row1=Observation1                                            ]
%           [Row1=Observation1                                            ]
%           [Row1=Observation1                                            ]
%           [Row1=Observation1                                            ]
%           [Row1=Observation1                                            ]
%           [     .                                                       ]
%           [     .                                                       ]
%           [     .                                                       ]
%           [     .                                                       ]
%           [Final_Row=Final_Observation                                  ]
%
%                            -----=====OUTPUT=====----- 
%  cl:                    an object of all 23 trained classifiers(Uses for
%                         calling the classifiers and in 
%                         "accuracy_binary_classifier_all" function
%
%  computational_time:    A vector of computational time for
%                         training each classifier
%
%
% BY: Mohammad Badri Ahmadi.
warning off;

%Checking whether the labels are binary or not:
%if size(unique(data(:,end)))~=2
%    error('Labels should be binary');
%end

%% Data to predictors and response
predictors=data(:,1:end-1);
response=data(:,end);

%% 1-Trees

% 1a-Complex Tree
tic
cl.compt.model = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 100, ...
    'Surrogate', 'off');
cl.compt.pred=@(x) predict(cl.compt.model, x);
computational_time(1)=toc;

% 1b-Medium Tree
tic
cl.medit.model=fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 20, ...
    'Surrogate', 'off');
cl.medit.pred=@(x)predict(cl.medit.model,x);
computational_time(2)=toc;

% 1c-Simple Tree
tic
cl.simpt.model=fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 4, ...
    'Surrogate', 'off');
cl.simpt.pred=@(x)predict(cl.simpt.model,x);
computational_time(3)=toc;

%% 2-Discriminant Analysis

% 2a-Linear Discriminant
tic
cl.lindis.model=fitcdiscr(...
    predictors, ...
    response, ...
    'DiscrimType', 'diagLinear', ...
    'FillCoeffs', 'off', ...
    'SaveMemory', 'on');
cl.lindis.pred=@(x)predict(cl.lindis.model,x);
computational_time(4)=toc;

% 2b-Quadratic Discriminant
tic
cl.quadis.model = fitcdiscr(...
    predictors, ...
    response, ...
    'DiscrimType', 'diagQuadratic', ...
    'FillCoeffs', 'off', ...
    'SaveMemory', 'on');
cl.quadis.pred=@(x)predict(cl.quadis.model,x);
computational_time(5)=toc;


%% 4-SVM

% 4a-Linear SVM
tic
template = templateSVM(...
    'KernelFunction', 'linear', ...
    'PolynomialOrder', [], ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
cl.lsvm.model = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone');
cl.lsvm.pred=@(x)predict(cl.lsvm.model,x);
computational_time(6)=toc;

% 4b-Quadritic SVM
tic
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
cl.qsvm.model = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone');
cl.qsvm.pred=@(x)predict(cl.qsvm.model,x);
computational_time(7)=toc;

% 4c-Cubic SVM
tic
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 3, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
cl.csvm.model = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone');
cl.csvm.pred=@(x)predict(cl.csvm.model,x);
computational_time(8)=toc;

% 4d-Fine Guassian SVM
tic
template = templateSVM(...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 5, ...
    'BoxConstraint', 1, ...
    'Standardize', true);
cl.fgsvm.model = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone');
cl.fgsvm.pred=@(x)predict(cl.fgsvm.model,x);
computational_time(9)=toc;

% 4e-Medium Guassian SVM
tic
template = templateSVM(...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 20, ...
    'BoxConstraint', 1, ...
    'Standardize', true);
cl.mgsvm.model = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone');
cl.mgsvm.pred=@(x)predict(cl.mgsvm.model,x);
computational_time(10)=toc;

% 4f-Coarse Guassian SVM
tic
template = templateSVM(...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 80, ...
    'BoxConstraint', 1, ...
    'Standardize', true);
cl.cgsvm.model = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone');
cl.cgsvm.pred=@(x)predict(cl.cgsvm.model,x);
computational_time(11)=toc;
%% 5-KNN

% 5a-Fine KNN
tic
cl.fknn.model=fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 1, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true);
cl.fknn.pred=@(x)predict(cl.fknn.model,x);
computational_time(12)=toc;

% 5b-Medium KNN
tic
cl.mknn.model=fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true);
cl.mknn.pred=@(x)predict(cl.mknn.model,x);
computational_time(13)=toc;

% 5c-Coarse KNN
tic
cl.cknn.model=fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 100, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true);
cl.cknn.pred=@(x)predict(cl.cknn.model,x);
computational_time(14)=toc;

% 5d-Cosine KNN
tic
cl.cosknn.model=fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Cosine', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true);
cl.cosknn.pred=@(x)predict(cl.cosknn.model,x);
computational_time(15)=toc;

% 5e-Cubic KNN
tic
cl.cubknn.model= fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Minkowski', ...
    'Exponent', 3, ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true);
cl.cubknn.pred=@(x)predict(cl.cubknn.model,x);
computational_time(16)=toc;

% 5f-Weighted KNN
tic
cl.wknn.model=fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'SquaredInverse', ...
    'Standardize', true);
cl.wknn.pred=@(x)predict(cl.wknn.model,x);
computational_time(17)=toc;

%% 6-Ensemble Classifiers

% 6a-Boosted Trees
tic
template = templateTree(...
    'MaxNumSplits', 20);
cl.bstre.model = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'AdaBoostM2', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'LearnRate', 0.1);
cl.bstre.pred=@(x)predict(cl.bstre.model,x);
computational_time(18)=toc;

% 6b-Bagged Trees
tic
template = templateTree(...
    'MaxNumSplits', length(response));
cl.bagtre.model = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 30, ...
    'Learners', template);
cl.bagtre.pred=@(x)predict(cl.bagtre.model,x);
computational_time(19)=toc;

% 6c-Subspace Discriminant
tic
cl.subdis.model = fitensemble(...
    predictors, ...
    response, ...
    'Subspace', ...
    30, ...
    'Discriminant', ...
    'Type', 'Classification', ...
    'NPredToSample', floor((size(predictors,2) - 1)/2)+1);
cl.subdis.pred=@(x)predict(cl.subdis.model,x);
computational_time(20)=toc;

% 6d-Subspace KNN
tic
cl.subknn.model = fitensemble(...
    predictors, ...
    response, ...
    'Subspace', ...
    30, ...
    'KNN', ...
    'Type', 'Classification', ...
    'NPredToSample', ceil((size(predictors,2) - 1)/2)+1);
cl.subknn.pred=@(x)predict(cl.subknn.model,x);
computational_time(21)=toc;

% 6e-RUSBoosted Trees
tic
template = templateTree(...
    'MaxNumSplits', 20);
cl.rusbtre.model = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'RUSBoost', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'LearnRate', 0.1);
cl.rusbtre.pred=@(x)predict(cl.rusbtre.model,x);
computational_time(22)=toc;
