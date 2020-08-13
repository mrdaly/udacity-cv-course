function H = hough_circles_acc(BW, radius)
    % Compute Hough accumulator array for finding circles.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius: Radius of circles to look for, in pixels

    height = size(BW,1);
    width = size(BW,2);
    
    H = zeros(height, width);
    
    [Y,X] = find(BW);
    edge_points = [X,Y];
    npoints = length(edge_points);
    thetas = 1:360;
    
    for i = 1:npoints
        x = edge_points(i,1);
        y = edge_points(i,2);
        
        for t = thetas
            xh = floor(x + radius*cosd(t));
            yh = floor(y + radius*sind(t));
            
            % only vote if point to vote for is in image
            if xh >= 1 && xh <= width && yh >=1 && yh <= height
               H(yh,xh) = H(yh,xh) + 1; 
            end
        end
    end
end
