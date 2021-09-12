function [center,BW] = firstFindCap(I,type)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
% © Ofir Tanami, Naor Cohen, Mario Denkberg, Sagi Gov.
% Convert RGB image to chosen color space
I = rgb2hsv(I);
if type == 1
    % Define thresholds for channel 1 based on histogram settings
    channel1Min = 0.537;
    channel1Max = 0.650;
    
    % Define thresholds for channel 2 based on histogram settings
    channel2Min = 0.390;
    channel2Max = 1.000;
    
    % Define thresholds for channel 3 based on histogram settings
    channel3Min = 0.282;
    channel3Max = 0.477;
elseif type == 2
    % Define thresholds for channel 1 based on histogram settings
    channel1Min = 0.549;
    channel1Max = 0.713;
    
    % Define thresholds for channel 2 based on histogram settings
    channel2Min = 0.733;
    channel2Max = 1.000;
    
    % Define thresholds for channel 3 based on histogram settings
    channel3Min = 0.228;
    channel3Max = 1.000;
else
    % Define thresholds for channel 1 based on histogram settings
    channel1Min = 0.491;
    channel1Max = 0.647;
    
    % Define thresholds for channel 2 based on histogram settings
    channel2Min = 0.644;
    channel2Max = 1.000;
    
    % Define thresholds for channel 3 based on histogram settings
    channel3Min = 0.652;
    channel3Max = 1.000;
end

% Create mask based on chosen histogram thresholds
BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

BW = imclearborder(BW);
BW = bwareafilt(BW,1);

stats = regionprops(BW,'centroid');
if isempty(stats)
    center = [];
else
    center = stats.Centroid;
    center = round(center);
end
end

