function varargout = MFO_toolbox(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MFO_toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @MFO_toolbox_OutputFcn, ...
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
function MFO_toolbox_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);
function varargout = MFO_toolbox_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
labelStr = '<html><center><a href="">alimirjalili.com';
cbStr = 'web(''http://www.alimirjalili.com'');';
hButton = uicontrol('string',labelStr,'pos',[390,20,100,35],'callback',cbStr);

labelStr = '<html><center><a href="">Find the paper';
cbStr = 'web(''http://dx.doi.org/10.1016/j.knosys.2015.07.006'');';
hButton = uicontrol('string',labelStr,'pos',[500,20,100,35],'callback',cbStr);
function WolfNo_Callback(hObject, eventdata, handles)
function WolfNo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function IterNo_Callback(hObject, eventdata, handles)
function IterNo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function LowerBound_Callback(hObject, eventdata, handles)
function LowerBound_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function UpperBound_Callback(hObject, eventdata, handles)
function UpperBound_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Dim_Callback(hObject, eventdata, handles)
function Dim_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function CostFunction_Callback(hObject, eventdata, handles)
function CostFunction_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit7_Callback(hObject, eventdata, handles)
function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton1_Callback(hObject, eventdata, handles)
SearchAgents_no=str2num(get(handles.WolfNo,'String'));
Max_iteration=str2num(get(handles.IterNo,'String'));
lb=str2num(get(handles.LowerBound,'String'));
ub=str2num(get(handles.UpperBound,'String'));
dim=str2num(get(handles.Dim,'String'));
fobj=str2func(get(handles.CostFunction,'String'));
cla(handles.axes2)
reset(handles.axes2) 
box on
value = get(handles.checkbox1, 'Value');
[Best_score,Best_pos,cg_curve]=MFO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,handles,value);
set(handles.edit9,'String', num2str(Best_pos) );
set(handles.edit10,'String', num2str(Best_score) );
function pushbutton2_Callback(hObject, eventdata, handles)
 close(handles.figure1)
function checkbox1_Callback(hObject, eventdata, handles)
function edit8_Callback(hObject, eventdata, handles)
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton3_Callback(hObject, eventdata, handles)
function edit9_Callback(hObject, eventdata, handles)
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit10_Callback(hObject, eventdata, handles)
function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
