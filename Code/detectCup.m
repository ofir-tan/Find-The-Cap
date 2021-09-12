function detectCup(objectCenter,cups)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
N = length(cups);
dist = zeros(N,1);
for i = 1:N   
    dist(i) = norm(cups{i}.center - objectCenter);
end
[~,index] = min(dist);
% if we already found the cap
for i = 1:N
    if cups{i}.contain
        return;
    end
end
cups{index}.set();
end