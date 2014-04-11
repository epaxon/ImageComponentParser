% A quick overview of ICP and the data

% Run this for paths
% addpath('ecc');
% addpath('FastICA_25');
% cd('GUILayout-v1p13');
% install();
% cd('..');

%% Data files

files{1} = 'component_data/ic200-x120121-n131011.mat';
files{2} = 'component_data/ic200-x120124-n131011.mat';
files{3} = 'component_data/ic200-x120207-n131011.mat';
files{4} = 'component_data/ic200-x120228-n131011.mat';
files{5} = 'component_data/ic200-x120305-n131011.mat';
files{6} = 'component_data/ic200-x120509-n131011.mat';
files{7} = 'component_data/ic200-x120510-n131011.mat';
files{8} = 'component_data/ic200-x120516-n131011.mat';

%% Load a data

load(files{1}); % produces vsx;

% vsx is a 1x5 struct array with fields:
% 
%     exp: the experiment date
%     trial_id: the trial id
%     ccd: motion-corrected raw ccd data [M x N x T] matrix
%     ft: frame timestamps
%     daq: extracellular daq recordings (this show whether it swims or
%          shortens)
%     dt: daq timestamps
%     rois: hand-drawn rois
%     ic_rois: Rois produced from ICA analysis
%     ics: Components produced from ICA analysis
%     is_swim: whether trial has swimming
%     is_short: whether trial has shortening (some trials can have both).

%% ImageComponentParser
% So the ICP isn't quite complete, so not everything works... but its
% pretty close.

% Open an icp
icp = ImageComponentParser();

% Just set the raw data
icp.set_data(vsx(1).ccd);

%   So the idea is that the analysis is broken into stages: Pre-processing,
% PCA, then ICA. And each stage you can look at various things.
% There are tabs at the bottom that control the display and give you access
% to the run buttons. You can just click run ica and everything will get
% run sequentially. 
%   When you have the PCA or ICA tabs open the viewer shows you the weights
% of each components. You can click through with the slider at the bottom
% and view different components. The Component plot will show you the
% current component.
%   There is also a 3D plot so you can look at the components in that
% space. You can change which components you want to look at, and theres a
% rotation button (for help visualizing). The 3D plot will change depending
% if you have the PCA or ICA tab open.
%   Once the ICA analyis is done you can click on calc rois button and it
% will come up with rois for each component (see
% calc_rois_from_components). You can also make your own ROIs and different
% ROI sets. Just use the mouse on the image to manipulate, and create ROIs.
% press ctrl+delete to delete the currently selected rois. You can add or
% delete roi sets with the + and - buttons below the roi set list.
%   This is still very much a work in progress, so forgive me for bugs and
% things that are incomplete. Maybe we should put a versioning system
% together if you guys are interested in further developing this.

%% ICA Analysis

% So, you can use the gui to do this, or you can do it programatically

% First change some settings
icp.settings.preprocessing.smooth_window = [6,6,1]; % smoothing in [m, n, t] dimensions
% It would probably also be worth-while to add in some filters in the
% preprocessing...

icp.settings.ica.which_pcs = 1:200; % This means we'll use the first 200 PCs for the ICA analysis

% Then run each stage:
icp.run_preprocessing();
icp.run_pca();
icp.run_ica();

% Calcualte the rois from the ic components
rois = icp.calc_rois();

% That is basically all you do. The ic_rois, and ics were created with
% these settings (and the default). But they aren't necessarily the best
% settings. 





