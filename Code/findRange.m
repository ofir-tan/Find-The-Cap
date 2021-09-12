function radius_range = findRange(I,radius_range)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
% Define thresholds for channel 1 based on histogram settings
%%
[centers,radii] = imfindcircles(I,radius_range, ...
    'ObjectPolarity','bright','Sensitivity',0.98,'EdgeThreshold',.3);
BW = false(size(I,1), size(I,2));
[Xgrid,Ygrid] = meshgrid(1:size(BW,2),1:size(BW,1));
for n = 1:3
    BW = BW | (hypot(Xgrid-centers(n,1),Ygrid-centers(n,2)) <= radii(n));
end
% Filter image based on image properties.
stats = regionprops('table', BW, 'Centroid', ...
    'MajorAxisLength', 'MinorAxisLength');
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength], 2);
radius = mean(diameters/2);
radius_range = round([radius - 4, radius + 4]);

end