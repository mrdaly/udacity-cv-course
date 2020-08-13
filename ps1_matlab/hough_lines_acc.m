function [H, theta, rho] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    %
    % Please see the Matlab documentation for hough():
    % http://www.mathworks.com/help/images/ref/hough.html
    % Your code should imitate the Matlab implementation.
    %
    % Pay close attention to the coordinate system specified in the assignment.
    % Note: Rows of H should correspond to values of rho, columns those of theta.

    %% Parse input arguments
    p = inputParser();
    addParameter(p, 'RhoResolution', 1);
    addParameter(p, 'Theta', linspace(-90, 89, 180));
    parse(p, varargin{:});

    rhoStep = p.Results.RhoResolution;
    theta = p.Results.Theta;

    %% Your code here
    D = norm(size(BW));
    ntheta = length(theta);
    rho = -D:rhoStep:D;
    nrho = length(rho)+1;
    slope = (nrho - 1)/(max(rho)-min(rho));

    H = zeros(nrho,ntheta);
    
    [Y,X] = find(BW);
    edge_points = [X,Y];
    npoints = length(edge_points);
    
    for i = 1:npoints
        x = edge_points(i,1);
        y = edge_points(i,2);
        for t = 1:ntheta
            d = x*cosd(theta(t)) + y*sind(theta(t));
   
            rhoIdx = 1 + round(slope * (d - min(rho)));

            H(rhoIdx,t) = H(rhoIdx,t) + 1;
        end
    end
    
end
