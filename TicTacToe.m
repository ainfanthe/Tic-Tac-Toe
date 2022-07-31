classdef Tictactoe < matlab.apps.AppBase
    properties (Access = public)
        TTT                    matlab.ui.Figure
        dispturn               matlab.ui.control.Label
        newgame                matlab.ui.control.Button
        pushbutton9            matlab.ui.control.Button
        pushbutton8            matlab.ui.control.Button
        pushbutton7            matlab.ui.control.Button
        pushbutton6            matlab.ui.control.Button
        pushbutton5            matlab.ui.control.Button
        pushbutton4            matlab.ui.control.Button
        pushbutton3            matlab.ui.control.Button
        pushbutton2            matlab.ui.control.Button
        pushbutton1            matlab.ui.control.Button
        ModoDropDownLabel      matlab.ui.control.Label
        ModoDropDown           matlab.ui.control.DropDown
        InfoButton             matlab.ui.control.Button
        text5                  matlab.ui.control.Label
        text6                  matlab.ui.control.Label
        XLabel_2               matlab.ui.control.Label
        OLabel_2               matlab.ui.control.Label
        DButtonGroup  matlab.ui.container.ButtonGroup
        Button                 matlab.ui.control.ToggleButton
        Button_2               matlab.ui.control.ToggleButton
    end
methods (Access = private)
        function win = checkboard(app, b)
            win=0;
            for i=1:2
                if b(1)==i && b(2)==i && b(3)==i
                    win=i;
                    set(app.pushbutton1,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton2,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton3,'backgroundcolor','g')
                    pause(0.1)
                elseif b(4)==i && b(5)==i && b(6)==i
                    win=i;
                    set(app.pushbutton4,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton5,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton6,'backgroundcolor','g')
                    pause(0.1)
                elseif b(7)==i && b(8)==i && b(9)==i
                    win=i;
                    set(app.pushbutton7,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton8,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton9,'backgroundcolor','g')
                    pause(0.1)
                elseif b(1)==i && b(4)==i && b(7)==i
                    win=i;
                    set(app.pushbutton1,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton4,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton7,'backgroundcolor','g')
                    pause(0.1)
                elseif b(2)==i && b(5)==i && b(8)==i
                    win=i;
                    set(app.pushbutton2,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton5,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton8,'backgroundcolor','g')
                    pause(0.1)
                elseif b(3)==i && b(6)==i && b(9)==i
                    win=i;
                    set(app.pushbutton3,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton6,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton9,'backgroundcolor','g')
                    pause(0.1)
                elseif b(1)==i && b(5)==i && b(9)==i
                    win=i;
                    set(app.pushbutton1,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton5,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton9,'backgroundcolor','g')
                    pause(0.1)
                elseif b(3)==i && b(5)==i && b(7)==i
                    win=i;
                    set(app.pushbutton3,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton5,'backgroundcolor','g')
                    pause(0.1)
                    set(app.pushbutton7,'backgroundcolor','g')
                    pause(0.1)
                end
            end
        end
        function decision(app, handles)
            avsq=getappdata(gcbf,'avsq');
            board=getappdata(gcbf,'board');
            num=0;
            i=1;
            j=2;
            pause(0.5);
            %cpu, share statement
            status = app.ModoDropDown.Value
            if status=='1'
           while num==0
                if i==1
                	s=[1 2 3];
                elseif i==2
                	s=[4 5 6];
                elseif i==3
                	s=[7 8 9];
                elseif i==4
                	s=[1 4 7];
                elseif i==5
                	s=[2 5 8];
                elseif i==6
                	s=[3 6 9];
                elseif i==7
                	s=[1 5 9];
                elseif i==8
                	s=[3 5 7];
                elseif i==9 && j==2
                    j=1;
                    i=1;
                elseif i==9 && j==1
                    num=avsq(ceil(rand*(length(avsq)))); %choose any sq (square)
                end
            
            	if board(s(1))==j && board(s(2))==j && board(s(3))==0
                    num=s(3);
            	elseif board(s(1))==j && board(s(2))==0 && board(s(3))==j
                    num=s(2);
            	elseif board(s(1))==0 && board(s(2))==j && board(s(3))==j
                    num=s(1);
            	end
                i=i+1;
            end
            picksquare(app, handles,num);
            end
        end
    function picksquare(app, handles, num)
            turn=getappdata(gcbf,'turn');
            avsq=getappdata(gcbf,'avsq');
            avsq(avsq==num)=[];
            setappdata(gcbf,'avsq',avsq);
            board=getappdata(gcbf,'board');
            board(num)=turn;
            if turn==1
                set(eval(['handles.pushbutton' int2str(num)]),'String','X');
                turn=2;
            status = app.ModoDropDown.Value
            if status=='1'
                set(handles.dispturn,'String','Computer');
            else
                set(handles.dispturn,'String','Player O');
            end
            elseif turn==2
                set(eval(['handles.pushbutton' int2str(num)]),'String','O');
                turn=1;
                set(handles.dispturn,'String','Player X');
            end
            setappdata(gcbf,'turn',turn);
            setappdata(gcbf,'board',board);
            [win]=checkboard(app, board);
            
            if win~=0
                for i=1:9
                    set(eval(['handles.pushbutton' int2str(i)]),'Enable','off');
                end
                global sc_x sc_o
                set(handles.newgame,'enable','on');
            status = app.ModoDropDown.Value
            if status=='1'
                set(app.DButtonGroup,'enable','on');
            end
                set(app.ModoDropDown,'enable','on');
            	if win==1
                   set(handles.dispturn,'String','X wins');
                   sc_x=sc_x+1;
                elseif win==2
                    if status=='1'
                   set(handles.dispturn,'String','Computer wins');
                    else 
                   set(handles.dispturn,'String','O wins');
                    end
                   sc_o=sc_o+1;
                end
            set(handles.text5,'string',[num2str(sc_x)]);
            set(handles.text6,'string',[num2str(sc_o)]);
                end
            if win==0
                if isempty(avsq)
                   for i=1:9
                       set(eval(['handles.pushbutton' int2str(i)]),'Enable','off');
                   end
                   set(handles.newgame,'enable','on');
                   set(handles.dispturn,'String','Empate');
                   set(app.DButtonGroup,'enable','on');
                   set(app.ModoDropDown,'enable','on');
                   return
                end
                if turn==2
                    decision(app, handles);
                end
            end
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function tictactoe_OpeningFcn(app, varargin)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app); %#ok<ASGLU>
            % This function has no output args, see OutputFcn.
            % hObject    handle to figure
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            % varargin   command line arguments to tictactoe (see VARARGIN)
            
            % Choose default command line output for tictactoe
            handles.output = hObject;
            set(hObject, 'Name', 'Tic Tac Toe');
            
            % Update handles structure
            guidata(hObject, handles);
            global dcolor sc_x sc_o
            sc_x=0;
            sc_o=0;
            dcolor=get(handles.pushbutton1,'backgroundcolor');
            set(handles.text5,'string',[num2str(sc_x)]);
            set(handles.text6,'string',[num2str(sc_o)]);
        end

        % Button pushed function: newgame
        function newgame_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            global dcolor
            % hObject    handle to newgame (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            set(handles.pushbutton1,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton2,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton3,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton4,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton5,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton6,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton7,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton8,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.pushbutton9,'string',[],'enable','on','backgroundcolor',dcolor);
            set(handles.newgame,'enable','off');
            set(app.DButtonGroup,'enable','off');
            set(app.ModoDropDown,'enable','off');
            for i=1:9
                set(eval(['handles.pushbutton' int2str(i)]),'Enable','on');
                set(eval(['handles.pushbutton' int2str(i)]),'String','');
            end
            status = app.ModoDropDown.Value
            turn=ceil(rand*2);
            if turn==1
                set(handles.dispturn,'String','X begins');
            elseif turn==2
            if status=='1'
                set(handles.dispturn,'String','Computer begins');
            else
                set(handles.dispturn,'String','O begins');
            end
            end
            setappdata(gcbf,'turn',turn);
            board=zeros(1,9);
            setappdata(gcbf,'board',board);
            avsq=[1:9];
            setappdata(gcbf,'avsq',avsq);
            if turn==2
                decision(app, handles);
            end
        end

        % Button pushed function: pushbutton1
        function pushbutton1_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton1 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==1))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,1);
            end
        end

        % Button pushed function: pushbutton2
        function pushbutton2_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton2 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==2))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,2);
            end
        end

        % Button pushed function: pushbutton3
        function pushbutton3_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton3 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==3))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,3);
            end
        end

        % Button pushed function: pushbutton4
        function pushbutton4_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton4 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==4))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,4);
            end
        end

        % Button pushed function: pushbutton5
        function pushbutton5_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton5 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==5))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,5);
            end
        end

        % Button pushed function: pushbutton6
        function pushbutton6_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton6 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==6))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,6);
            end
        end

        % Button pushed function: pushbutton7
        function pushbutton7_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton7 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==7))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,7);
            end
        end

        % Button pushed function: pushbutton8
        function pushbutton8_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton8 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==8))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,8);
            end
        end

        % Button pushed function: pushbutton9
        function pushbutton9_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to pushbutton9 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            avsq=getappdata(gcbf,'avsq');
            if isempty(avsq(avsq==9))
                set(handles.dispturn,'String','Action not allowed');
            else
                picksquare(app, handles,9);
            end
        end

        % Value changed function: ModoDropDown
        function DropDownValueChanged(app, event)
            value = str2double(app.ModoDropDown.Value);
            if value==1
                set(app.DButtonGroup,'enable','on')
            else 
                set(app.DButtonGroup,'enable','off')
            end
        end

        % Button pushed function: InfoButton
        function InfoButtonPushed(app, event)
            helpdlg({'National University of Colombia';'Andrés F. Hernández'; '2021, july 24';''},'Info');
        end

        % Drop down opening function: ModoDropDown
        function ModoDropDownOpening(app, event)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create TTT and hide until all components are created
            app.TTT = uifigure('Visible', 'off');
            app.TTT.Color = [0.9412 0.9412 0.9412];
            app.TTT.Colormap = [0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0];
            app.TTT.Position = [519 400 483 347];
            app.TTT.Name = 'MATLAB Tic-Tac-Toe 1.5';
            app.TTT.Resize = 'off';
            app.TTT.HandleVisibility = 'callback';
            app.TTT.Tag = 'TTT';

            % Create dispturn
            app.dispturn = uilabel(app.TTT);
            app.dispturn.Tag = 'dispturn';
            app.dispturn.BackgroundColor = [1 1 1];
            app.dispturn.HorizontalAlignment = 'center';
            app.dispturn.WordWrap = 'on';
            app.dispturn.FontName = 'Constantia';
            app.dispturn.FontSize = 16;
            app.dispturn.Position = [33 287 251 31];
            app.dispturn.Text = '';

            % Create newgame
            app.newgame = uibutton(app.TTT, 'push');
            app.newgame.ButtonPushedFcn = createCallbackFcn(app, @newgame_Callback, true);
            app.newgame.Tag = 'newgame';
            app.newgame.FontName = 'Constantia';
            app.newgame.FontSize = 14;
            app.newgame.Position = [327 205 138 31];
            app.newgame.Text = {'New game'; ''};

            % Create pushbutton9
            app.pushbutton9 = uibutton(app.TTT, 'push');
            app.pushbutton9.ButtonPushedFcn = createCallbackFcn(app, @pushbutton9_Callback, true);
            app.pushbutton9.Tag = 'pushbutton9';
            app.pushbutton9.FontName = 'Constantia';
            app.pushbutton9.FontSize = 30;
            app.pushbutton9.Enable = 'off';
            app.pushbutton9.Position = [201 46 86 77];
            app.pushbutton9.Text = '';

            % Create pushbutton8
            app.pushbutton8 = uibutton(app.TTT, 'push');
            app.pushbutton8.ButtonPushedFcn = createCallbackFcn(app, @pushbutton8_Callback, true);
            app.pushbutton8.Tag = 'pushbutton8';
            app.pushbutton8.FontName = 'Constantia';
            app.pushbutton8.FontSize = 30;
            app.pushbutton8.Enable = 'off';
            app.pushbutton8.Position = [117 46 86 77];
            app.pushbutton8.Text = '';

            % Create pushbutton7
            app.pushbutton7 = uibutton(app.TTT, 'push');
            app.pushbutton7.ButtonPushedFcn = createCallbackFcn(app, @pushbutton7_Callback, true);
            app.pushbutton7.Tag = 'pushbutton7';
            app.pushbutton7.FontName = 'Constantia';
            app.pushbutton7.FontSize = 30;
            app.pushbutton7.Enable = 'off';
            app.pushbutton7.Position = [33 46 86 77];
            app.pushbutton7.Text = '';

            % Create pushbutton6
            app.pushbutton6 = uibutton(app.TTT, 'push');
            app.pushbutton6.ButtonPushedFcn = createCallbackFcn(app, @pushbutton6_Callback, true);
            app.pushbutton6.Tag = 'pushbutton6';
            app.pushbutton6.FontName = 'Constantia';
            app.pushbutton6.FontSize = 30;
            app.pushbutton6.Enable = 'off';
            app.pushbutton6.Position = [201 121 86 77];
            app.pushbutton6.Text = '';

            % Create pushbutton5
            app.pushbutton5 = uibutton(app.TTT, 'push');
            app.pushbutton5.ButtonPushedFcn = createCallbackFcn(app, @pushbutton5_Callback, true);
            app.pushbutton5.Tag = 'pushbutton5';
            app.pushbutton5.FontName = 'Constantia';
            app.pushbutton5.FontSize = 30;
            app.pushbutton5.Enable = 'off';
            app.pushbutton5.Position = [117 121 86 77];
            app.pushbutton5.Text = '';

            % Create pushbutton4
            app.pushbutton4 = uibutton(app.TTT, 'push');
            app.pushbutton4.ButtonPushedFcn = createCallbackFcn(app, @pushbutton4_Callback, true);
            app.pushbutton4.Tag = 'pushbutton4';
            app.pushbutton4.FontName = 'Constantia';
            app.pushbutton4.FontSize = 30;
            app.pushbutton4.Enable = 'off';
            app.pushbutton4.Position = [33 121 86 77];
            app.pushbutton4.Text = '';

            % Create pushbutton3
            app.pushbutton3 = uibutton(app.TTT, 'push');
            app.pushbutton3.ButtonPushedFcn = createCallbackFcn(app, @pushbutton3_Callback, true);
            app.pushbutton3.Tag = 'pushbutton3';
            app.pushbutton3.FontName = 'Constantia';
            app.pushbutton3.FontSize = 30;
            app.pushbutton3.Enable = 'off';
            app.pushbutton3.Position = [201 196 86 77];
            app.pushbutton3.Text = '';

            % Create pushbutton2
            app.pushbutton2 = uibutton(app.TTT, 'push');
            app.pushbutton2.ButtonPushedFcn = createCallbackFcn(app, @pushbutton2_Callback, true);
            app.pushbutton2.Tag = 'pushbutton2';
            app.pushbutton2.FontName = 'Constantia';
            app.pushbutton2.FontSize = 30;
            app.pushbutton2.Enable = 'off';
            app.pushbutton2.Position = [117 196 86 77];
            app.pushbutton2.Text = '';

            % Create pushbutton1
            app.pushbutton1 = uibutton(app.TTT, 'push');
            app.pushbutton1.ButtonPushedFcn = createCallbackFcn(app, @pushbutton1_Callback, true);
            app.pushbutton1.Tag = 'pushbutton1';
            app.pushbutton1.FontName = 'Constantia';
            app.pushbutton1.FontSize = 30;
            app.pushbutton1.Enable = 'off';
            app.pushbutton1.Position = [33 196 86 77];
            app.pushbutton1.Text = '';

            % Create ModoDropDownLabel
            app.ModoDropDownLabel = uilabel(app.TTT);
            app.ModoDropDownLabel.HorizontalAlignment = 'right';
            app.ModoDropDownLabel.FontName = 'Constantia';
            app.ModoDropDownLabel.FontSize = 14;
            app.ModoDropDownLabel.Position = [327 73 41 22];
            app.ModoDropDownLabel.Text = 'Mode';

            % Create ModoDropDown
            app.ModoDropDown = uidropdown(app.TTT);
            app.ModoDropDown.Items = {'cpu', 'second player'};
            app.ModoDropDown.ItemsData = {'1', '2'};
            app.ModoDropDown.DropDownOpeningFcn = createCallbackFcn(app, @ModoDropDownOpening, true);
            app.ModoDropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.ModoDropDown.FontName = 'Constantia';
            app.ModoDropDown.FontSize = 14;
            app.ModoDropDown.Position = [376 69 86 30];
            app.ModoDropDown.Value = '1';

            % Create InfoButton
            app.InfoButton = uibutton(app.TTT, 'push');
            app.InfoButton.ButtonPushedFcn = createCallbackFcn(app, @InfoButtonPushed, true);
            app.InfoButton.FontName = 'Constantia';
            app.InfoButton.FontSize = 14;
            app.InfoButton.Position = [33 10 88 26];
            app.InfoButton.Text = 'Info';

            % Create text5
            app.text5 = uilabel(app.TTT);
            app.text5.Tag = 'text5';
            app.text5.BackgroundColor = [0.9294 0.6941 0.1255];
            app.text5.HorizontalAlignment = 'center';
            app.text5.WordWrap = 'on';
            app.text5.FontSize = 16;
            app.text5.Position = [377 286 88 27];
            app.text5.Text = 'Static Text';

            % Create text6
            app.text6 = uilabel(app.TTT);
            app.text6.Tag = 'text6';
            app.text6.BackgroundColor = [0.9294 0.6941 0.1255];
            app.text6.HorizontalAlignment = 'center';
            app.text6.WordWrap = 'on';
            app.text6.FontSize = 16;
            app.text6.Position = [377 249 88 26];
            app.text6.Text = 'Static Text';

            % Create XLabel_2
            app.XLabel_2 = uilabel(app.TTT);
            app.XLabel_2.HorizontalAlignment = 'right';
            app.XLabel_2.FontName = 'Constantia';
            app.XLabel_2.FontSize = 16;
            app.XLabel_2.Position = [345 285 25 28];
            app.XLabel_2.Text = 'X:';

            % Create OLabel_2
            app.OLabel_2 = uilabel(app.TTT);
            app.OLabel_2.HorizontalAlignment = 'right';
            app.OLabel_2.FontName = 'Constantia';
            app.OLabel_2.FontSize = 16;
            app.OLabel_2.Position = [346 248 25 28];
            app.OLabel_2.Text = 'O:';

            % Create DificultadButtonGroup
            app.DButtonGroup = uibuttongroup(app.TTT);
            app.DButtonGroup.TitlePosition = 'centertop';
            app.DButtonGroup.Title = 'Level';
            app.DButtonGroup.FontName = 'Constantia';
            app.DButtonGroup.FontSize = 14;
            app.DButtonGroup.Position = [330 111 135 86];

            % Create Button
            app.Button = uitogglebutton(app.DButtonGroup);
            app.Button.Text = '1';
            app.Button.Position = [14 31 100 22];
            app.Button.Value = true;

            % Create Button_2
            app.Button_2 = uitogglebutton(app.DButtonGroup);
            app.Button_2.Text = '2';
            app.Button_2.Position = [14 10 100 22];

            % Show the figure after all components are created
            app.TTT.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Tictactoe(varargin)

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.TTT)

                % Execute the startup function
                runStartupFcn(app, @(app)tictactoe_OpeningFcn(app, varargin{:}))
            else

                % Focus the running singleton app
                figure(runningApp.TTT)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TTT)
        end
    end
end
