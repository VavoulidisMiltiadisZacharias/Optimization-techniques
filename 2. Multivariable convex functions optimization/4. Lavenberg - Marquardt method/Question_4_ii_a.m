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
m = 0.5;


h(x,y) = (hessian(f,[x,y]));
h = vpa(h(xo,yo));
I = [1 0 ; 0 1];
idiotimes = eig(h+m*I);

%Calculate m
while(idiotimes(1) <= 0 || idiotimes(2) <= (0))
    m = m + 0.05;
    
    h(x,y) = (hessian(f,[x,y]));
    h = vpa(h(xo,yo));
    idiotimes = eig(h+m*I);
    fprintf("1: %.3f       2: %.3f\n", idiotimes(1), idiotimes(2));
end

gradient_of_f(x,y) = gradient(f,[x,y]);
gradient_of_f = vpa(gradient_of_f(xValue,yValue)); 

d = linsolve(h+m*I, (-1)*gradient_of_f);

gamma = 1.1;

xValue = xo + gamma*d(1);
yValue = yo + gamma*d(2);

f_value = subs(f,{x,y},{xValue,yValue})


    