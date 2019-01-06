clc; clear; close all;
syms x; 
f=@(x) cos(x)./(cosh(x));
a=5;           % interpolation interval [-a,a]
n=[3,5,10,15]; % number of sampling points

for j=1:length(n)
    tfit=linspace(-a,a,n(j));      % data for fitting
    yfit=f(tfit);                  % data for fitting
    int=polyfit(tfit,yfit,n(j)-1); % coefficients of interpolating polynomial     
    tval=[-a:0.1:a];               % data for plotting
    yval=polyval(int,tval);        % data for plotting            
    subplot(2,3,sub2ind([2,3],j));
    hold on;
    plot(tfit,yfit,'og');          % plot data points 
    plot(tval,yval,'r');           % plot interpolating polynomial
    h=ezplot(f,[-a,a]);            % plot original function
    set(h,'Color','blue');      
    axis tight; 
    hold on;
    p = 0;                         % approximating polynomial
    for k=0:n(j)-1
        l = @(x) legendreP(k, x);  % Legendre polynomial
        fl = matlabFunction((cos(x)./(cosh(x))) * l(x/a));
        q = integral(fl,-a,a);
        alpha = (2*k+1)/(2*a)*q;   % coordinates of p in orthogonal basis
        p = p + alpha*l(x/a);      % use transformed Legendre polynomial
    end
    b=ezplot(p,[-a,a]);            % plot approximating polynomial
    set(b,'Color','black'); 
    axis tight; 
    title(sprintf('n = %d', n(j)));
end
legend('sampled points', 'interpolating polynomial', 'f(x)', ...
        'approximating polynomial');