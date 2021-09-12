webcamlist
%%
cam = webcam(3);
cam.Resolution = '1920x1080';
cam.Resolution = '864x480';
%%
cam.AvailableResolutions;
preview(cam);
%%
depVideoPlayer = vision.DeployableVideoPlayer;
%%
for i =  1:1000
    videoFrame = snapshot(cam);
    depVideoPlayer(videoFrame);
end