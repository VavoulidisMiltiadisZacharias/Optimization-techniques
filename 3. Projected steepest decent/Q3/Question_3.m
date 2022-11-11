clc;
clear;
clear all;

%define the independent variables
syms x y;

%define the function
f = (x^2)/2 + 2*(y^2);

epsilon = 0.02;

%Set initial step. Value changes within every "i-th" iteration
gamma = 0.3;
%s = 10; %No convergence
s = 1; %With convergence

%Caclulate the partial derivatives of f
%diff(f, 'x')
%diff(f, 'y')
    
%Set initial values to variables (need to reset these variables within every iteration)
k = 0;
    
%initialize x and y
xValue = -7; %(Generally is: x of k+1)
yValue = 5; %(Generally is: y of k+1)
xBar = 0;
yBar = 0;
    
%Calculate the initial value of gradient of f and the initial value of direction vector 
%(and print to check if they work)
gradient_of_f(x,y) = gradient(f,[x,y])
gradient_of_f = vpa(gradient_of_f(xValue,yValue)); %k = 0 for now
d = (-1)*gradient_of_f; %set the direction vector
%print the direction vector to check it
%fprintf("Direction vector: %f\n", d);
fprintf("-----------------------------------------------------\n\n");
fprintf("Initial gradient of f is: %f\n", gradient_of_f);
fprintf("Initial direction vector_1st element: %f\n", d(1));
fprintf("Initial direction vector_2nd element: %f\n", d(2));
fprintf("\n");
   
%Update x as long as absolute value of gradient_of_f is greater than a pre set limit
 while(norm(d) > epsilon)  %this is sort of equal to (gradient_of_f > limit 0)
   
     k=k+1;
     
     %Working to find the projection, xBar, ybar etc
     tempX = xValue - s*gradient_of_f(1);
     if(xValue <= -15)
         xBar = -15;
     elseif (xValue > 15)
         xBar = 15;
     else 
         xBar = tempX;
     end 
     
     tempY = yValue - s*gradient_of_f(2);
     if(yValue <= -20)
         yBar = -20;
     elseif (yValue > 12)
         yBar = 12;
     else 
         yBar = tempY;
     end
     
     xValue = xValue + gamma*(xBar - xValue);
     yValue = yValue + gamma*(yBar - yValue);

     gradient_of_f(x,y) = gradient(f,[x,y]);
     gradient_of_f = vpa(gradient_of_f(xValue,yValue)); %reset the gradient_of_f
     d = (-1)*gradient_of_f; %reset the direction vector
        
     fprintf("k:%d  step: %.2f  Value of f: %.10f xValue: %f  yValue: %f  norm(d): %f  epsilon %.3f\n", k, gamma, subs(f,{x,y},{xValue,yValue}),xValue, yValue, norm(d), epsilon );
     
     f_value = subs(f,{x,y},{xValue,yValue});
     plot(k, f_value, "r.");
     hold on;
     
     if(k == 300)
         break;
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

title('f(x,y) = (x^2)/2 + 2*(y^2)');
xlabel('iterations needed to finish the algorithm'); 
ylabel('f value'); 

grid on;

