function install_icp()
%% Run this to install ICP

% @todo: check the version and for the right functions.

thisdir = fileparts(mfilename('fullpath'));

addpath(thisdir);
addpath(fullfile(thisdir, 'ecc'));
addpath(fullfile(thisdir, 'FastICA_25'));

cd(fullfile(thisdir, 'GUILayout-v1p13'));
install();
cd(thisdir);

if savepath()
    % Then save failed
    fprintf('- Failed to save path, you will need to re-install when MATLAB is restarted\n');
else
    fprintf('+ Path saved\n');
end