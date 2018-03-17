function mostrar_dades




% EVITAR cridar dos cops
hfig = findobj('tag','MOSTRARDADES');
if (isempty(hfig))

	% crer el figure
	hfig = figure;
	set(hfig,'numbertitle','off');               % treu el numero de figura
	set(hfig,'name',['DSCR -  Monitor']);
	set(hfig,'MenuBar','none');                  % treiem els menus i els icons
	set(hfig,'doublebuffer','on');               % dos buffers de grafics
	set(hfig,'CloseRequestFcn',@tancar)          % funci� que es cridar� al tancar la finestra
	set(hfig,'tag','MOSTRARDADES');              % identifiquem la figura
    set(hfig,'Units','Normalized','Position',[0.1,0.1,0.75,0.75]);

	drawnow;
	refresh;
	
    % afegim un men� b�sic per sortir
	hmenu = uimenu('Label','&Monitor','Tag','M');
		uimenu(hmenu,'Label','Define jhonsons criteria','Callback',@funcio_test1,'tag','TEST');
		uimenu(hmenu,'Label','Define params','Callback',@f2,'tag','test2');        
		uimenu(hmenu,'Label','&exit','Callback',@tancar,'separator','on','Accelerator','E');
        
% display image
 axes_img = axes('unit', 'normalized', 'position', [0 0 1 1]); 
    tanque_img = imread('raw image.png');
    imagesc(tanque_img);

%start button
play = uicontrol('Style', 'pushbutton', 'String', 'Start calculus','Units','Normalized',...
    'Position', [0.8 0.6 0.175 0.04],...
    'Callback', @Payload_calculus);

%texts
    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.105 0.49 0.07 0.04],'BackgroundColor','black');
h_string=uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.11 0.5 0.06 0.02],'String','H=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.495 0.49 0.11 0.04],'BackgroundColor','black');
SLR_string = uicontrol('tag','SLR_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.5 0.5 0.1 0.02],'String','SLR=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.705 0.055 0.11 0.04],'BackgroundColor','black');
Veq_string = uicontrol('tag','Veq_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.71 0.065 0.1 0.02],'String','Veq=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.495 0.64 0.11 0.04],'BackgroundColor','black');
SLRangle_string = uicontrol('tag','Omax_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.5 0.65 0.1 0.02],'String','Omax=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.585 0.39 0.15 0.04],'BackgroundColor','black');
FOV_string = uicontrol('tag','FOV_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.591 0.4 0.14 0.02],'String','FOV=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.45 0.04 0.15 0.04],'BackgroundColor','black');
R_string = uicontrol('tag','R_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.455 0.05 0.14 0.02],'String','R=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.595 0.73 0.15 0.04],'BackgroundColor','black');
Omin_string = uicontrol('tag','Omin_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.6 0.74 0.14 0.02],'String','Omin=???');

IFOV_string = uicontrol('tag','IFOV_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.85 0.175 0.02],'String','IFOV=???');
Nlines_string = uicontrol('tag','Nlines_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.8 0.175 0.02],'String','Nlines=???');
Npixels_string = uicontrol('tag','Npixels_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.75 0.175 0.02],'String','Npixels=???');
Res_string = uicontrol('tag','Res_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.7 0.175 0.02],'String','Res=???');

uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.57 0.75 0.03 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.45 0.66 0.05 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.455 0.51 0.04 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.522 0.41 0.07 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.17 0.51 0.05 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.6 0.06 0.06 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.75 0.093 0.0025 0.02],'BackgroundColor','black');

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
    jhonsons_criteria=Jhonsons95(3,3);
    h_foot=5000;
    Nlines=800;
    Veq1=10;%in cm
    Veq2=20;
    
end
	
function tancar(hco,eventStruct)

closereq;
close all force;


end

function Payload_calculus(hco,eventStruct)
    %inicialization for jhonson criteria95

    %automatization of the calculus required for UAS selection

    %First part of the system the aircraft which identify
    h=foot2meters(h_foot);
    set(findobj('Tag','h_string'),'String',['H = ' num2str(h) ' m']);
    SLRangle=45;
    set(findobj('Tag','Omax_string'),'String',['Omax = ' num2str(SLRangle) ' deg']);

    
    SLR=h/cos(((2*pi)/360)*SLRangle);
    set(findobj('Tag','SLR_string'),'String',['SLR = ' num2str(SLR) ' m']);


    Veq=[Veq1 Veq2];
    set(findobj('Tag','Veq_string'),'String',['Veq = (' num2str(Veq(1)) ' to ' num2str(Veq(2)) ') cm']);
    Area= Veq/jhonsons_criteria;
    disp(jhonsons_criteria);
    Npixels= sqrt(Area*10^6);


    
    set(findobj('Tag','Nlines_string'),'String',['Nlines = ' num2str(Nlines) ' lines']);
    
    prompt = {['the minimum resolution is: ' num2str(Npixels(1)) ' define a new one:'], 'Introduce the FOV for that resolution'};
    title = 'Catalogue info';
    dims = [1 35];
    definput = {'',''};
    answer = inputdlg(prompt,title,dims,definput);
    
    Npixels=str2double(answer(1));
    FOV=str2double(answer(2));
    set(findobj('Tag','FOV_string'),'String',['FOV = ' num2str(FOV) ' deg']);
    set(findobj('Tag','Omin_string'),'String',['Omin = ' num2str(FOV) ' deg']);
    
    set(findobj('Tag','Npixels_string'),'String',['Npixels = ' num2str(Npixels) ' pixels']);
    IFOV2=deg2mrad(FOV)./Npixels;
    set(findobj('Tag','IFOV_string'),'String',['IFOV = ' num2str(IFOV2) ' urad/pixel']);
    R=IFOV2*SLR/1000;
    set(findobj('Tag','R_string'),'String',['R = ' num2str(R)  ' mm']);
    Res=R*jhonsons_criteria/1000;
    set(findobj('Tag','Res_string'),'String',['Res = ' num2str(Res) ' m']);
    %second part of the system the aircrafts that do SARa

end

function funcio_test1(hco,eventStruct)
% per fer alguna cosa diferent

ButtonName = questdlg('What to do?','Jhonsons criteria','Detect','Recognise','Identify','Identify');
switch ButtonName
    case 'Detect'
        rows=1;
    case 'Recognise'
        rows=2;
    case 'Identify'
        rows=3;
end

ButtonName2 = questdlg('What kind of object?','Jhonsons criteria','Vehicle','Person','Person');
switch ButtonName2
    case 'Vehicle'
        ButtonName3 = questdlg('What kind of object?','Jhonsons criteria','Truck','Tank','Car','Car');
        switch ButtonName3
            case 'Truck'
                cols=1;
            case 'Tank'
                cols=2;
            case 'Car'
                cols=3;
        end
    case 'Person'
        cols=4;
    jhonsons_criteria=Jhonsons95(rows,cols);
    disp(jhonsons_criteria)
end
end
function f2(hco,eventStruct)
    prompt = {'Enter H in ft:','Enter lines of the sensor:','Enter Veq min in cm:','Enter Veq max in cm:'};
    title = 'Params';
    dims = [1 35];
    definput = {num2str(h_foot),num2str(Nlines),num2str(Veq1),num2str(Veq2)};
    answer = inputdlg(prompt,title,dims,definput);

    h_foot=str2double(answer(1));
    Nlines=str2double(answer(2));
    Veq1=str2double(answer(3));
    Veq2=str2double(answer(4));
    
    disp(answer)
end
end