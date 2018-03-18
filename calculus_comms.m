compresion_rate=4;

%EO video capabilities
res_400=640*400;
res_480=640*480;
res_720=1280*720;
res_1080=1920*1080;

resolution_EO=res_400/10^6;%Mpx

Freq=23; %in Hz
Grey_lvls=4;

consumption_vid_EO=(resolution_EO*Freq*Grey_lvls)/compresion_rate;

%EO photo capabilities

res=5; %MBites
bits_per_px=8;

consumption_pic_EO=(res*bits_per_px)/compresion_rate;
