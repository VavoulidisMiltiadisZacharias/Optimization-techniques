clc;
clear; 
clear all;

%define the independent variables
syms x y;

%define the function
f = x^3*exp(-x^2-y^4);

%Variables declaration (these variables do not get updated till the end of the algorithm)
i = 0;%for loop counter 
%limit = [0.0001];%limit
limit = 0.002;

%Set initial step. Value changes within every "i-th" iteration
gamma = 1.1;

%Caclulate the partial derivatives of f
%diff(f, 'x')
%diff(f, 'y')

for i=1:10
   
    %Set initial values to variables (need to reset these variables within every iteration)
    k = 0;
    xo = 0;
    yo = 0;
    xValue = 0; %(Generally is: x of k+1)
    yValue = 0; %(Generally is: y of k+1)
    
    %update step
    gamma = gamma - 0.05;
    
    %Calculate the initial value of gradient of f and the initial value of direction vector 
    %(and print to check if they work)
    gradient_of_f(x,y) = gradient(f,[x,y])
    gradient_of_f = vpa(gradient_of_f(xo,yo)); %k = 0 for now
    d = (-1)*gradient_of_f; %set the direction vector
    %print the direction vector to check it
    %fprintf("Direction vector: %f\n", d);
    fprintf("-----------------------------------------------------\n\n");
    fprintf("Initial gradient of f is: %f\n", gradient_of_f);
    fprintf("Initial direction vector_1st element: %f\n", d(1));
    fprintf("Initial direction vector_2nd element: %f\n", d(2));
    fprintf("\n");
    
    %Update x as long as absolute value of gradient_of_f is greater than a pre set limit
    while(abs(d(1)) > limit || abs(d(2)) > limit)  %this is sort of equal to (gradient_of_f > limit 0)

        k=k+1;
        xValue = xo + gamma*d(1);
        yValue = yo + gamma*d(2);

        gradient_of_f(x,y) = gradient(f,[x,y]);
        gradient_of_f = vpa(gradient_of_f(xValue,yValue)); %reset the gradient_of_f
        d = (-1)*gradient_of_f; %reset the direction vector
        
        %Update xo and yo for the next iteration of while loop
        xo = xValue;
        yo = yValue;
        
        fprintf("i: %d  k:%d  step: %.2f  Value of f: %.10f  abs(d1): %f  abs(d2): %f  limit %.4f\n",i, k, gamma, subs(f,{x,y},{xValue,yValue}), abs(d(1)), abs(d(2)), limit );
        if i == 1
            f_value = subs(f,{x,y},{xValue,yValue});
            plot(k, f_value, "r.");
            hold on;
    
            grid on;
        end 
    end
    fprintf("\n\n");
    fprintf("The algorithm has finished: \n");
    %fprintf("Gradient of f is: %f\n", gradient_of_f);
    gradient_of_f %print the gradient_of_f in command window
    fprintf("Iterations needed to finish: %d\n", k)%k is the number of iteration needed to finish the algorithm
    fprintf("Last value of x is: %f\n", xValue);
    fprintf("Last value of y is: %f\n", yValue);
    f_value = subs(f,{x,y},{xValue,yValue});
    fprintf("Minimum value of f is: %f\n", f_value);
    
end

%{
fprintf("\n\n");
fprintf("The algorithm has finished: \n");
%fprintf("Gradient of f is: %f\n", gradient_of_f);
gradient_of_f %print the gradient_of_f in command window
fprintf("Iterations needed to finish: %d\n", k)%k is the number of iteration needed to finish the algorithm
fprintf("Last value of x is: %f\n", xValue);
fprintf("Last value of y is: %f\n", yValue);
fprintf("Minimum value of f is: %f\n", subs(f,{x,y},{xValue,yValue}));
%}

title('f(x,y) = x^3*e^(-x^2-y^4)')
xlabel('iterations needed to finish the algorithm') 
ylabel('f value'); 


