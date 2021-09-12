function [J,offset] = pCrop(I,center,r)
center = round(center);
r = round(r);

a = max([1, center(2) - r]);
b = min([size(I,1), center(2) + r]);
c = max([1, center(1) - r]);
d = min([size(I,2), center(1) + r]);

J = I(a:b,c:d,:);
offset = [c-1,a-1];
end