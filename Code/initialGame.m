function [cups,cap,center,radius_range] = initialGame(videoFrame,cupsNumber,resolution,radius_range,type)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
radius_range = findRange(videoFrame,radius_range);
%% initial Cup's:
cups = cell(3,1);
[centers,radii] = imfindcircles(videoFrame(:,:,2), radius_range, ...
                  'Sensitivity',0.99,'EdgeThreshold',.3);
for i= 1:cupsNumber
    cups{i} = Cup(radii(i), centers(i,:));
end

%% find the cap:
[center,BW] = firstFindCap(videoFrame,type);
cap = FlyObject(videoFrame,BW,'Blue Cap',resolution);
%% check result's:
temp = cups{1}.tag(videoFrame);
temp = cups{2}.tag(temp);
temp = cups{3}.tag(temp);
show(cap.tag(temp))
end