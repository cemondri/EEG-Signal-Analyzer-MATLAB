% =========================================================================
% --- PROFESSIONAL EEG SIGNAL PROCESSING & ANALYSIS GUI v1.0 ---
% Developer Edition 
% =========================================================================
clear; clc; close all;

% ---------------------------------------------------------
% 1. MAIN WINDOW & DATA STORAGE 
% ---------------------------------------------------------
main_window = uifigure('Name', 'EEG Signal Analysis Laboratory', 'Position', [100, 100, 900, 600]);

% Add synthetic demo data so the plot is not empty on startup
Fs_demo = 250;
time_demo = 0 : 1/Fs_demo : 5;
signal_demo = 0.5*randn(size(time_demo)) + 1.2*sin(2*pi*10*time_demo) + 0.9*sin(2*pi*22*time_demo);

% The shared memory (backpack) of the entire program
main_window.UserData = struct('Fs', Fs_demo, 'time', time_demo, 'raw_signal', signal_demo);

% ---------------------------------------------------------
% 2. UI DESIGN (CONTROLS & LAYOUT)
% ---------------------------------------------------------
% Main Plot Area (Spacious layout)
plot_area = uiaxes(main_window, 'Position', [50, 150, 800, 400]);

% CONTROL PANEL (Bottom Section)
% a) Load Real Data Button (Dark Green)
load_btn = uibutton(main_window, 'Position', [50, 50, 160, 45], ...
                        'Text', 'Load Real Data (.mat)', ...
                        'FontWeight', 'bold', 'FontSize', 14, ...
                        'BackgroundColor', [0.15 0.5 0.25], ... 
                        'FontColor', 'white');

% b) Artifact Removal Button (Brick Red)
clean_btn = uibutton(main_window, 'Position', [230, 50, 160, 45], ...
                          'Text', 'Remove Artifacts', ...
                          'FontWeight', 'bold', 'FontSize', 14, ...
                          'BackgroundColor', [0.8 0.3 0.2], ... 
                          'FontColor', 'white');

% c) FFT Spectrum Button (Tech Dark Purple)
fft_btn = uibutton(main_window, 'Position', [410, 50, 160, 45], ...
                      'Text', 'Frequency Spectrum', ...
                      'FontWeight', 'bold', 'FontSize', 14, ...
                      'BackgroundColor', [0.3 0.1 0.4], ... 
                      'FontColor', [1 0.9 0.4]);

% d) Frequency Slider and Label
uilabel(main_window, 'Position', [600, 80, 250, 22], ...
        'Text', 'Live Bandpass Filter (Hz):', ...
        'FontWeight', 'bold', 'FontSize', 13);
    
freq_slider = uislider(main_window, 'Position', [600, 60, 250, 3], ...
                           'Limits', [1, 50], 'Value', 10);

% ---------------------------------------------------------
% 3. CALLBACK ASSIGNMENTS (WIRING)
% ---------------------------------------------------------
% Assign tasks after objects are created (Top-to-bottom execution rule)
load_btn.ButtonPushedFcn = @(src, event) load_data(main_window, plot_area, freq_slider);
clean_btn.ButtonPushedFcn = @(src, event) remove_artifacts(main_window, plot_area, freq_slider);
fft_btn.ButtonPushedFcn = @(src, event) show_spectrum(main_window);
freq_slider.ValueChangedFcn = @(src, event) live_filter(main_window, plot_area, event.Value);

% Auto-trigger to draw the initial plot on startup
live_filter(main_window, plot_area, 10);


% =========================================================================
% --- BACKGROUND ENGINE ---
% =========================================================================

% --- 1. LOAD DATA ---
function load_data(window, target_plot, slider)
    [file_name, file_path] = uigetfile('*.mat', 'Select an EEG Data File');
    if file_name == 0; return; end % Exit if user canceled
    
    full_path = fullfile(file_path, file_name);
    loaded_data = load(full_path);
    variables = fieldnames(loaded_data);
    new_signal = loaded_data.(variables{1});
    
    if ~isvector(new_signal)
        uialert(window, 'Please select a file containing a single EEG channel!', 'Error');
        return;
    end
    
    % Ask for Sampling Frequency
    answer = inputdlg('What is the Sampling Frequency (Fs) of this data?', 'Frequency Info', [1 40], {'128'});
    if isempty(answer); new_Fs = 250; else; new_Fs = str2double(answer{1}); end
    
    new_time = (0:length(new_signal)-1) / new_Fs;
    
    % Update the Shared Memory
    window.UserData.Fs = new_Fs;
    window.UserData.time = new_time;
    window.UserData.raw_signal = new_signal;
    
    % Reset UI and Plot
    slider.Value = 10;
    live_filter(window, target_plot, 10);
    uialert(window, 'Real data loaded successfully!', 'Information');
end

% --- 2. REMOVE EYE BLINKS (ARTIFACTS) ---
function remove_artifacts(window, target_plot, slider)
    signal = window.UserData.raw_signal;
    threshold = 3 * std(signal); % 3 Standard deviations clipping rule
    
    % Clipping process
    signal(signal > threshold) = threshold;
    signal(signal < -threshold) = -threshold;
    
    window.UserData.raw_signal = signal; % Put clean data back into memory
    live_filter(window, target_plot, slider.Value); % Refresh plot
    uialert(window, 'Wild eye blinks and muscle artifacts successfully clipped!', 'Cleanup Complete');
end

% --- 3. FFT (FREQUENCY SPECTRUM) ---
function show_spectrum(window)
    Fs = window.UserData.Fs;
    signal = window.UserData.raw_signal;
    
    L = length(signal);
    Y = fft(signal);
    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    freq_axis = Fs*(0:(L/2))/L;
    
    figure('Name', 'Signal Frequency Spectrum', 'Color', 'k', 'Position', [350 350 600 300]);
    plot(freq_axis, P1, 'LineWidth', 1.5, 'Color', [0.6 0.2 0.6]);
    title('All Frequencies within the Signal');
    xlabel('Frequency (Hz)', 'Color','w'); ylabel('Power','Color', 'w');
    xlim([0 40]); grid on;
end

% --- 4. LIVE FILTERING AND PLOTTING ---
function live_filter(window, target_plot, center_freq)
    Fs = window.UserData.Fs;
    time = window.UserData.time;
    signal = window.UserData.raw_signal;
    
    lower_bound = max(0.5, center_freq - 2); 
    upper_bound = min(Fs/2 - 1, center_freq + 2); 
    
    nyquist = Fs / 2;
    [b, a] = butter(2, [lower_bound, upper_bound]/nyquist);
    clean_signal = filtfilt(b, a, signal);
    
    plot(target_plot, time, signal, 'Color', [0.8 0.8 0.8]); 
    hold(target_plot, 'on');
    plot(target_plot, time, clean_signal, 'Color', [0 0.3 0.7], 'LineWidth', 1.5);
    hold(target_plot, 'off');
    
    title(target_plot, sprintf('Currently Monitoring Band: %.1f Hz - %.1f Hz', lower_bound, upper_bound));
    xlabel(target_plot, 'Time (s)'); ylabel(target_plot, 'Amplitude');
    grid(target_plot, 'on');
end