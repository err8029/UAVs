function mostrar_dades




% EVITAR cridar dos cops
hfig = findobj('tag','MOSTRARDADES');
if (isempty(hfig))

	% crer el figure
	hfig = figure;
	set(hfig,'numbertitle','off');               % treu el numero de figura
	set(hfig,'name',['UAVs EO fast prototyping']);
	set(hfig,'MenuBar','none');                  % treiem els menus i els icons
	set(hfig,'doublebuffer','on');               % dos buffers de grafics
	set(hfig,'CloseRequestFcn',@tancar)          % funci� que es cridar� al tancar la finestra
	set(hfig,'tag','MOSTRARDADES');              % identifiquem la figura
    set(hfig,'Units','Normalized','Position',[0.1,0.1,0.75,0.75]);

	drawnow;
	refresh;
	
    % afegim un men� b�sic per sortir
	hmenu = uimenu('Label','&Input data','Tag','M');
		uimenu(hmenu,'Label','Define jhonsons criteria','Callback',@funcio_test1,'tag','TEST');
		uimenu(hmenu,'Label','Define params','Callback',@f2,'tag','test2');        
		uimenu(hmenu,'Label','&exit','Callback',@tancar,'separator','on','Accelerator','E');
    hmenu = uimenu('Label','&Comms for EO','Tag','M');
		uimenu(hmenu,'Label','Calculate','Callback',@commsGUI,'tag','comms');
        
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

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.72 0.22 0.15 0.04],'BackgroundColor','black');
R_string = uicontrol('tag','R_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.725 0.23 0.14 0.02],'String','R=???');

    uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.595 0.73 0.15 0.04],'BackgroundColor','black');
Omin_string = uicontrol('tag','Omin_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.6 0.74 0.14 0.02],'String','Omin=???');

IFOV_string = uicontrol('tag','IFOV_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.85 0.175 0.02],'String','IFOV=???');
Nlines_string = uicontrol('tag','Nlines_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.8 0.175 0.02],'String','Res (min) =???');
Npixels_string = uicontrol('tag','Npixels_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.75 0.175 0.02],'String','Npixels=???');
Res_string = uicontrol('tag','Res_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.8 0.7 0.175 0.02],'String','Res=???');

uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.57 0.75 0.03 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.45 0.66 0.05 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.455 0.51 0.04 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.522 0.41 0.07 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.17 0.51 0.05 0.005],'BackgroundColor','black');
uicontrol('tag','h_string','Parent',hfig,'Style','Text','Units','normalized','Position',[0.66 0.24 0.06 0.005],'BackgroundColor','black');
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
    jhonsons_criteria=Jhonsons95(3,4);
    h_foot=5000;
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
    theoretical_res= Veq/jhonsons_criteria;
    disp(jhonsons_criteria);
    Npixels= sqrt(theoretical_res*10^6);


    
    set(findobj('Tag','Nlines_string'),'String',['Res (min) = ' num2str(theoretical_res(1)) ' and ' num2str(theoretical_res(2))  ' Mpx']);
    
    prompt = {[...
    'Minimum requirements: ' ...
    '-------------------------------------------------------' ... 
    'Min resolution for Veq min: ' num2str(Npixels(1)) ' px                 ' ... 
    'Min resolution for Veq max: ' num2str(Npixels(2)) ' px                 ' ... 
    '-------------------------------------------------------' ...                                     ' ...
    'Resolution of the selected camera ( > Min req ):'], ...
    'FOV of the selected camera:'};...
    
    title = 'Select a commercial camera';
    dims = [1 55];
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
    if Res*100>Veq2
        set(findobj('Tag','Res_string'),'String',['Res = ' num2str(Res) ' m'],'ForegroundColor','red');
    else
        set(findobj('Tag','Res_string'),'String',['Res = ' num2str(Res) ' m']);
    end
    
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
    prompt = {'Enter H in ft:','Enter Veq min in cm:','Enter Veq max in cm:'};
    title = 'Params';
    dims = [1 35];
    definput = {num2str(h_foot),num2str(Veq1),num2str(Veq2)};
    answer = inputdlg(prompt,title,dims,definput);

    h_foot=str2double(answer(1));
    Veq1=str2double(answer(2));
    Veq2=str2double(answer(3));
end
function commsGUI(hco,eventStruct)
   	% crer el figure
	hfig = figure;
	set(hfig,'numbertitle','off');               % treu el numero de figura
	set(hfig,'name',['UAVs EO fast prototyping']);
	set(hfig,'MenuBar','none');                  % treiem els menus i els icons
	set(hfig,'doublebuffer','on');               % dos buffers de grafics
	set(hfig,'CloseRequestFcn',@tancar2)          % funci� que es cridar� al tancar la finestra
	set(hfig,'tag','MOSTRARDADES');              % identifiquem la figura
    set(hfig,'Units','Normalized','Position',[0.3,0.3,0.4,0.4]);
    
    drawnow;
	refresh;
    
    compresion_rate=4;
    res_400=640*400;
    res_480=640*480;
    res_720=1280*720;
    res_1080=1920*1080;

    uicontrol('style','text','units','normalized','BackgroundColor',[0.2 0.5 0.7],...
                'position',[0.05,0.85,0.42,0.1],'string','EO video params');
    uicontrol('style','text','units','normalized','BackgroundColor',[0.7 0.7 0.7],...
                'position',[0.05,0.25,0.42,0.55]);
    
    uicontrol('style','text','units','normalized','BackgroundColor',[0.5 0.5 0.5],...
                'position',[0.05,0.8,0.42,0.05],'string','Video resolution selection'); 
    res400c = uicontrol('tag','res400c','style','checkbox','units','normalized',...
                'position',[0.1,0.7,0.3,0.05],'string','resolution 400x640','BackgroundColor',[0.7 0.7 0.7]); 
    res640c = uicontrol('tag','res640c','style','checkbox','units','normalized',...
                'position',[0.1,0.65,0.3,0.05],'string','resolution 640x480','BackgroundColor',[0.7 0.7 0.7]); 
    res720c = uicontrol('tag','res720c','style','checkbox','units','normalized',...
                'position',[0.1,0.6,0.3,0.05],'string','resolution 1280x720','BackgroundColor',[0.7 0.7 0.7]);
    res1080c = uicontrol('tag','res1080c','style','checkbox','units','normalized',...
                'position',[0.1,0.55,0.3,0.05],'string','resolution 1920x1080','BackgroundColor',[0.7 0.7 0.7]);
    
    uicontrol('style','text','units','normalized','BackgroundColor',[0.5 0.5 0.5],...
                'position',[0.05,0.45,0.42,0.05],'string','  Video frequency (Hz)','HorizontalAlignment','left');
    freq_in = uicontrol('tag','freq_in','style','edit','units','normalized',...
                'position',[0.25,0.45,0.2,0.05]); 
    
    uicontrol('style','text','units','normalized','BackgroundColor',[0.5 0.5 0.5],...
                'position',[0.05,0.35,0.42,0.05],'string','  Grey levels (num)','HorizontalAlignment','left');
    grey_lvls = uicontrol('tag','grey_lvls','style','edit','units','normalized',...
                'position',[0.25,0.35,0.2,0.05]); 
    uicontrol('tag','Bwithvid','style','text','units','normalized','BackgroundColor',[0.2 0.5 0.7],...
                'position',[0.05,0.25,0.42,0.05],'string','Bandwith needed: ?????','HorizontalAlignment','center');    
            
            
    uicontrol('style','text','units','normalized','BackgroundColor',[0.2 0.5 0.7],...
                'position',[0.52,0.85,0.42,0.1],'string','EO picture params');
    uicontrol('style','text','units','normalized','BackgroundColor',[0.7 0.7 0.7],...
                'position',[0.52,0.25,0.42,0.6]);
            
    uicontrol('style','text','units','normalized','BackgroundColor',[0.5 0.5 0.5],...
                'position',[0.52,0.45,0.42,0.05],'string','  Res picture (Mpx)','HorizontalAlignment','left');
    respic = uicontrol('tag','respic','style','edit','units','normalized',...
                'position',[0.72,0.45,0.2,0.05]); 
            
    uicontrol('style','text','units','normalized','BackgroundColor',[0.5 0.5 0.5],...
                'position',[0.52,0.35,0.42,0.05],'string','  Bits per pixel (num)','HorizontalAlignment','left');
    bitspx = uicontrol('tag','bitspx','style','edit','units','normalized',...
                'position',[0.72,0.35,0.2,0.05]);
    uicontrol('tag','Bwithpic','style','text','units','normalized','BackgroundColor',[0.2 0.5 0.7],...
                'position',[0.52,0.25,0.42,0.05],'string','Bandwith needed: ?????','HorizontalAlignment','center'); 
            
    play = uicontrol('Style', 'pushbutton', 'String', 'Calculate comms','Units','Normalized',...
    'Position', [0.4 0.1 0.175 0.04],...
    'Callback', @obtain);

    function obtain(hco,eventStruct)
    value1 = get(findobj('Tag','res1080c'), 'Value');
    value2 = get(findobj('Tag','res720c'), 'Value');
    value3 = get(findobj('Tag','res640c'), 'Value');
    value4 = get(findobj('Tag','res400c'), 'Value');
    
    if (value1 == true)
        resolution_EO=res_1080/10^6;%Mpx
    elseif (value2 == true)
        resolution_EO=res_720/10^6;
    elseif (value3 == true)
        resolution_EO=res_480/10^6;
    elseif (value4 == true)
        resolution_EO=res_400/10^6;
    end
    
    Freq=str2double(get(findobj('Tag','freq_in'), 'string')); %in Hz
    Grey_lvls=str2double(get(findobj('Tag','grey_lvls'), 'string'));

    consumption_vid_EO=(resolution_EO*Freq*Grey_lvls)/compresion_rate;
    set(findobj('Tag','Bwithvid'),'String',['Required bandwith: ' num2str(consumption_vid_EO) ' Mbps']);

    %EO photo capabilities

    res= str2double(get(findobj('Tag','respic'), 'string'))%MBites
    bits_per_px=str2double(get(findobj('Tag','bitspx'), 'string'))

    consumption_pic_EO=(res*bits_per_px)/compresion_rate;
    set(findobj('Tag','Bwithpic'),'String',['Required bandwith: ' num2str(consumption_pic_EO) ' Mbps']);
    end	
function tancar2(hco,eventStruct)

closereq;


end
end
end