function MMS = euler()
  load("par.mat")
  for j = 1:n_iter
    #wiener process
    dW = sqrt(dt).*randn(1,N-1); 
    W = [0, cumsum(dW)];
    
    #euler method
    X(1) = x0;
    for n=2:N X(n) = X(n-1) + (a*X(n-1) + b).*dt + (c*X(n-1) + d).*dW(n-1); end;
    #figure(1); plot(t,X,"-x",t,x(W),"-o");
    
    normvec(j) = max(abs(X-x(W)));
    allX(j,:) = X;
    clear dW W X EXP;
  end
  
  #values for table
  Mean = mean(normvec);
  Median = median(normvec);
  Std = std(normvec);
  MMS = [Mean, Median, Std];
  
  MX = mean(allX);
  figure(2); plot(t,MX,"-x",t,mx,"-o");
end
