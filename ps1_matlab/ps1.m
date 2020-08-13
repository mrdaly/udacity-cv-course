% ps1

%% 1-a
clear
img = imread(fullfile('input', 'ps1-input0.png'));  % already grayscale
%% Compute edge image img_edges
img_edges = edge(img, 'sobel');
imwrite(img_edges, fullfile('output', 'ps1-1-a-1.png'));  % save as output/ps1-1-a-1.png
imshow(img_edges)
%% 2-a
[H, theta, rho] = hough_lines_acc(img_edges);  % defined in hough_lines_acc.m
%% Plot/show accumulator array H, save as output/ps1-2-a-1.png
imshow(mat2gray(H));
imwrite(mat2gray(H), fullfile('output', 'ps1-2-a-1.png'));
%% 2-b
peaks = hough_peaks(H, 10);  % defined in hough_peaks.m
%% Highlight peak locations on accumulator array, save as output/ps1-2-b-1.png
imshow(mat2gray(H))
hold on
plot(peaks(:,2),peaks(:,1), 'r+')

%% draw lines
new_img = hough_lines_draw(img, 'ps1-2-c-1.png', peaks, rho, theta);
imshow(new_img)

%% 3-a
clear
noisy_img = imread(fullfile('input', 'ps1-input0-noise.png'));
smoothed_img = imgaussfilt(noisy_img,2);
imwrite(smoothed_img, fullfile('output','ps1-3-a-1.png'));

%% 3-b
noisy_edges = edge(noisy_img);
smoothed_edges = edge(smoothed_img);
imwrite(noisy_edges, fullfile('output','ps1-3-b-1.png'));
imwrite(smoothed_edges, fullfile('output','ps1-3-b-2.png'));

%% 3-c
[H, theta, rho] = hough_lines_acc(smoothed_edges, 'Theta', -90:87);
peaks = hough_peaks(H, 10, 'Threshold', 0.35*max(H(:)));
imshow(mat2gray(H));
hold on
plot(peaks(:,2),peaks(:,1), 'r+')
hold off
%% draw lines
new_img = hough_lines_draw(noisy_img, 'ps1-3-c-2.png', peaks, rho, theta);
imshow(new_img)
%% 4-a
clear
img = imread(fullfile('input', 'ps1-input1.png'));
img = rgb2gray(img);
blurred_img = imgaussfilt(img,2);
imshow(blurred_img)
%% 4-b
edges = edge(blurred_img);
imshow(edges)
%% 4-c
[H, theta, rho] = hough_lines_acc(edges);
peaks = hough_peaks(H, 10, 'Threshold', 0.35*max(H(:)));
imshow(mat2gray(H));
hold on
plot(peaks(:,2),peaks(:,1), 'r+')
hold off

%% draw lines
new_img = hough_lines_draw(img, 'ps1-4-c-2.png', peaks, rho, theta);
imshow(new_img)

%% 5-a
clear
img = imread(fullfile('input', 'ps1-input1.png'));
img = rgb2gray(img);
blurred_img = imgaussfilt(img,2);
edges = edge(blurred_img);

H = hough_circles_acc(edges, 20);
peaks = hough_peaks(H, 10,'Threshold', 0.7*max(H(:)));
imshow(mat2gray(H));
hold on
plot(peaks(:,2),peaks(:,1), 'r+')
hold off
%TODO: DRAW CIRCLES

%% 5-b
%TODO: IMPLEMENT 'find_circles' AKA FIND CIRCLES ACROSS RANGE OF RADII

%% 6-a
clear
img = imread(fullfile('input', 'ps1-input2.png'));
img = rgb2gray(img);
blurred_img = imgaussfilt(img,2);
edges = edge(blurred_img, 'canny');

[H, theta, rho] = hough_lines_acc(edges);
peaks = hough_peaks(H, 15, 'Threshold', 0.3*max(H(:)));
imshow(mat2gray(H));
hold on
plot(peaks(:,2),peaks(:,1), 'r+')
hold off

% draw lines
new_img = hough_lines_draw(img, 'ps1-6-a-1.png', peaks, rho, theta);
figure
imshow(new_img)
