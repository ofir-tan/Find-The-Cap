function state = trackCupsHelper(cups,frame,state,radius_range)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
N = length(cups);
[centers,radii] = imfindcircles(frame,radius_range,...
    'ObjectPolarity','bright','Sensitivity',0.99,'EdgeThreshold',.3);
%%
dist = zeros(N,1);
if length(centers) < N
    state = "Error";
end

M = min([size(centers,1) N]);
for i = 1:M
    for j = 1:N
        dist(j) = norm(cups{j}.center - centers(i,:));
    end
    [~,index] = min(dist);
    cups{index}.direction = fix((centers(i,:) - cups{index}.center) / 4);
    cups{index}.update(radii(i),centers(i,:));
    centers(i,:) = [inf,inf];
end
end