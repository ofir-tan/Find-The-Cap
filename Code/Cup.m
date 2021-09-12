classdef Cup < handle
    %% Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021 
    properties
        radius
        center 
        contain
        direction
        arrow
    end
    %% Cup Constructor: 
    methods
        function self = Cup(radius,center)
            self.radius = radius;
            self.center = center;
            self.contain = false;
            self.direction = [0 0];
        end
    end
    %% Methods:
    methods
        function update(self,r,loc)
            self.radius = r;
            self.center = loc;
        end                 
        function set(self)
            self.contain = true;
        end 
        function unset(self)
            self.contain = false;
        end  
        function d = dist(self,loc), d = norm(self.center - loc); end
        
        function J = tag(self,I)
            label = {'Nothing here...','Blue Cap Here!'};
            color = {'y','cyan'};
            position = [self.center(1) self.center(2) self.radius];
            J = insertObjectAnnotation(I,'circle',position,...
                label{1 + self.contain},'LineWidth',2,'Color'...
                ,color{1 + self.contain},'TextColor','black','fontsize',15);
        end
    end
end

