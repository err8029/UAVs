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
		uimenu(hmenu,'Label','Test','Callback',@funcio_test1,'tag','TEST');
		uimenu(hmenu,'Label','&exit','Callback',@tancar,'separator','on','Accelerator','E');
        
% display image
 axes_img = axes('unit', 'normalized', 'position', [0 0 1 1]); 
    tanque_img = imread('raw image.png');
    imagesc(tanque_img);

%start button
play = uicontrol('Style', 'pushbutton', 'String', 'Start calculus','Units','Normalized',...
    'Position', [0.05 0.05 0.2 0.04],...
    'Callback', @Payload_calculus);

%texts
h_string = uicontrol('Parent',hfig,'Style','Text','Units','normalized','Position',[0.15 0.5 0.04 0.04],'String','H=???');


end
	
function tancar(hco,eventStruct)

closereq;
close all force;


end

function Payload_calculus(hco,eventStruct)


end

function funcio_test1(hco,eventStruct)
% per fer alguna cosa diferent

ButtonName = questdlg('Selecciona una opci�...','Atenci� !!!','Continuar','Cancelar','Cancelar');

switch ButtonName
    case 'Continuar'
        disp(['Opci� 1: ' ButtonName])
    otherwise
        disp(['Opci� 2: ' ButtonName])
end
end
end