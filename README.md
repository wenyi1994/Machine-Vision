# Machine_Vision
Matlab (perhaps also other) codes for realization of assignments of course Machine Vision in KIT

## Assignment 2: Edge Detection and Hough Transformation
1. Use Sobel Filter to calculate the grey value gradient of the image 'postit2g.png', display and compare the results;
2. Generate edge image with Canny- and the LoG-approach, both of them are MATLAB built-in function;
3. Perform the Hough Transformation on egde image and plot the respective lines into the image.

## Assignment 3: Line Estimation
1. Use total-least-square methode to estimate the line parameters (theta, c) from a list of pixel coordinates;
2. Determine start and end point for the line by projecting all the edge-pixel points on the line;
3. Remove some distance-outmost points;
4. Use RANSAC (random sample consesus) methode to re-estimate the line parameters (theta, c) and plot these lines.
