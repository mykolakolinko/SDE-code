function [MX1,MX2] = euler()
  load("par.mat")
  for j = 1:n_iter
    #wiener process
    dW = sqrt(dt).*randn(1,N-1); W = [0,cumsum(dW)];
    
    #euler method
    x(1) = x0;
    for n=2:N x(n) = x(n-1) + (a(t(n-1)).*x(n-1) + b(t(n-1))).*dt + (c(t(n-1))*x(n-1) + d(t(n-1))).*dW(n-1); end
    X1 = @(t)(x(1+floor(t/dt))); clear x;
    allX1(j,:) = X1(t);
    
    #integration method
    x(1)=x0;
    for m = 2:N
      for n = 1:m-1 EXP(n) = exp(sum((a(t(n:m-1)).*x(n:m-1)+b(t(n:m-1)))*dt)); end
    x(m) =  x0*EXP(1) + sum((c(t(n:m-1)).*x(n:m-1)+d(t(n:m-1))).*EXP(1:m-1).*dW(1:m-1));
    end
    X2 = @(t)(x(1+floor(t/dt))); clear x;
    #plot(t,X1(t),"-x", t,X2(t),"-o");
    allX2(j,:) = X2(t);
    clear dW W X1 X2 EXP;
  end
  mx1 = mean(allX1); mx2 = mean(allX2);
  MX1 = @(t)(mx1(1+floor(t/dt))); MX2 = @(t)(mx2(1+floor(t/dt)));
  plot(t,MX1(t),"-x", t,MX2(t),"-o");
end