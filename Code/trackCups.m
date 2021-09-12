function state = trackCups(cups,frame,state,radius_range,factor)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
N = length(cups);
I = cell(N,1);
offset = cell(N,1);
counter = 0;
epsilon = 10;

%% Static variable:
persistent n;
if isempty(n)
    n = 0;
end
%%
for i = 1:N   
    [I{i},offset{i}] = crop(frame,cups{i}.center,cups{i}.radius * factor);
    radius = round([cups{i}.radius - 2,cups{i}.radius + 2]);
    [center,radius] = imfindcircles(I{i},radius,...
        'ObjectPolarity','bright','Sensitivity',1,'EdgeThreshold',.3);
    if ~isempty(center)
        cups{i}.direction = fix((center(1,:) + offset{i} - cups{i}.center));
        cups{i}.update(radius(1),center(1,:) + offset{i});
        counter = counter + 1;
        % else if didnt find, automatic update:
    else
        % cups{i}.update(cups{i}.radius,cups{i}.center + cups{i}.direction);
        state = "Error";
        n = n + 1;
    end
    
    if n > 5 || isOverlap(cups,epsilon)
        state = trackCupsHelper(cups,frame,state,radius_range);
        n = 0;
        return;
    end   
    if counter == N
        n = 0;
    end
end
end