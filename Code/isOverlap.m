function bool = isOverlap(cups,epsilon)
%% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
N = length(cups);
bool = false;
for i = 1:N
    for j = i+1:N
        if epsilon > norm(cups{j}.center - cups{i}.center)
            bool = true;
            return;
        end        
    end
end
end