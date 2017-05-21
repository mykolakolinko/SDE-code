function [] = init()
  #T - right endpoint, t - uniform partition of [0, T] with N points and diametr of partition dt
  T=1; N=101; dt=T/(N-1); t=0:dt:T;
  #number of iterations
  n_iter = 1000;
  
  #coefficients
  x0 = 1.9;
  a = 3.5;
  b = 0;
  c = 0.8;
  d = 0;
  
  #solution
  x = @(w)(x0*exp((a-c^2/2)*t+c*w));
  #mean solution (if b=d=0)
  mx = x0*exp(a*t);
  
	save par.mat
end;