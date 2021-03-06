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
		uimenu(hmenu,'Label','&E X I T','Callback',@tancar,'separator','on','Accelerator','E');

    % crear un axis
    haxis =  axes('position', [0.1 0.1 0.85 0.85]);
    set(haxis,'Tag','MDAXIS');
    box on;
    
    % mostrar un plot inicial de les dades
    plot(hores,temperatura,'m.-','Tag','MDVector');
    hold on;
    plot(index,0,'bo','Tag','MDpunt');
    hold off;
    
    % ajustar els axis per veure correctament les hores
    axis([0.5 24.5 0 30]);
    
    % modificar l'eix de visualitzaci� de les hores
    set(haxis,'XTick',[0 3 6 9 12 15 18 21 24]);
    
    % mostrar labels
    xlabel('hora')
    ylabel('temperatura (�C)');
    
    htext = uicontrol('Style','Text','Units','normalized','Position',[0.8 0.15 0.15 0.1],'String','25.1','Tag','MDtext');
    set(htext,'FontSize',20,'FontUnits','normalized','BackgroundColor',[0.9 0.9 0.9],'ForegroundColor',[0 0 0]);
    
    % afegir un breakpoint i provar amb get(htext) i amb inspect(htext)
    a = 1;
    
end

% suposem que tot est� creat
% simulem una nova lectura
index = index +1;
if (index > 24)
    index = 1;
end
lectura = 25 + 3*rand(1,1);

% guardar la lectura en el vector
temperatura(index) = lectura;

% actualitzar vector SENSE REDIBUIXAR
set(findobj('Tag','MDVector'),'YData',temperatura);

% actualitzar punt SENSE REDIBUIXAR
set(findobj('Tag','MDpunt'),'XData',index,'YData',lectura);

% actualitzar text SENSE REDIBUIXAR (ojo �s un string)
haxis = findobj('Tag','MDtext');
set(haxis,'String',num2str(lectura,3));

% si la temperatura �s m�s gran que 26 posar en roig
if (lectura > 26)
    % roig
    set(haxis,'ForegroundColor',[1 0 0]);
else
    % negre
    set(haxis,'ForegroundColor',[0 0 0]);
end

% mostrar el figure en primer pla
figure(hfig);

	
function tancar(hco,eventStruct)
% asegurar que es tanca

% aturar timer
% ...

% tancar
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


