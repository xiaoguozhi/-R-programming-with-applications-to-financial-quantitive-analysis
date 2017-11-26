HerdBehavior_MR <- function(Data, CS, Result1, Result2){
  # 1. parametric model
  if (deparse(substitute(CS))== 'CSAD')
    Formula <- CS ~ abs(Data$RM) + I(Data$RM^2)
  else
    Formula <- CS ~ Result1 + I(Result2)
  MeanReg <- lm(Formula)
  cat('#######################################', '\n')
  cat('parametric model', '\n')
  cat('#######################################', '\n')
  print(summary(MeanReg))
  
  # 2. locally polynomial
  win.graph(width=5,height=4.5)
  est <- locpoly(Data$RM,CS,bandwidth=0.1)
  if (deparse(substitute(CS))== 'CSAD')
    plot(est,type = "l",  xlab='�г�������', ylab='CSAD', main='��ֵ�ֲ�����ʽ-CSAD')
  else
    plot(est, type = "l", xlab='�г�������', ylab='CSSD', main='��ֵ�ֲ�����ʽ-CSSD')
  
  # 3. B-splines
  Data_Ana <- data.frame(CS=CS, RM=Data$RM)
  cat('#######################################', '\n')
  cat('B-spline model', '\n')
  cat('#######################################', '\n')
  print(summary(fm1 <- lm(CS ~ bs(Data$RM,df=7, degree=3), data = Data_Ana)))
}

