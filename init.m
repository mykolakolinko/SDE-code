function [] = init()
  #T - right endpoint, t - uniform partition of [0, T] with N points and diametr of partition dt
  T=1; N=101; dt=T/(N-1); t=0:dt:T;
  #number of iterations
  n_iter = 1000;
  
  #coefficients
  x0 = 2;
  a = -1;
  b = 0;
  c = -1.3;
  d = 0;
  
  #solution
  if (b==0 & d==0) x = @(w)(x0*exp((a-c^2/2)*t+c*w));
  elseif (b==0 & c==0)
    x = @(w)(exp(a*t).*(cumsum(exp(-a*t).*[x0,diff(w)])));
  else 
    #general solution: x(1) = x0 for m = 2:N x(m) = @(w)(exp((a-c^2/2)*t(m)+c*w(m))*(x0 + (b-c*d)*sum(exp(-(a-c^2/2)*t(1:m)-c*w(1:m))*dt) + d*sum(exp(-(a-c^2/2)*t(1:m)-c*w(1:m)).*diff(w)))); end
  endif
  
  #mean solution
  if (b==0 & d==0) mx = x0*exp(a*t); 
  elseif (b==0 & c==0) mx(1:N) = x0*exp(a*t);
  else 
    #general expectation:
  endif
  
	save par.mat
end;
