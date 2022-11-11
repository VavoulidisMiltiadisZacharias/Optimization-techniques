clc;
clear; 
clear all;

%define the independent variables
syms x y;

%test "fprintf" to check if "subs" command works
%k = subs(f,{x,y},{-1,-1});
%fprintf("The value of function is: %f\n", k);

%Draw the function
x = -2:0.2:2 ;  % xAxislimit
y = -2:0.2:2 ;  % yAxislimit


[x,y] = meshgrid(x,y) ;
f = x.^3*exp(-x.^2-y.^4); %define the function
surf(x,y,f);



title('f(x,y) = x^3 * e^(-x^2-y^4)'); %For some reason, it is not typed alligned (see report)
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');


