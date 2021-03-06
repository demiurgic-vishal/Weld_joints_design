function varargout = starting_gui(varargin)
    %STARTING_GUI M-file for starting_gui.fig
    %      STARTING_GUI, by itself, creates a new STARTING_GUI or raises the existing
    %      singleton*.
    %
    %      H = STARTING_GUI returns the handle to a new STARTING_GUI or the handle to
    %      the existing singleton*.
    %
    %      STARTING_GUI('Property','Value',...) creates a new STARTING_GUI using the
    %      given property value pairs. Unrecognized properties are passed via
    %      varargin to starting_gui_OpeningFcn.  This calling syntax produces a
    %      warning when there is an existing singleton*.
    %
    %      STARTING_GUI('CALLBACK') and STARTING_GUI('CALLBACK',hObject,...) call the
    %      local function named CALLBACK in STARTING_GUI.M with the given input
    %      arguments.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help starting_gui

    % Last Modified by GUIDE v2.5 24-Apr-2014 23:26:01

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @starting_gui_OpeningFcn, ...
                       'gui_OutputFcn',  @starting_gui_OutputFcn, ...
                       'gui_LayoutFcn',  [], ...
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
end


% --- Executes just before starting_gui is made visible.
function starting_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   unrecognized PropertyName/PropertyValue pairs from the
    %            command line (see VARARGIN)
    I = imread('filletweldsbending/1.jpg');
    handles.weld=1;
    handles.workpiece = 1;
    handles.electrode = 60;
    handles.loading = 2;
    handles.loading_type = 1;
    handles.kfs = 1.2;
    handles.numb = 1006;
    handles.hr = 1;
    handles.reliability = 50;
    set(handles.type,'string',{'1006','1010','1015','1018','1020','1030','1035','1040','1045','1050','1060','1080','1095'});
    %hObject = 
    imshow(I);
    % Choose default command line output for starting_gui
    handles.output = hObject;
    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes starting_gui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = starting_gui_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end


% --- Executes on selection change in select_weld.
function select_weld_Callback(hObject, eventdata, handles)
    % hObject    handle to select_weld (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


    %        contents{get(hObject,'Value')} returns selected item from select_weld
    %disp('alert');
    contents = cellstr(get(hObject,'String'));  
    I = imread('filletweldsbending/1.jpg');
    n = contents{get(hObject,'Value')};
    handles.weld = str2double(n);
    switch n
        case '1'
            I = imread('filletweldsbending/1.jpg');
        case '2'
            I = imread('filletweldsbending/2.jpg');
        case '3'
            I = imread('filletweldsbending/4.jpg');
        case '4'
            I = imread('filletweldsbending/6.jpg');
        case '5'
            I = imread('filletweldsbending/9.jpg');
        otherwise
            disp('there is some error');
    end
   imshow(I);
   guidata(hObject, handles);
     % Choose default command line output for starting_gui
    %handles.output = hObject;

    % Update handles structure
    %guidata(hObject, handles);
end



% --- Executes during object creation, after setting all properties.
function select_weld_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to select_weld (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
    %save 'myfile.mat' handles;
    r = handles.weld;
    load 'electrode.dat';
    load 'steel.dat';
    load 'cast_iron.dat';
    switch r
        case 1
            if handles.loading_type ==1
                prompt = {'Enter value of d:','Enter value of force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','2000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def)
                if ~(isempty(answer))
                    force = str2double(answer(2));
                    d = str2double(answer(1));
                    l = str2double(answer(3));
                    h = str2double(answer(4));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 0.707*h*d;         % A : Area of Weld Pool
                        Xav = 0;                % Xav : X Coordiante of centroid of Weld Pool            
                        Yav = d/2;              % Yav : Y Coordiante of centroid of Weld Pool
                        Ju = (d^3)/12         % Iu  : Unit Second moment of Interia of Weld Pool
                        Ra=Yav;                 % Point a b c are in the clockwise direction from the origin ( at the maximum distance from centroid
                        Rb=d-Yav; 
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,force,h,material,Area,Xav,Yav,Ju,Ra,Rb,0,0)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                            [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,p,h,material,Area,Xav,Yav,Ju,Ra,Rb,0,0);
                            x(count) = n;
                            y(count) = p;
                            count= count+1;
                        end
                        plot(y,x);
                        xlabel('Force');
                        ylabel('Factor of Safety');
                    else
                        Area = 0.707*h*d;
                        Xav = 0;                            
                        Yav = d/2;              
                        Iu = (d^3)/12;          
                        Ra=Yav;                 
                        Rb=d-Yav;               
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,force,h,material,Area,Xav,Yav,Iu,Ra,Rb,0,0,thetaA,thetaB,0,0)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                            [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,p,h,material,Area,Xav,Yav,Iu,Ra,Rb,0,0,thetaA,thetaB,0,0);
                            x(count) = n;
                            y(count) = p;
                            count= count+1;
                        end
                        plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    end
                end
            else
                prompt = {'Enter value of d:','Enter value of mid-range force','Enter the value of amplitude force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','2000','1000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def)
                if ~(isempty(answer))
                    mforce = str2double(answer(2));
                    aforce = str2double(answer(3));
                    d = str2double(answer(1));
                    l = str2double(answer(4));
                    h = str2double(answer(5));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 0.707*h*d         % A : Area of Weld Pool
                        Xav = 0                % Xav : X Coordiante of centroid of Weld Pool            
                        Yav = d/2              % Yav : Y Coordiante of centroid of Weld Pool
                        Ju = (d^3)/12         % Iu  : Unit Second moment of Interia of Weld Pool
                        Ra=Yav                 % Point a b c are in the clockwise direction from the origin ( at the maximum distance from centroid
                        Rb=d-Yav 
                        [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,0,0)
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,0,0);
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    else
                        Area = 0.707*h*d;
                        Xav = 0;                            
                        Yav = d/2;              
                        Iu = (d^3)/12;          
                        Ra=Yav;                 
                        Rb=d-Yav;               
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,0,0,thetaA,thetaB,0,0 )
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                 [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,0,0,thetaA,thetaB,0,0 );
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    end
                end
            end
        case 2
            if handles.loading_type == 1
                prompt = {'Enter value of d:','Enter value of b:','Enter value of force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','0.1','2000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                if ~(isempty(answer))
                    disp('aaa');
                    force = str2double(answer(3));
                    d = str2double(answer(1));
                    b = str2double(answer(2));
                    l = str2double(answer(4));
                    h = str2double(answer(5));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 1.414*h*d;          % A : Area of Weld Pool
                        Xav = b/2;                % Xav : X Coordiante of centroid of Weld Pool            
                        Yav = d/2;              % Yav : Y Coordiante of centroid of Weld Pool
                        Ju = (d^3)/6;          % Iu  : Unit Second moment of Interia of Weld Pool
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb = Ra;
                        Rc = Ra;
                        Rd = Ra;
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,force,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);                      
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                             [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,p,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd);
                             x(count) = n;
                             y(count) = p;
                             count= count+1;
                         end
                         plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                     else
                        Area=1.414*h*d;
                        Xav=b/2;
                        Yav=d/2;
                        Iu = d*(3*b^2+d^2)/6;
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb = Ra;
                        Rc = Ra;
                        Rd = Ra;
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        thetaC = atand((d-Yav)/(b-Xav));
                        thetaD = atand(Yav/(b-Xav));
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,force,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);                      
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                             [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,p,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD);
                             x(count) = n;
                             y(count) = p;
                             count= count+1;
                         end
                         plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    end
                end
            else
                prompt = {'Enter value of d:','Enter the value of b:','Enter value of mid-range force','Enter the value of amplitude force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','0.1','2000','1000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def)
                if ~(isempty(answer))
                    mforce = str2double(answer(3));
                    aforce = str2double(answer(4));
                    d = str2double(answer(1));
                    b = str2double(answer(2));
                    l = str2double(answer(5));
                    h = str2double(answer(6));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 1.414*h*d;          % A : Area of Weld Pool
                        Xav = b/2;                % Xav : X Coordiante of centroid of Weld Pool            
                        Yav = d/2;              % Yav : Y Coordiante of centroid of Weld Pool
                        Ju = (d^3)/6;          % Iu  : Unit Second moment of Interia of Weld Pool
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb = Ra;
                        Rc = Ra;
                        Rd = Ra;
                        [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd)
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                          for mforce = 500:100:10000
                              for aforce = 500:100:10000
                                 [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,0,0);
                                 x(count) = aforce;
                                 y(count) = mforce;
                                 z(count) = min([Mingood Minyield]);
                                 count= count+1;
                              end
                          end
                          surf(x,y,z);
                          xlabel('Alternating Force');
                          ylabel('Mean force');
                          zlabel('Factor of Safety');
                    else
                       Area=1.414*h*d;
                       Xav=b/2;
                        Yav=d/2;
                        Iu = d*(3*b^2+d^2)/6;
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb = Ra;
                        Rc = Ra;
                        Rd = Ra;
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        thetaC = atand((d-Yav)/(b-Xav));
                        thetaD = atand(Yav/(b-Xav));
                        [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD )
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                 [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD );
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    end
                end
            end
        
        case 3
            if handles.loading_type == 1
                prompt = {'Enter value of d:','Enter value of b:','Enter value of force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','0.1','2000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                if ~(isempty(answer))
                    force = str2double(answer(3));
                    d = str2double(answer(1));
                    b = str2double(answer(2));
                    l = str2double(answer(4));
                    h = str2double(answer(5));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 0.707*h*(2*b+d);
                        Xav = ((b^2)/(2*b+d));
                        Yav = d/2;
                        Iu = ((d^2)/12)*(6*b+d);
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+((d-Yav)^2))^(1/2);
                        Rc=(((b-Xav)^2)+((d-Yav)^2))^(1/2);
                        Rd=(((b-Xav)^2)+Yav^2)^(1/2);
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,force,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                            [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,p,h,material,Area,Xav,Yav,Iu,Ra,Rb,0,0);
                            x(count) = n;
                            y(count) = p;
                            count= count+1;
                        end
                        plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    else
                        Area=0.707*h*(d+2*b);
                        Xav=(b^2)/(2*b + d);
                        Yav=d/2;
                        Ju=(8*b^3+6*b*d^2+d^3)/12 - b^4/(2*b+d);
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+(d-Yav)^2)^(1/2);
                        Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
                        Rd=((b-Xav)^2+Yav^2)^(1/2);
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        thetaC = atand((d-Yav)/(b-Xav));
                        thetaD = atand(Yav/(b-Xav));
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,force,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);                      
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                             [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,p,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD);
                             x(count) = n;
                             y(count) = p;
                             count= count+1;
                         end
                         plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    end
                end
            else
                 prompt = {'Enter value of d:','Enter the value of b:','Enter value of mid-range force','Enter the value of amplitude force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','0.1','2000','1000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def)
                if ~(isempty(answer))
                    mforce = str2double(answer(3));
                    aforce = str2double(answer(4));
                    d = str2double(answer(1));
                    b = str2double(answer(2));
                    l = str2double(answer(5));
                    h = str2double(answer(6));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 0.707*h*(2*b+d);
                        Xav = ((b^2)/(2*b+d));
                        Yav = d/2;
                        Iu = ((d^2)/12)*(6*b+d);
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+((d-Yav)^2))^(1/2);
                        Rc=(((b-Xav)^2)+((d-Yav)^2))^(1/2);
                        Rd=(((b-Xav)^2)+Yav^2)^(1/2);
                        [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd)
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd);
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    else
                        Area=0.707*h*(d+2*b);
                        Xav=(b^2)/(2*b + d);
                        Yav=d/2;
                        Ju=(8*b^3+6*b*d^2+d^3)/12 - b^4/(2*b+d);
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+(d-Yav)^2)^(1/2);
                        Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
                        Rd=((b-Xav)^2+Yav^2)^(1/2);
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        thetaC = atand((d-Yav)/(b-Xav));
                        thetaD = atand(Yav/(b-Xav));
                        [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD );
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD );
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    end
                end
            end
        case 4
            if handles.loading_type == 1
                prompt = {'Enter value of d:','Enter value of b:','Enter value of force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','0.1','2000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                if ~(isempty(answer))
                    force = str2double(answer(3));
                    d = str2double(answer(1));
                    b = str2double(answer(2));
                    l = str2double(answer(4));
                    h = str2double(answer(5));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 1.414*h*(b+d);
                        Xav = b/2;
                        Yav = d/2;
                        Iu = ((d^2)/6)*(3*b+d); 
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+(d-Yav)^2)^(1/2);
                        Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
                        Rd=((b-Xav)^2+Yav^2)^(1/2);
                        disp('afafa');
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,force,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                            [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_bending(electrode,l,p,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd);
                            x(count) = n;
                            y(count) = p;
                            count= count+1;
                        end
                        plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    else
                        Area=1.414*h*(b+d);
                        Xav=b/2;
                        Yav=d/2;
                        Ju=((b+d)^3)/6;
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+(d-Yav)^2)^(1/2);
                        Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
                        Rd=((b-Xav)^2+Yav^2)^(1/2);
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        thetaC = atand((d-Yav)/(b-Xav));
                        thetaD = atand(Yav/(b-Xav));
                        [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,force,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD)
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);                      
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                             [V,M,T1,T2a,T2b,T2c,T2d,J,maxTr,n] = calculate_torsion(electrode,l,p,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD);
                             x(count) = n;
                             y(count) = p;
                             count= count+1;
                         end
                         plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    end
                end
            else
                 prompt = {'Enter value of d:','Enter the value of b:','Enter value of mid-range force','Enter the value of amplitude force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','0.1','2000','1000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def)
                if ~(isempty(answer))
                    mforce = str2double(answer(3));
                    aforce = str2double(answer(4));
                    d = str2double(answer(1));
                    b = str2double(answer(2));
                    l = str2double(answer(5));
                    h = str2double(answer(6));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 1.414*h*(b+d);
                        Xav = b/2;
                        Yav = d/2;
                        Iu = ((d^2)/6)*(3*b+d); 
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+(d-Yav)^2)^(1/2);
                        Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
                        Rd=((b-Xav)^2+Yav^2)^(1/2);
                        [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd)
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                [Mingood, Mingerber, Minyield] = calculate_bending_fatigue(handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Iu,Ra,Rb,Rc,Rd);
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    else
                        Area=1.414*h*(b+d);
                        Xav=b/2;
                        Yav=d/2;
                        Ju=((b+d)^3)/6;
                        Ra=(Xav^2+Yav^2)^(1/2);
                        Rb=(Xav^2+(d-Yav)^2)^(1/2);
                        Rc=((b-Xav)^2+(d-Yav)^2)^(1/2);
                        Rd=((b-Xav)^2+Yav^2)^(1/2);
                        thetaA = 180 - atand(Yav/Xav);
                        thetaB = 180 - atand((d-Yav)/Xav);
                        thetaC = atand((d-Yav)/(b-Xav));
                        thetaD = atand(Yav/(b-Xav));
                        [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD )
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(Mingood) '\n Gerber : ' num2str(Mingerber) '\n Yield : ' num2str(Minyield)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                [Mingood, Mingerber, Minyield] = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD );
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = min([Mingood Minyield]);
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    end
                end
            end
        case 5
            if handles.loading_type == 1
                prompt = {'Enter value of r:','Enter value of force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','2000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                if ~(isempty(answer))
                    force = str2double(answer(2));
                    r = str2double(answer(1));
                    l = str2double(answer(3));
                    h = str2double(answer(4));
                    material = handles.electrode;
                    if handles.loading == 1
                        Area = 1.414*pi*h*r;
                        Iu = pi*(r^3);
                        T1 = force/Area;
                        M = force*l;
                        J = 0.707*h*Iu; 
                        T2 = M*r/J;
                        T =(T1*T1 +T2*T2)^1/2;
                        load 'electrode.dat';
                        electrode1 = electrode';
                        indicesDesMax = find( electrode1(2,:) == material );
                        Min = min([0.4*electrode1(4,indicesDesMax) 0.3*electrode1(3,indicesDesMax)]);
                        n=Min/T
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);                      
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                            T1 = p/Area;
                            M = p*l;
                            T2 = M*r/J;
                            T =(T1*T1 +T2*T2)^1/2;
                            electrode1 = electrode';
                            indicesDesMax = find( electrode1(2,:) == material );
                            Min = min([0.4*electrode1(4,indicesDesMax) 0.3*electrode1(3,indicesDesMax)]);
                            n=Min/T;
                            x(count) = n;
                            y(count) = p;
                            count= count+1;
                         end
                         plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    else
                        Area=1.414*h*pi*r;
                        Ju=2*pi*r^3;
                        T1 = force/Area;
                        M = force*l;
                        J = 0.707*h*Ju; 
                        T2 = M*r/J;
                        T =(T1 +T2);
                        load 'electrode.dat';
                        electrode1 = electrode';
                        indicesDesMax = find( electrode1(2,:) == material );
                        Min = min([0.4*electrode1(4,indicesDesMax) 0.3*electrode1(3,indicesDesMax)]);
                        n=Min/T
                        n=num2str(n);
                        n=['The factor of safety obtained is ' n];
                         waitfor(msgbox(n,'Success'));
                        x=zeros(349);                      
                        y=zeros(349);
                        count=1;
                        for p = 52000:1000:400000
                            T1 = p/Area;
                            M = p*l; 
                            T2 = M*r/J;
                            T =T1 +T2;
                            electrode1 = electrode';
                            indicesDesMax = find( electrode1(2,:) == material );
                            Min = min([0.4*electrode1(4,indicesDesMax) 0.3*electrode1(3,indicesDesMax)]);
                            n=Min/T;
                            x(count) = n;
                            y(count) = p;
                            count= count+1;
                         end
                         plot(y,x);                         xlabel('Force');                         ylabel('Factor of Safety');
                    end
                end
            else
               prompt = {'Enter value of r:','Enter the value of Mean force','Enter value of Alernating force','Enter the X coordinate','Enter the value of h:'};
                dlg_title = 'Input';
                num_lines = 1;
                def = {'0.05','2000','1000','0.5','0.005'};
                answer = inputdlg(prompt,dlg_title,num_lines,def);
                if ~(isempty(answer))
                    mforce = str2double(answer(2));
                    aforce = str2double(answer(3));
                    r = str2double(answer(1));
                    l = str2double(answer(4));
                    h = str2double(answer(5));
                    Area = 1.414*pi*h*r;
                    material = handles.electrode;
                    indicesDesMax = find( steel(:,3) == handles.numb );
                        if steel(indicesDesMax(1),4)== handles.hr
                            indice = indicesDesMax(1);
                        else
                            indice = indicesDesMax(2);
                        end
                        Sut = steel(indice,5);
                        Sy = steel(indice,6)*1e6;
                        Se = 0.5*Sut*1e6;   % in MPa
                        if ( handles.hr == 1)
                            a = 57.7;
                            b = -0.718;
                        else
                            a = 4.51;
                            b = -0.265;
                        end
                        Ka = a*((Sut)^b);
                        de = 0.808*(Area)^(1/2);
                        Kb =1;
                        if ((de<=0.051) || (de>=0.00279))
                            Kb = 1.24*((de*1000)^(-0.107));
                        elseif ((de>=0.051) || (de<=0.254))
                            Kb = 1.51*((de*1000)^(-0.157));
                        end
                        if handles.loading == 1
                            Kc = 1;
                        else
                            Kc = 0.59;
                        end
                        Kd =1;
                        if (handles.reliability == 50)
                            Ke=1;
                        elseif (handles.reliability == 90) 
                            Ke=0.897;
                        elseif (handles.reliability == 95)
                            Ke=0.868;
                        elseif (handles.reliability == 99)
                            Ke=0.814; 
                        elseif (handles.reliability == 99.9)
                            Ke=0.753;
                        elseif (handles.reliability == 99.99)
                            Ke=0.702; 
                        elseif (handles.reliability == 99.999)
                            Ke=0.659; 
                        else (handles.reliability == 99.9999)
                            Ke=0.620;
                        end
                        Kf =1;
                        Kfs = handles.kfs; 
                        Se = Ka*Kb*Kc*Kd*Ke*Kf*Se'; 
                        Ssu=0.67*Sut*1e6;
                    if handles.loading == 1
                        Iu = pi*(r^3);
                        J = 0.707*h*Iu; 
                        T1a = Kfs*(aforce)/(Area);             % Use table 9.5
                        T1m = Kfs*(mforce)/(Area);
                        Ma = aforce*l;
                        Mm = mforce*l;
                        T2m = Kfs*Mm*r/J;
                        T2a = Kfs*Ma*r/J;
                        Ta = (T1a^2 + T2a^2)^1/2;
                        Tm = (T2m^2 + T1m^2)^1/2;
                        nfa = 1/((Ta/Se)+(Tm/Ssu));
                        Sut = steel(indice,5)*1e6;
                        Sy = steel(indice,6)*1e6;
                        ny = Sy/(Ta+Tm);
                        ngerbera = (0.5)*((Sut/Tm)^2)*(Ta/Se)*(-1 + (1+(2*Tm*Se/(Sut*Ta))^2)^0.5);
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(nfa) '\n Gerber : ' num2str(ngerbera) '\n Yield : ' num2str(ny)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                T1a = Kfs*(aforce)/(Area);             % Use table 9.5
                                T1m = Kfs*(mforce)/(Area);
                                Ma = aforce*l;
                                Mm = mforce*l;
                                T2m = Kfs*Mm*r/J;
                                T2a = Kfs*Ma*r/J;
                                Ta = (T1a^2 + T2a^2)^1/2;
                                Tm = (T2m^2 + T1m^2)^1/2;
                                nfa = 1/((Ta/Se)+(Tm/Ssu));
                                %n = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD );
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = nfa;
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    else
                        Ju=2*pi*r^3;
                        J = 0.707*h*Ju;
                        T1a = Kfs*(aforce)/(Area);             % Use table 9.5
                        T1m = Kfs*(mforce)/(Area);
                        Ma = aforce*l;
                        Mm = mforce*l;
                        T2m = Kfs*Mm*r/J;
                        T2a = Kfs*Ma*r/J;
                        Ta = (T1a + T2a);
                        Tm = (T2m + T1m);
                        nfa = 1/((Ta/Se)+(Tm/Ssu));
                        Sut = steel(indice,5)*1e6;
                        Sy = steel(indice,6)*1e6;
                        ny = Sy/(Ta+Tm);
                        ngerbera = (0.5)*((Sut/Tm)^2)*(Ta/Se)*(-1 + (1+(2*Tm*Se/(Sut*Ta))^2)^0.5);
                        n=sprintf(['The factor of safety obtained are\n Goodman : ' num2str(nfa) '\n Gerber : ' num2str(ngerbera) '\n Yield : ' num2str(ny)]);
                         waitfor(msgbox(n,'Success'));
                        x=zeros(96);
                        y=zeros(96);
                        z=zeros(96);
                         count=1;
                         for mforce = 500:100:10000
                             for aforce = 500:100:10000
                                T1a = Kfs*(aforce)/(Area);             % Use table 9.5
                                T1m = Kfs*(mforce)/(Area);
                                Ma = aforce*l;
                                Mm = mforce*l;
                                T2m = Kfs*Mm*r/J;
                                T2a = Kfs*Ma*r/J;
                                Ta = (T1a + T2a);
                                Tm = (T2m + T1m);
                                nfa = 1/((Ta/Se)+(Tm/Ssu));
                                %n = calculate_torsion_fatigue( handles,electrode,steel,l,mforce,aforce,h,material,Area,Xav,Yav,Ju,Ra,Rb,Rc,Rd,thetaA,thetaB,thetaC,thetaD );
                                x(count) = aforce;
                                y(count) = mforce;
                                z(count) = nfa;
                                count= count+1;
                             end
                         end
                         surf(x,y,z);
                         xlabel('Alternating Force');
                         ylabel('Mean force');
                         zlabel('Factor of Safety');
                    end
                end 
            end
        otherwise
            disp('there is some error');
    end
    
    guidata(hObject, handles);% hObject    handle to select (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
    contents = cellstr(get(hObject,'String')); %returns popupmenu1 contents as cell array
    workpiece = contents{get(hObject,'Value')}; %returns selected item from popupmenu1
    switch workpiece
        case 'Steel'
            handles.workpiece = 1;
            set(handles.type,'string',{'1006','1010','1015','1018','1020','1030','1035','1040','1045','1050','1060','1080','1095'});
            set(handles.type,'Value',1);
            handles.numb = 1006;
        case 'Cast Iron'
            handles.workpiece = 2;
            set(handles.type,'string',{'20','25','30','35','40','50','60'});
            set(handles.type,'Value',1);
            handles.numb = 20;
        otherwise
            disp('there is some error');
    end
    guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to popupmenu1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
    % hObject    handle to popupmenu2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

     contents = cellstr(get(hObject,'String')); %returns popupmenu2 contents as cell array
      temp_electrode = contents{get(hObject,'Value')}; %returns selected item from popupmenu2
      if temp_electrode(4) == 'X'
        handles.electrode = str2num(temp_electrode(2:3));
      else
          handles.electrode = str2num(temp_electrode(2:4));
      end
      guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to popupmenu2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in type.
function type_Callback(hObject, eventdata, handles)
    % hObject    handle to type (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: 
    contents = cellstr(get(hObject,'String')); %returns type contents as cell array
    handles.numb = str2double(contents{get(hObject,'Value')}); 
    %returns selected item from type
    guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function type_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to type (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: 
contents = cellstr(get(hObject,'String')); %returns popupmenu4 contents as cell array
load = contents{get(hObject,'Value')}; %returns selected item from popupmenu4
    switch load
        case 'Bending'
            handles.loading = 1;
        case 'Torsion'
            handles.loading = 2;
        otherwise 
            disp('there is some error');
    end
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to popupmenu4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in loadingtype.
function loadingtype_Callback(hObject, eventdata, handles)
% hObject    handle to loadingtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns loadingtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from loadingtype


contents = cellstr(get(hObject,'String')); %returns popupmenu4 contents as cell array
load = contents{get(hObject,'Value')}; %returns selected item from popupmenu4
    switch load
        case 'Static'
            handles.loading_type = 1;
            disp('aaa');
        case 'Dynamic'
            handles.loading_type = 2;
            disp('aaaa');
        otherwise 
            disp('there is some error');
    end
    guidata(hObject, handles);
end
% --- Executes during object creation, after setting all properties.
function loadingtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadingtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on selection change in weldtype.
function weldtype_Callback(hObject, eventdata, handles)
% hObject    handle to weldtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns weldtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from weldtype

contents = cellstr(get(hObject,'String')); %returns popupmenu4 contents as cell array
load = contents{get(hObject,'Value')}; %returns selected item from popupmenu4
    switch load
        case 'Reinforced butt weld'
            handles.kfs = 1.2;
            disp('aaa');
        case 'Toe of transverse fillet weld'
            handles.kfs = 1.5;
            disp('aaaa');
        case 'End of parallel fillet weld'
            handles.kfs = 2.7;
        case 'T-butt joint with sharp corners'
            handles.kfs = 2;
        otherwise  
            disp('there is some error');
    end
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function weldtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to weldtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in hr_cd.
function hr_cd_Callback(hObject, eventdata, handles)
% hObject    handle to hr_cd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        contents = cellstr(get(hObject,'String')); %returns popupmenu4 contents as cell array
        load = contents{get(hObject,'Value')}; %returns selected item from popupmenu4
    switch load
        case 'HR'
            handles.hr = 1;
        case 'CD'
            handles.hr = 2;
        otherwise  
            disp('there is some error');
    end
    guidata(hObject, handles);

end


% --- Executes during object creation, after setting all properties.
function hr_cd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hr_cd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in rel.
function rel_Callback(hObject, eventdata, handles)
% hObject    handle to rel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 contents = cellstr(get(hObject,'String')); %returns type contents as cell array
    handles.reliability = str2double(contents{get(hObject,'Value')}); 
    %returns selected item from type
    guidata(hObject, handles);


end
% --- Executes during object creation, after setting all properties.
function rel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
