clc; 
clear;
clear all;

%variables declaration/initialization
syms x ;%define the independent variable

i = 0 ; 
l = 0.08; %starting lambda

%define functions
%f1 = (x-3)^2 + (sin(x+3))^2;
%f2 = (x-1)*cos(x/2)+x^2;
f3 = (x+2)^2+exp(x-2)*sin(x+3);

for i = 1:10 %update lambda 9 times(run for 10 different lambda values)
    
    %the following variables are on purpose within the for loop so that
    %they can be re-initialized within each i-th iteration
    A = -4;
    B = 4;
    l = l-0.005;%update lambda
    x1 = (A+B)/2;
    df = subs(diff(f3),x1);
    %df = vpa(subs(f1, x, x1)); %calculate df(x1)/dx
    k = 0; %holds the number of iterations needed to finish the execution
    fprintf("df: %d\n", df);
    fprintf('i:%d  l:%f\n', i, l);
    
    while k < 30  %allow the algorithm to run for a max of 30 times
        
        %rounding to 6 decimal places (otherwise "if df == 0" never happens)
        df = round(df*1000000)/1000000;
        
        %define in which case i am
        if df == 0
            break;
        elseif df > 0 %df > 0
            k = k+1;
            B = x1;
            x1 = (A+B)/2;
        else %df < 0
            k = k+1;
            A = x1;
            x1 = (A+B)/2;
        end
        %update value of derivative
        df = subs(diff(f3),x1);
        %df = vpa(subs(f1, x, x1)); %calculate df(x1)/dx
        
        %just a print message
        fprintf('k:%d  x1:%f  A:%f  B:%f  df:%f\n', k, x1, A, B, df);
    end
    plot(l,k, 'r.'); %Horizontal axis = epsilon values....Vertical axis = k values
    hold on;
    fprintf("\n");
end

%set x and y axis limits for better representation 
xlim([25*10^(-3) 80*10^(-3)]); %set figure limit of x Axis 
ylim([20.6 21.4]); %set figure limit of y Axis

xlabel('lambda values');
ylabel('iterations needed to finish the algorithm');

title('f3(x) = (x+2)^2+exp(x-2)*sin(x+3);');
grid on;


