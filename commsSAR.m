bitsPerPixel = 8;
days2sec = 24*3600; %in s
sqkm2sqm = 1000000; %in m
min2sec = 60;%in s
CompRate = 4;

%% SAR requirements bandwidth

SARsearchArea = 138000; %km²/day
resSAR = 1; %in m
resSAR_SQM = resSAR*resSAR;%in m² 
SARbwNotComp = (((SARsearchArea*sqkm2sqm)/resSAR_SQM)*bitsPerPixel)/days2sec;
SARbw = SARbwNotComp / CompRate;

%% SAP spot images bandwidth

NofSAPimg = 1900; %img/day
resSAP = 0.3;%in m
resSAP_SQM = resSAP*resSAP;%in m²
AreaSpot = 4; %in km²
SAPbwNotComp = ((((NofSAPimg/days2sec)*AreaSpot)*sqkm2sqm)/resSAP_SQM)*bitsPerPixel;
SAPbw = SAPbwNotComp / CompRate;

%% GMTI radar capabilty bandwidth

GMTIrate = 15000; %Km²/min
resGMTI = 10;%in m
resGMTI_SQM=resGMTI*resGMTI;%in m²
GMTIbwNotComp = (((GMTIrate/min2sec)*sqkm2sqm)/resGMTI_SQM)*bitsPerPixel;
GMTIbw = GMTIbwNotComp / CompRate;

%% Total bandwidth

bw = SARbw + SAPbw + GMTIbw;