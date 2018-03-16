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

	drawnow;
	refresh;
	
    % afegim un men� b�sic per sortir
	hmenu = uimenu('Label','&Monitor','Tag','M');
		uimenu(hmenu,'Label','Test','Callback',@funcio_test1,'tag','TEST');
		uimenu(hmenu,'Label','&exit','Callback',@tancar,'separator','on','Accelerator','E');







% mostrar el figure en primer pla
figure(hfig);
end
	
function tancar(hco,eventStruct)

closereq;

function funcio_test1(hco,eventStruct)
% per fer alguna cosa diferent

ButtonName = questdlg('Selecciona una opci�...','Atenci� !!!','Continuar','Cancelar','Cancelar');

switch ButtonName
    case 'Continuar'
        disp(['Opci� 1: ' ButtonName])
    otherwise
        disp(['Opci� 2: ' ButtonName])
end