function [] = init()
  #T - right endpoint, t - uniform partition of [0, T] with N points and diametr of partition dt
  T=1; N=101; dt=T/(N-1); t=0:dt:T;
  
  #coefficients (define as function R^N --> R)
  x0 = 2;
  a = @(t)(0*t-1);
  b = @(t)(0*t);
  c = @(t)(0*t-1.3);
  d = @(t)(0*t);
  
  #number of iterations
  n_iter = 250;
  
	save par.mat
end;