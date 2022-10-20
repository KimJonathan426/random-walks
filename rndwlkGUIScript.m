function rndwlkGUIScript
%
% GUI-based MATLAB Program simulating random walks in
%   2D and 3D given certain inputs w/ the addition of
%   a normalized histogram of particle displacement from
%   the origin containing the solution of the
%   diffusion equation for comparison.
%

% Figure pop-up configurations
fig = figure('numbertitle','off','name','Random Walks',...
             'menubar','none','resize','on',...
             'color',[1 1 1],'position',[100 100 800 850]);

% Parameters for random walks
uicontrol('style','text','string','Time Vector (T1:Tinterval:T2): ','position',[-125 95 276 25],...
          'backgroundcolor',[1 1 1],'horizontalalignment','right');

uicontrol('style','text','string','Particle(s): ','position',[-211 60 276 25],...
          'backgroundcolor',[1 1 1],'horizontalalignment','right');

uicontrol('style','text','string','Diffusion Coefficient: ','position',[-165 25 276 25],...
          'backgroundcolor',[1 1 1],'horizontalalignment','right');

uicontrol('style','edit','string','[0:0:0]','position',[187 100 100 25],...
          'tag','opboxTV','backgroundcolor',[0.75 1 0.75],...
          'horizontalalignment','right');

uicontrol('style','edit','string','0','position',[187 65 100 25],...
          'tag','opboxPT','backgroundcolor',[0.75 1 0.75],...
          'horizontalalignment','right');

uicontrol('style','edit','string','0','position',[187 30 100 25],...
          'tag','opboxDC','backgroundcolor',[0.75 1 0.75],...
          'horizontalalignment','right');

% 2-D, 3-D option and RUN button
uicontrol('style','text','string','Default 2-D',...
          'position',[339 95 75 25],...
          'backgroundcolor',[1 1 1]);
uicontrol('style','text','string','Change to 3-D? ',...
          'position',[335 60 85 25],...
          'backgroundcolor',[1 1 1]);
uicontrol('style','pushbutton','string','RUN',...
          'position',[580.5 21.5 200 100],'tag','opboxRUN',...
          'backgroundcolor',[0.5 1 0.2],'fontsize',30);

% option for 3-D "hold"
uicontrol('style','checkbox','string','      Yes!','tag','hold3D',...'
          'position', [340 40 75 25]);

% Seperation for asthetics
uicontrol('style','text','string','_______________________________________________________________________',...
          'position',[-1 125 810 40],'fontsize',15,...
          'backgroundcolor',[1 1 1]);

% Plot foundation
axes('units','pixels','Position',[225 450 350 350],'tag','axes1');
axes('units','pixels','Position',[ 75 200 160 160],'tag','axes2');
axes('units','pixels','Position',[325 200 160 160],'tag','axes3');
axes('units','pixels','Position',[580 200 160 160],'tag','axes4');

% Boiler Plate: Single Callback
handles = guihandles(fig);
guidata(fig,handles);
hca = struct2cell(handles);
for k = 1:length(hca)
    obj = hca{k};
    if isfield(obj,'callback') | isprop(obj,'callback')
        set(obj,'callback',{@main_cb,handles});
    end % end of if isfield...
end % end of for k

% main callback function for 'opboxRUN' case
function main_cb(uiobject, eventdata, handles)
    tag = get(uiobject, 'tag');
    timeunits = 's'; spaceunits = 'cm'; concentrationunits = 'g/cm^3';
    
    switch tag
        case 'opboxRUN'
            tv    = eval(get(handles.opboxTV, 'String'));
            npp   = eval(get(handles.opboxPT, 'String'));
            D     = eval(get(handles.opboxDC, 'String'));
            
            rmax = 3*sqrt(2*D*tv(end));
            ntp = 3;                    % number of times at which to do histo
            
            if get(handles.hold3D, 'value')
                axes(eval(['handles.axes' num2str(1)]));
                for np = 1:npp
                    [t,X] = rndwlk3D(D,tv,np);
                    for p = 1:np
                        plot3(X(:,1,p),X(:,2,p),X(:,3,p));
                        hold on
                    end % end of for p
                    hold off
                    xlabel(['x (' spaceunits ')']);
                    ylabel(['y (' spaceunits ')']);
                    zlabel(['z (' spaceunits ')']);
                    title(['3D Random Walks of ' num2str(npp) ' particle(s)']);
                    axis(repmat([-rmax rmax],1,3), 'equal');
                end % end of for np
                
                for hi = 1:ntp
                    axes(eval(['handles.axes' num2str(hi+1)]));
                    r   = squeeze(sqrt(sum(X.^2,2)));         % radial positions of walkers, for all times
                    ktp = round(linspace(1,length(t),ntp+1)); % indices of times at which to do hist
                    ktp = ktp(2:end);                         % remove the start time from those
                    
                    for k = hi
                        tk = t(ktp(hi));         % time corresponding to time index
                        rk = r(ktp(hi)-1,:);     % radial positions at that time
                        [cnt,bc] = hist(rk,21);  % counts and bin-centers of histogram
                        bar(bc,cnt/np); hold on  % plot histogram, normalized by num of particles
                        rd = linspace(0,3*sqrt(2*D*tk),51);
                        c  = 4*pi*(rd.^2) .* 1/sqrt(4*pi*D*tk).^3 .* exp(-rd.^2/(4*D*tk)); % 3D diffusion equation
                        scc = 20;                % fudge factor for scaling
                        plot(rd,c/scc,'b'); hold off
                        xlabel(['Radial Position (' spaceunits ')']);
                        ylabel(['Concentration (' concentrationunits ')']);
                        title({'Normalized Groups of Distance', ['from Origin at ' num2str(tk) '(' timeunits ')']});
                    end % end of for k
                end % end of for hi
                
            else
                axes(eval(['handles.axes' num2str(1)]));
                for np = 1:npp
                    [t,X] = rndwlk2D(D,tv,np);
                    for p = 1:np
                        plot(X(:,1,p),X(:,2,p));
                        hold on
                    end % end of for p
                    hold off
                    xlabel(['x (' spaceunits ')']);
                    ylabel(['y (' spaceunits ')']);
                    title(['2D Random Walks of ' num2str(npp) ' particle(s)']);
                    axis(repmat([-rmax rmax],1,2), 'equal');
                end % end of for np
                    
                for montas = 1:ntp
                    axes(eval(['handles.axes' num2str(montas+1)]));
                    r   = squeeze(sqrt(sum(X.^2,2)));         % radial positions of walkers, for all times
                    ktp = round(linspace(1,length(t),ntp+1)); % indices of times at which to do hist
                    ktp = ktp(2:end);                         % remove the start time from those
                    
                    for k = montas
                        tk = t(ktp(montas));     % time corresponding to time index
                        rk = r(ktp(montas)-1,:); % radial positions at that time
                        [cnt,bc] = hist(rk,21);  % counts and bin-centers of histogram
                        bar(bc,cnt/np); hold on  % plot histogram, normalized by num of particles
                        rd = linspace(0,3*sqrt(2*D*tk),51);
                        c  = 2*pi*rd .* 1/(4*pi*D*tk) .* exp(-rd.^2/(4*D*tk)); % 2D diffusion equation
                        scc = 20;                % fudge factor for scaling
                        plot(rd,c/scc,'b'); hold off
                        xlabel(['Radial Position (' spaceunits ')']);
                        ylabel(['Concentration (' concentrationunits ')']);
                        title({'Normalized Groups of Distance', ['from Origin at ' num2str(tk) '(' timeunits ')']});
                    end % end of for k
                end % end of for montas
            end % end of if 3d, else 2d
    end % end of switch