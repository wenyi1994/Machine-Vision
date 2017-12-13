clear all;
close all;
clc;

%% Assign4.m
%  Practical Exercises: Calibration and Perspective Projection
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/12/13

%% 1. Apply Tsai's calibration
w = load('calibration_worldpos.txt');
im = imread('calibration.png');
imd = im2double(im);

figure('name','Tsai''s Calibration','numbertitle','off');
imshow(imd);

hold on;
% Result of measure
manual = [135,418; ...  1
          306,398; ...  2
          436,355; ...  3
          551,314; ...  4
          81,282;  ...  5
          56,216;  ...  6
          39,168;  ...  7
          216,178; ...  8
          393,214; ...  9
          29,54;   ...  10
          178,42;  ...  11
          300,42;  ...  12
          370,74;  ...  13
          411,93;  ...  14
          529,151; ...  15
          262,279];...  16
plot(manual(:,1),manual(:,2),'go','linewidth',3);
hold on;

C = [w,manual];
[A, R, T] = tsai(C);
disp('intrinsic parameters:');
disp(A);
disp('----------------------------------------------------');

%% 2. Calculate average reprojection error
xyz(16,3) = 0;
uv1(16,3) = 0;
for i = 1:16
    xyz(i,:) = (R * w(i,:)' + T)';
    uv1(i,:) = (A * xyz(i,:)' ./ xyz(i,3))';
end

plot(uv1(:,1),uv1(:,2),'ro','linewidth',3);

Error_Sum = sum(sqrt((( manual(:,1) - uv1(:,1) ) .* ( manual(:,1) - uv1(:,1) )) + (( manual(:,2) - uv1(:,2) ) .* ( manual(:,2) - uv1(:,2) ))));
Error_avrg = Error_Sum ./ 16;

disp('Sum Error:');
disp(['                ', num2str(Error_Sum)]);
disp('----------------------------------------------------');
disp('average Error:');
disp(['                ', num2str(Error_avrg)]);
disp('----------------------------------------------------');

%% 3. Calculate height of table
ABCD = [387,189; 528,288; 606,260; 464,174];
plot(ABCD(:,1),ABCD(:,2),'yo','linewidth',3);
hold on;

mn(6,3) = 0;
coeffi_1(6,1) = 0;
coeffi_2(6,1) = 0;
coeffi_3(6,1) = 0;
coeffi_4(6,1) = 0;
coeffi_5(6,1) = 0;
coeffi_6(6,1) = 0;
w_ABCD(4,2) = 0;

EF = [400,69; 564,142];
plot(EF(:,1),EF(:,2),'bo','linewidth',3);
legend('manual','projection','On ground','On table');

h_EF(4,1) = 0;

for i = 1:4
    % (R11 - R31*m) * a + (R12 - R32*m) * b = T3*m - T1
    % (R21 - R31*n) * a + (R22 - R32*n) * b = T3*n - T2
    mn(i,:) = ( inv(A) * [ABCD(i,1);ABCD(i,2);1] )';
    coeffi_1(i) = R(1,1) - R(3,1) * mn(i,1);
    coeffi_2(i) = R(1,2) - R(3,2) * mn(i,1);
    coeffi_3(i) = T(3) * mn(i,1) - T(1);
    coeffi_4(i) = R(2,1) - R(3,1) * mn(i,2);
    coeffi_5(i) = R(2,2) - R(3,2) * mn(i,2);
    coeffi_6(i) = T(3) * mn(i,2) - T(2);
    co_mat = [coeffi_1(i), coeffi_2(i); coeffi_4(i), coeffi_5(i)];
    y_mat = [coeffi_3(i); coeffi_6(i)];
    w_ABCD(i,:) = ( co_mat \ y_mat )';
end

for i = 5:6
    % c = ( T3*m - T1 - (R11 - R31*m) * a - (R12 - R32*m) * b ) / (R13 - R33*m)
    % c = ( T3*n - T2 - (R21 - R31*n) * a - (R22 - R32*n) * b ) / (R23 - R33*n)
    mn(i,:) = ( inv(A) * [EF(i-4,1);EF(i-4,2);1] )';
    coeffi_1(i) = R(1,1) - R(3,1) * mn(i,1);
    coeffi_2(i) = R(1,2) - R(3,2) * mn(i,1);
    coeffi_3(i) = T(3) * mn(i,1) - T(1);
    coeffi_4(i) = R(2,1) - R(3,1) * mn(i,2);
    coeffi_5(i) = R(2,2) - R(3,2) * mn(i,2);
    coeffi_6(i) = T(3) * mn(i,2) - T(2);
    h_EF(i*2 - 9) = ( coeffi_3(i) - coeffi_1(i) * w_ABCD(i-4,1) - coeffi_2(i) * w_ABCD(i-4,2) ) / (R(1,3) - R(3,3)*mn(i,1));
    h_EF(i*2 - 8) = ( coeffi_6(i) - coeffi_4(i) * w_ABCD(i-4,1) - coeffi_5(i) * w_ABCD(i-4,2) ) / (R(2,3) - R(3,3)*mn(i,2));
end

h = 0.5 * (h_EF(1) + h_EF(2));
disp('Height of table:');
disp(['                ',num2str(h)]);