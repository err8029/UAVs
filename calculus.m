%inicialization for jhonson criteria95

Jhonsons95=[3.6 3 4.8 6;
            18 13.6 17.6 15.2;
            32 26 22 32];
%to select a criteria:
%row refers to 
%    detect        (1)
%    recognise     (2)
%    identify      (3)
%column referes to
%    truck         (1)
%    tank          (2)
%    car           (3)
%    person        (4)
jhonsons_criteria=Jhonsons95(3,4);

%automatization of the calculus required for UAS selection

%First part of the system the aircraft which identify
h=foot2meters(5000);
SLRangle=45;

SLR=h/cos(((2*pi)/360)*SLRangle);
Veq1=10;%in cm
Veq2=20;

Veq=[Veq1 Veq2];
FOV= Veq/jhonsons_criteria;

Npixels=sqrt(FOV*10^6)

Npixels=lines2pixels(Nlines);%700 lines is 933 so we interpolate
FOVatH=0.29;%typical FOV at 5000ft for our sensor
IFOV2=deg2mrad(FOV)/Npixels;
R=IFOV2*jhonsons_criteria;

%second part of the system the aircrafts that do SARa