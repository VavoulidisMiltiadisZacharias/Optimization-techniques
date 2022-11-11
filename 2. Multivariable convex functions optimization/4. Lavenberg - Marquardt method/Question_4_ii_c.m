clc;
clear;
clear all;

%define the independent variables
syms x y;

%define the function
f = x^3*exp(-x^2-y^4);

xo = -1;
yo = -1;
xValue = xo; %(Generally is: x of k+1)
yValue = yo; %(Generally is: y of k+1)

%initial value of m
a = 0.05;
b = 0.5;
s = 0.2;
m = 0;
gamma = s *b^m;

gradient_of_f(x,y) = gradient(f,[x,y]);
gradient_of_f = vpa(gradient_of_f(xValue,yValue)); 
temp = (-1)*gradient_of_f; %set the direction vector

%Calculate gamma using Armijo m
while((subs(f,{x,y},{xo,yo}) - subs(f,{x,y},{xo + gamma*temp(1),yo + gamma*temp(2)})) < -a*b^m*s*temp'*gradient_of_f)
     gradient_of_f(x,y) = gradient(f,[x,y]);
     gradient_of_f = vpa(gradient_of_f(xo,yo)); 
     temp = (-1)*gradient_of_f; %set the direction vector
     
     m=m+1;
     gamma = s*b^m; 
     
     fprintf("m: %d\n", m);
     fprintf("%.3f\n", subs(f,{x,y},{xo,yo}));
     fprintf("%.3f\n", subs(f,{x,y},{xo - gamma*temp(1),yo - gamma*temp(2)}));
     fprintf("%.3f\n\n", -a*b^m*s*temp'*gradient_of_f);
end


    %Calculate greekM
    greekM = 0.5;

    h(x,y) = (hessian(f,[x,y]));
    h = vpa(h(xo,yo));
    I = [1 0 ; 0 1];
    idiotimes = eig(h+m*I);
    
    
while(idiotimes(1) <= 0 || idiotimes(2) <= (0))
    greekM = greekM + 0.05;
    
    h(x,y) = (hessian(f,[x,y]));
    h = vpa(h(xo,yo));
    idiotimes = eig(h+greekM*I);
    fprintf("1: %.3f       2: %.3f\n", idiotimes(1), idiotimes(2));
end

gradient_of_f(x,y) = gradient(f,[x,y]);
gradient_of_f = vpa(gradient_of_f(xo,yo)); 

d = linsolve(h+greekM*I, (-1)*gradient_of_f);

xValue = xo + gamma*d(1);
yValue = yo + gamma*d(2);

f_value = subs(f,{x,y},{xValue,yValue})


    