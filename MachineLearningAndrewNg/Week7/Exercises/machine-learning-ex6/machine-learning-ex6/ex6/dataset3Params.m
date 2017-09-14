function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%


step = 3 + 1/3;
num_steps = 10;
C_array = [0.01 0.03 0.1 0.3 1 3 10 30];
sigma_array = C_array;
num_steps = size(sigma_array, 2);



error_min = 9*10^6;
C_min = 0;
sigma_min = 0;

for i = 1:num_steps
    for j = 1:num_steps
	model= svmTrain(X, y, C_array(i), @(x1, x2) gaussianKernel(x1, x2, sigma_array(j)));
	predict = svmPredict(model, Xval);
	err = mean(double(predict ~= yval));
	fprintf("Executing loop (%d:%d)\n", i, j);
	fprintf("Minimum_error = %f error = %f\n", error_min, err);
	if (err < error_min)
    	    C_min = C_array(i);
	    sigma_min = sigma_array(j);
	    error_min = err
	end
    end
end

C = C_min;
sigma = sigma_min;

% =========================================================================

end
