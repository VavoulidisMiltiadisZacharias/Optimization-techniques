
clc;
clear;
clear all;

%variables declaration/initialization
l = 0.08; %starting lambda value
epsilon = 0.001; %epsilon value - fixed value
j = 16; %fibonacci's 16th number

%define functions
%f1 = @(x) (x-3)^2+(sin(x+3))^2;
%f2 = @(x)(x-1)*cos(x/2)+x^2;
f = @(x) (x+2)^2+exp(x-2)*sin(x+3);


for i=1:10 %update lambda 9 times (run for 10 different lambda)

    A = -4;
    B = 4;
    x1 = A + fibonacci(j - 2)/fibonacci(j) * (B - A);
    x2 = A + fibonacci(j - 1)/fibonacci(j) * (B - A);
    f(x1);
    f(x2);
    k = 1;
    l = l-0.005;%update lambda
    
    
    while(B - A) > l %continue execution as long as this is true
        if f(x1) > f(x2)
            a = x1;
            x1 = x2;
            x2 = A+(fibonacci(j - k - 1)/fibonacci(j - k))*(B - A);
            if k == j - 2
                x2 = x1 + epsilon;
                if f(x1) > f(x2)
                    A = x1;
                else
                    B = x2;
                end
                break;
            else
                k = k + 1;
            end
        else
            B = x2;
            x2 = x1;
            x1 = A+(fibonacci(j - k - 2)/fibonacci(j - k))*(B - A);
            if k == j - 2
                x2 = x1 + epsilon;
                if f(x1) > f(x2)
                    A = x1;
                else
                    B = x2;
                end
                break;
            else
                k = k + 1;
            end
        end
        
        plot(k, A, 'r.');
        hold on;
        plot(k, B, 'b.');
        fprintf('k:%d  l:%d  x1:%f  x2:%f  A:%f  B:%f  fx1:%f  fx2:%f\n', k, l, x1, x2, A, B, f(x1), f(x2));
    end
    fprintf('\n');
end   

%set x and y axis limits for better representation 
xlim([0 15]); %set figure limit of x Axis 
ylim([-5 1]); %set figure limit of y Axis

xlabel('iterations needed to finish the algorithm');
ylabel('red dots = A   blue dots = B');

title('f3(x) = (x+2)^2+exp(x-2)*sin(x+3)');
grid on;

