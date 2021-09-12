classdef FlyObject < handle
    %% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
    properties
        img
        pImg
        pMask
        center
        name
        BoundingBox
        radius
    end
    %% FlyObject Constructor:
    methods
        function self = FlyObject(I,mask,name,resolution)
            self.img = I;
            self.pImg = self.pad(I,resolution,0);
            self.pMask = self.pad(mask,resolution,1);
            self.name = name;
            stats = regionprops(mask,'Centroid','BoundingBox'...
                ,'MajorAxisLength','MinorAxisLength');
            self.BoundingBox = stats.BoundingBox;
            self.center = stats.Centroid;
            self.radius = round(mean([stats.MajorAxisLength...
                stats.MinorAxisLength],2) / 2);
        end
    end
    %% Methods:
    methods
        function pImg = pad(~,I,resolution,padWith)
            R = (resolution(1) - size(I,1)) / 2;
            C = (resolution(2) - size(I,2)) / 2;
            pImg = padarray(I,[R C],padWith,'both');
        end
        
        function [I] = paste(self,I,new_loc)
            temp = I(new_loc(1) - size(self.img,1)/2:...
                new_loc(1)+size(self.img,1)/2,new_loc(2)-size(self.img,2)/2:...
                new_loc(2)+size(self.img,2)/2);
            I(temp) = self.img + I(temp);
        end
        
        function [I,BW] = move(self,new_loc)
            I = imtranslate(self.pImg, new_loc - self.center);
            BW = imtranslate(self.pMask, new_loc - self.center...
                ,'FillValues',255);
            
        end
        function J = tag(self,I)
            position = [self.center(1) self.center(2) self.radius];
            J = insertObjectAnnotation(I,'circle',position,...
                self.name,'LineWidth',2,'Color'...
                ,'green','TextColor','black','fontsize',10);
        end
        function update(self,center,pMask)
            if nargin == 3
                self.pMask = pMask;
                stats = regionprops(pMask,'Centroid','BoundingBox'...
                    ,'MajorAxisLength','MinorAxisLength');
                self.BoundingBox = stats.BoundingBox;
                self.radius = mean([stats.MajorAxisLength...
                    stats.MinorAxisLength],2)/2;
            end
            self.center = center;
        end
    end
end

