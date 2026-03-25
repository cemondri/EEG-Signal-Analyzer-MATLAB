% --- SMART DATASET GENERATOR ---
clear; clc;

% 1. Load Data File
filename = 'sample_eeg_data.mat';
if ~exist(filename, 'file')
    error('ERROR: %s not found!', filename);
end

data_struct = load(filename); 
% Automatically find the first variable name inside the file
var_names = fieldnames(data_struct);
signal = data_struct.(var_names{1}); % Assign whatever variable name to 'signal'

% Ensure signal orientation (Force column vector for consistency)
if size(signal, 1) < size(signal, 2), signal = signal'; end

fs = 128; % Sampling frequency
total_sec = floor(length(signal)/fs);
features = [];

fprintf('Processing %d seconds of EEG data...\n', total_sec);

% 2. Feature Extraction (Relaxed State Portion)
% We calculate the power of frequency bands for every 1-second window
for i = 1:total_sec
    win = signal((i-1)*fs+1 : i*fs);
    % [Delta, Theta, Alpha, Beta]
    row = [bandpower(win,fs,[0.5 4]), bandpower(win,fs,[4 8]), ...
           bandpower(win,fs,[8 13]), bandpower(win,fs,[13 30])];
    features = [features; row];
end

% 3. Synthetic "Focused" Data Generation (Data Augmentation)
% We duplicate the relaxed features and modify Alpha/Beta to simulate Focus
% In a focused state, Alpha power usually decreases while Beta power increases
focused_feat = features; 
focused_feat(:,3) = focused_feat(:,3) * 0.2; % Alpha power decreased by 80%
focused_feat(:,4) = focused_feat(:,4) * 5.0; % Beta power increased by 5x

% 4. Final Table Assembly
% Merging both datasets and assigning categorical labels
all_data = [features; focused_feat];
labels = [repmat({'Relaxed'}, total_sec, 1); repmat({'Focused'}, total_sec, 1)];

EEG_Dataset = array2table(all_data, 'VariableNames', {'Delta','Theta','Alpha','Beta'});
EEG_Dataset.Status = labels;

fprintf('SUCCESS! "EEG_Dataset" table created with %d rows.\n', height(EEG_Dataset));
disp('You can now type "classificationLearner" in the command window to start training.');