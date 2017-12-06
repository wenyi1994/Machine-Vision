## Introduction to Image Opera
This is a GUI-Tool of image operations. It can divide the image into several segments with CCL or K-means algorithm. Further more, it can execute some morphological operations on original/segmented image.

### Install and Run
1. Download all the files in directory [GUI](https://github.com/wenyi1994/Machine-Vision/tree/master/Assignment4/GUI) and put them in Workpath of MATLAB.
2. Run MATLAB and open script [ImageOpera.m](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/ImageOpera.m).
3. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/MATLAB_RUN.png) to start this GUI programm.
> The main interface of the programm: ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/GUI_Start.png)

### Apply CCL (connected components labeling) algorithm of segmentation on image
1. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/open_button.png) on toolbar and select an image file.
2. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/CCL_button.png) to open CCL operation window.  
![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/CCL_window.png)  
In this window some parameters of CCL operation can be set.
3. Click `OK` button to apply it on image.

### Apply K-means algorithm of segmentation on image
1. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/open_button.png) on toolbar and select an image file.
2. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/KM_button.png) to open K-means operation window.  
![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/KM_window.png)  
Also the number of `k` can be set and varied.
3. Click `OK` button to apply it on image.

### Execute morphological operations on image
1. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/open_button.png) on toolbar and select an image file.
2. Click ![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/Mo_button.png) to open morphological operation window.  
![image](https://github.com/wenyi1994/Machine-Vision/blob/master/Assignment4/GUI/pics/MO_window.png)  
The mask that used to execute operations can be chosen or just customized by clicking `Customize` radio button. Input an regular binary matrix (like `[1,0,1; 0,1,0; 1,0,1]`) and the result of mask will be shown.
3. Click `Erosion`, `Dilation`, `Closing` or `Opening` button to apply operations on image.
