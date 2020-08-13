function peaks = hough_peaks(H, varargin)
    % Find peaks in a Hough accumulator array.
    %
    % Threshold (optional): Threshold at which values of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Please see the Matlab documentation for houghpeaks():
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    % Your code should imitate the matlab implementation.

    %% Parse input arguments
    p = inputParser;
    addOptional(p, 'numpeaks', 1, @isnumeric);
    addParameter(p, 'Threshold', 0.5 * max(H(:)));
    addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 2 + 1);  % odd values >= size(H)/50
    parse(p, varargin{:});

    numpeaks = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;

    % TYour code here
    peaks = zeros(numpeaks,2);
    Q = 0; %found peaks
    H_tmp = H;
    [H_rows, H_cols] = size(H);
    while true
        [~, max_idx] = max(H_tmp(:));
        if H_tmp(max_idx) < threshold
           break; 
        end
        [r,c] = ind2sub(size(H),max_idx);
        Q = Q + 1;
        peaks(Q,:) = [r c];
        
        % suppress neighborhood
        nhood_start_row = r - floor(nHoodSize(1)/2);
        nhood_start_col = c - floor(nHoodSize(2)/2);
        nhood_start_row = max(1,nhood_start_row);
        nhood_start_col = max(1,nhood_start_col);
        
        nhood_end_row = r + floor(nHoodSize(1)/2);
        nhood_end_col = c + floor(nHoodSize(2)/2);
        nhood_end_row = min(H_rows,nhood_end_row);
        nhood_end_col = min(H_cols,nhood_end_col);
        
        H_tmp(nhood_start_row:nhood_end_row, nhood_start_col:nhood_end_col) = 0;
        
        % check if done
        if Q >= numpeaks
           break 
        end
    end
    peaks = peaks(1:Q,:); %crop array to what we found
end
