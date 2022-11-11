clc; 
clear;
clear all;

%variables declaration/initialization
syms x ;%define the independent variable

gamma = 0.618; %fixed value
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
    x1 = -3.9;
    x2 = 3.9;
    X = [A,0;B,0]; %hold the coordinates of A and B
    d = pdist(X, 'euclidean'); %calculate the euclidean distance of x1 and x2(need it to terminate the program)
    k = 0; %holds the number of iterations needed to finish the execution
    fx1 = 0;
    fx2 = 0;
    
    fprintf('i:%d  l:%f\n', i, l);
    while d > l %continue as long as the width is not limited enough
        fx1 = subs({f3}, {x}, {x1}); %calculate f(x1)
        fx2 = subs({f3}, {x}, {x2}); %calculate f(x2)

        %define in which case i am
        if fx1 > fx2
            k = k+1;
            A = x1;
            x1 = x2;
            x2 = A + gamma*(B-A);
        else
            k = k+1;
            B = x2;
            x2 = x1;
            x1 = A+(1-gamma)*(B-A); 
        end
        %update the distance of x1 and x2
        X = [A,0;B,0];
        d = pdist(X, 'euclidean');
        fprintf('k:%d  x1:%f  x2:%f  A:%f  B:%f  d:%f  fx1:%f  fx2:%f\n', k, x1, x2, A, B, d, fx1, fx2);
        %The difference between the a blue dot and a red dot (alligned at the
        %same vertical) is the width of the space for a specific lamda.
        %The more left the less the difference!!!(but k increases -> more iterations needed)
        plot(k, A, 'r.');
        hold on;
        plot(k, B, 'b.');
    end
    
    fprintf("\n");
end

%set x and y axis limits for better representation 
xlim([0 6]); %set figure limit of x Axis 
ylim([-5 5]); %set figure limit of y Axis

xlabel('iterations needed to finish the algorithm');
ylabel('red dots = A   blue dots = B');

title('f3(x) = (x+2)^2+exp(x-2)*sin(x+3)');
grid on;



