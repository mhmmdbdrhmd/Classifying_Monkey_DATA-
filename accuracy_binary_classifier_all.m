function accuracy=accuracy_binary_classifier_all(data,cl)
%                            -----=====INPUT=====----- 
%
%   data:
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
%   cl:         The object that has been trained in "binary_classifier_all"
%               function
%
%                            -----=====OUTPUT=====----- 
%   accuracy:   a vector of accuracies of each classifier.
%
%
%BY: Mohammad Badri Ahmadi.



%% Data to predictors and response
predictors=data(:,1:end-1); response=data(:,end);
%% Getting accuracy of each classifier
accuracy(1)=sum(cl.compt.pred(predictors)==response)/length(response);
accuracy(2)=sum(cl.medit.pred(predictors)==response)/length(response);
accuracy(3)=sum(cl.simpt.pred(predictors)==response)/length(response);
accuracy(4)=sum(cl.lindis.pred(predictors)==response)/length(response);
accuracy(5)=sum(cl.quadis.pred(predictors)==response)/length(response);
accuracy(6)=sum(cl.logreg.pred(predictors)==response)/length(response);
accuracy(7)=sum(cl.lsvm.pred(predictors)==response)/length(response);
accuracy(8)=sum(cl.qsvm.pred(predictors)==response)/length(response);
accuracy(9)=sum(cl.csvm.pred(predictors)==response)/length(response);
accuracy(10)=sum(cl.fgsvm.pred(predictors)==response)/length(response);
accuracy(11)=sum(cl.mgsvm.pred(predictors)==response)/length(response);
accuracy(12)=sum(cl.cgsvm.pred(predictors)==response)/length(response);
accuracy(13)=sum(cl.fknn.pred(predictors)==response)/length(response);
accuracy(14)=sum(cl.mknn.pred(predictors)==response)/length(response);
accuracy(15)=sum(cl.cknn.pred(predictors)==response)/length(response);
accuracy(16)=sum(cl.cosknn.pred(predictors)==response)/length(response);
accuracy(17)=sum(cl.cubknn.pred(predictors)==response)/length(response);
accuracy(18)=sum(cl.wknn.pred(predictors)==response)/length(response);
accuracy(19)=sum(cl.bstre.pred(predictors)==response)/length(response);
accuracy(20)=sum(cl.bagtre.pred(predictors)==response)/length(response);
accuracy(21)=sum(cl.subdis.pred(predictors)==response)/length(response);
accuracy(22)=sum(cl.subknn.pred(predictors)==response)/length(response);
accuracy(23)=sum(cl.rusbtre.pred(predictors)==response)/length(response);
