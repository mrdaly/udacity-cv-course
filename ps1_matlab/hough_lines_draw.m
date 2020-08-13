function new_img = hough_lines_draw(img, outfile, peaks, rho, theta)
    % Draw lines found in an image using Hough transform.
    %
    % img: Image on top of which to draw lines
    % outfile: Output image filename to save plot as
    % peaks: Qx2 matrix containing row, column indices of the Q peaks found in accumulator
    %       lines defined by peaks must intersect image, i.e. function is
    %       undefined for lines that only occur outside of the coordinates of
    %       image
    % rho: Vector of rho values, in pixels
    % theta: Vector of theta values, in degrees

    height = size(img, 1);
    width = size(img, 2);
    new_img = img;
    for i = 1:size(peaks)
        row = peaks(i,1);
        col = peaks(i,2);
        rh = rho(row);
        th = theta(col);
        
        if th == 0 % vertical line
            % intersection with image's top border
            x1 = rh;
            y1 = 0;
            % intersection with image's bottom border
            x2 = rh;
            y2 = height;
            
            new_img = insertShape(new_img, 'Line', [x1 y1 x2 y2]);
        elseif th == -90 % horizontal line
            % intersection with image's left border
            x1 = 0;
            y1 = -rh; %inverted because theta is -90
            % intersection with image's right border
            x2 = width;
            y2 = -rh;
            
            new_img = insertShape(new_img, 'Line', [x1 y1 x2 y2]);
        else % find intersections with top/bottom/left/right borders, it
             % must intersect with exactly 2 borders of the image 
            xIntercept = rh / cosd(th);
            yIntercept = rh / sind(th);
            bottomIntercept = (rh - height*sind(th)) / cosd(th);
            rightIntercept = (rh - width*cosd(th)) / sind(th);
            
            interceptsTopBorder = xIntercept >= 0 && xIntercept <= width;
            interceptsLeftBorder = yIntercept > 0 && yIntercept <= height;
            interceptsBottomBorder = bottomIntercept > 0 && bottomIntercept <= width;
            interceptsRightBorder = rightIntercept > 0 && rightIntercept < height;
            
            interceptsMask = [interceptsTopBorder;
                              interceptsLeftBorder;
                              interceptsBottomBorder;
                              interceptsRightBorder];
            intercepts = [xIntercept, 0; % top border intercept
                          0, yIntercept; % left border intercept
                          bottomIntercept, height; % bottom border intercept
                          width, rightIntercept]; % right border intercept
            intercepts = intercepts(interceptsMask, :);
            x1 = intercepts(1, 1);
            y1 = intercepts(1, 2);
            x2 = intercepts(2, 1);
            y2 = intercepts(2, 2);
            new_img = insertShape(new_img, 'Line', [x1 y1 x2 y2]);
        end
    end
    imwrite(new_img, fullfile('output', outfile));
end
