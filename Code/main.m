%% 'Find The Cap' - Video Processing Project
% % Introduction to Digital Image Processing - 361.1.4751, BGU Course 2020-2021
% % © Ofir Tanami
preview(cam);
cam = webcam(1);
cam.Resolution = '960x540';
depVideoPlayer = vision.DeployableVideoPlayer;

%% read the first frame to initialize:
videoFrame = snapshot(cam);
size_ = size(videoFrame);
resolution = size_(1:2);
cupsNumber = 3;
sample = false;
update_rate = 2; % Hz
update_flag = 1;
radius_range = [37 47];
radius_range = findRange(videoFrame,radius_range);
sum = zeros(1,4);
type = 3;
logo = imread("logo.jpg");
mask = logo(:,:,1) ~= 0 & logo(:,:,3) ~= 0 & logo(:,:,2) ~= 0;

%% initialize:
[cups,cap,center,radius_range] = initialGame(videoFrame,cupsNumber,...
    resolution,radius_range,type);
state = "Exposed Object";

%% Main Loop:
while true
    sample = xor(sample,true);
    if 1
        videoFrame = snapshot(cam);     
        center = findCap(videoFrame,cap,20,type);
        %% find state:
        if ~isempty(center)
            % if the cap found:
            state = "Exposed Object";
        elseif state == "Exposed Object" || state == "Error"
            state = "Match";
        else
            state = "Track";
        end
        % Update center location of cup's:
        state = trackCups(cups,videoFrame,state,radius_range,1.3);
        %% State Machine:
        if state == "Exposed Object"
            cap.update(center);
            videoFrame = cap.tag(videoFrame);
            for i = 1:cupsNumber
                if cups{i}.contain
                    cups{i}.unset();
                end
            end
        elseif state == "Match"
            % match Cups and cap...
            detectCup(cap.center,cups);
            state = "Track";
        elseif state == "Track"
            for i = 1:cupsNumber
                if cups{i}.contain
                    cap.update(cups{i}.center);
                end
            end
        elseif state == "Error"
            disp("Error")
        end
        %% Tag frame and display:
        % Insert tag to each cup:
        for i = 1:cupsNumber
            videoFrame = cups{i}.tag(videoFrame);
        end
        update_flag = update_flag + 1;
        % Display video:
        videoFrame = logo + videoFrame;
        depVideoPlayer(videoFrame);
        % writeVideo(myVideo, videoFrame);
    end
end
