function mostrar_dades




% EVITAR cridar dos cops
hfig = findobj('tag','MOSTRARDADES');
if (isempty(hfig))

	% crer el figure
	hfig = figure;
	set(hfig,'numbertitle','off');               % treu el numero de figura
	set(hfig,'name',['UAVs EO comms fast prototyping']);
	set(hfig,'MenuBar','none');                  % treiem els menus i els icons
	set(hfig,'doublebuffer','on');               % dos buffers de grafics
	set(hfig,'CloseRequestFcn',@tancar)          % funci� que es cridar� al tancar la finestra
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
    'Callback', @calc);
           
    

    


	

        
    
end
function calc(hco,eventStruct)
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
function tancar(hco,eventStruct)

closereq;
close all force;


end
end