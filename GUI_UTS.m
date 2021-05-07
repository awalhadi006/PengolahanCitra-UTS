function varargout = GUI_UTS(varargin)
%{
    
    HOW TO CREATE A NEW TAB

    1. Create or copy PANEL and TEXT objects in GUI

    2. Rename tag of PANEL to "tabNPanel" and TEXT for "tabNtext", where N
    - is a sequential number. 
    Example: tab3Panel, tab3text, tab4Panel, tab4text etc.
    
    3. Add to Tab Code - Settings in m-file of GUI a name of the tab to
    TabNames variable

    Version: 1.0
    First created: January 18, 2016
    Last modified: January 18, 2016

    Author: WFAToolbox (http://wfatoolbox.com)

%}

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_UTS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_UTS_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_UTS is made visible.
function GUI_UTS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_UTS (see VARARGIN)

% Choose default command line output for GUI_UTS
handles.output = hObject;

handles.output = hObject;
axes(handles.axes51);
handles.logo = imread('LOGO.jpg');
imshow(handles.logo);
%% Tabs Code
% Settings
TabFontSize = 10;
TabNames = {'Program 1','Program 2','Program 3','Program 4','Program 5','Program 6'};

% Tabs Execution
handles = TabsFun(handles,TabFontSize,TabNames);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_UTS wait for user response (see UIRESUME)
% uiwait(handles.SimpleOptimizedTab);

% --- TabsFun creates axes and text objects for tabs
function handles = TabsFun(handles,TabFontSize,TabNames)

% Set the colors indicating a selected/unselected tab
handles.selectedTabColor=get(handles.tab1Panel,'BackgroundColor');
handles.unselectedTabColor=handles.selectedTabColor-0.1;

% Create Tabs
TabsNumber = length(TabNames);
handles.TabsNumber = TabsNumber;
TabColor = handles.selectedTabColor;
for i = 1:TabsNumber
    n = num2str(i);
    
    % Get text objects position
    set(handles.(['tab',n,'text']),'Units','normalized')
    pos=get(handles.(['tab',n,'text']),'Position');

    % Create axes with callback function
    handles.(['a',n]) = axes('Units','normalized',...
                    'Box','on',...
                    'XTick',[],...
                    'YTick',[],...
                    'Color',TabColor,...
                    'Position',[pos(1) pos(2) pos(3) pos(4)+0.01],...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);
                    
    % Create text with callback function
    handles.(['t',n]) = text('String',TabNames{i},...
                    'Units','normalized',...
                    'Position',[pos(3),pos(2)/2+pos(4)],...
                    'HorizontalAlignment','left',...
                    'VerticalAlignment','middle',...
                    'Margin',0.001,...
                    'FontSize',TabFontSize,...
                    'Backgroundcolor',TabColor,...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);

    TabColor = handles.unselectedTabColor;
end
            
% Manage panels (place them in the correct position and manage visibilities)
set(handles.tab1Panel,'Units','normalized')
pan1pos=get(handles.tab1Panel,'Position');
set(handles.tab1text,'Visible','off')
for i = 2:TabsNumber
    n = num2str(i);
    set(handles.(['tab',n,'Panel']),'Units','normalized')
    set(handles.(['tab',n,'Panel']),'Position',pan1pos)
    set(handles.(['tab',n,'Panel']),'Visible','off')
    set(handles.(['tab',n,'text']),'Visible','off')
end

% --- Callback function for clicking on tab
function ClickOnTab(hObject,~,handles)
m = str2double(get(hObject,'Tag'));

for i = 1:handles.TabsNumber;
    n = num2str(i);
    if i == m
        set(handles.(['a',n]),'Color',handles.selectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.selectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','on')
    else
        set(handles.(['a',n]),'Color',handles.unselectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.unselectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','off')
    end
end

% Following MATLAB function will take a grayscale
% or an RGB image as input and will return a
% binary image as output

% --- Outputs from this function are returned to the command line.
function varargout = GUI_UTS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NamaFile,PathFile] = uigetfile( ...
    {'*.jpeg;*.jpg;*.png','Jenis File (*.jpg,*.jpeg,*.png)';
    '*.*','Semua File (*.*)'},...
    'Buka Foto');
 
if ~isequal(NamaFile,0)
    handles.Foto = imread(fullfile(PathFile,NamaFile));
    guidata(hObject,handles);
    axes(handles.axes2);
    imshow(handles.Foto);
else
    return;
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = [45 20 15 10 5 5];
axes(handles.axes4);
pie(Data);
axes(handles.axes13);
pie3(Data);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NamaFile,PathFile] = uigetfile( ...
    {'*.jpeg;*.jpg;*.png','Jenis File (*.jpg,*.jpeg,*.png)';
    '*.*','Semua File (*.*)'},...
    'Buka Foto');
 
if ~isequal(NamaFile,0)
    handles.Foto = imread(fullfile(PathFile,NamaFile));
    guidata(hObject,handles);
    axes(handles.axes6);
    handles.FotoG = rgb2gray(handles.Foto);
    imshow(handles.FotoG);
    axes(handles.axes7);
    imhist(handles.FotoG);
else
    return;
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NamaFile,PathFile] = uigetfile( ...
    {'*.jpeg;*.jpg;*.png','Jenis File (*.jpg,*.jpeg,*.png)';
    '*.*','Semua File (*.*)'},...
    'Buka Foto');
 
if ~isequal(NamaFile,0)
    handles.Foto = imread(fullfile(PathFile,NamaFile));
    guidata(hObject,handles);
    axes(handles.axes8);
    imshow(handles.Foto);
else
    return;
end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image2 = handles.Foto;
R = image2(:,:,1);
G = image2(:,:,2);
B = image2(:,:,3);

a = zeros(size(image2, 1),size(image2, 2));
redOnly = cat(3, R, a, a);
greenOnly = cat(3, a, G, a);
blueOnly = cat(3, a, a, B);

axes(handles.axes10);
imshow(redOnly);
handles.data3 = redOnly;

axes(handles.axes11);
imshow(greenOnly);
handles.data4 = greenOnly;

axes(handles.axes12);
imshow(blueOnly);
handles.data5 = blueOnly;


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NamaFile,PathFile] = uigetfile( ...
    {'*.jpeg;*.jpg;*.png','Jenis File (*.jpg,*.jpeg,*.png)';
    '*.*','Semua File (*.*)'},...
    'Buka Foto');
 
if ~isequal(NamaFile,0)
    handles.Foto = imread(fullfile(PathFile,NamaFile));
    guidata(hObject,handles);
    axes(handles.axes20);
    imshow(handles.Foto);
else
    return;
end

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FotoG = rgb2gray(handles.Foto);
axes(handles.axes21);
imshow(FotoG);

axes(handles.axes22);
FotoGM = uint8(0.2989*double(handles.Foto(:,:,1)) + 0.5870*double(handles.Foto(:,:,2)) + 0.1141*double(handles.Foto(:,:,3)));
imshow(FotoGM);

[x, y] = size(FotoG);
batas = 127;
FotoBW = zeros(x, y);
    for i=1:x;
     for j=1:y;
        if FotoG(i, j) >= batas
                FotoBW(i, j) = 0;
        else
            FotoBW(i, j)=1;
        end
     end
    end
     
axes(handles.axes23);
imshow(FotoBW);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NamaFile,PathFile] = uigetfile( ...
    {'*.jpeg;*.jpg;*.png','Jenis File (*.jpg,*.jpeg,*.png)';
    '*.*','Semua File (*.*)'},...
    'Buka Foto');
 
if ~isequal(NamaFile,0)
    handles.Foto = imread(fullfile(PathFile,NamaFile));
    guidata(hObject,handles);
    axes(handles.axes24);
    imshow(handles.Foto);
else
    return;
end

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FotoG = rgb2gray(handles.Foto);
axes(handles.axes25);
imshow(FotoG);
 
R = handles.Foto(:,:,1);
G = handles.Foto(:,:,2);
B = handles.Foto(:,:,3);
axes(handles.axes29);
imshow(R);
axes(handles.axes30);
imshow(G);
axes(handles.axes31);
imshow(B);

axes(handles.axes32);
imhist(FotoG);
 
axes(handles.axes33);
imhist(R);
axes(handles.axes34);
imhist(G);
axes(handles.axes35);
imhist(B);
