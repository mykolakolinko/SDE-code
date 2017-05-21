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
    x = @(w)(exp(a*t).*(x0 + cumsum((b-c*d)*exp(-(a-c^2/2)*t-c*w).*dt) + cumsum(d*exp(-(a-c^2/2)*t-c*w).*[0,diff(w)])));
  endif
  
  #mean solution
  if (b==0 & d==0) mx = x0*exp(a*t); 
  elseif (b==0 & c==0) mx(1:N) = x0*exp(a*t);
  elseif (a==0) mx = (x0 + b*t).*exp(a*t);
  else mx = (x0 - (b/a)*(exp(-a*t)-1)).*exp(a*t);
  endif
  
	save par.mat
end
