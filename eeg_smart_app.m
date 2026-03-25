function eeg_smart_app()
    % --- MAIN UI DESIGN (DARK MODE) ---
    % Creating the main figure with a charcoal black background
    fig = figure('Name', 'EEG AI Analyzer - Dark Mode', 'NumberTitle', 'off', ...
                 'MenuBar', 'none', 'Color', [0.05 0.05 0.05], 'Position', [200, 200, 900, 600]);

    % Axis/Plot Styling - Using high-contrast colors for visibility in dark mode
    ax = axes('Parent', fig, 'Position', [0.1, 0.45, 0.8, 0.45], ...
              'Color', [0.1 0.1 0.1], 'XColor', [0.8 0.8 0.8], 'YColor', [0.8 0.8 0.8], ...
              'GridColor', [0.3 0.3 0.3]);
    title(ax, 'EEG Signal Stream', 'Color', [0 0.8 1], 'FontSize', 12, 'FontWeight', 'bold');
    xlabel(ax, 'Time Index'); ylabel(ax, 'Amplitude (µV)'); grid(ax, 'on');

    % Status Panel Design
    uicontrol('Style', 'text', 'String', 'SYSTEM STATUS:', 'Position', [50, 130, 200, 30], ...
              'FontSize', 14, 'FontWeight', 'bold', 'BackgroundColor', [0.05 0.05 0.05], 'ForegroundColor', [1 1 1]);
          
    % statusText will display the AI prediction results
    statusText = uicontrol('Style', 'text', 'String', 'Waiting for input...', 'Position', [250, 125, 500, 45], ...
                 'FontSize', 20, 'FontWeight', 'bold', 'ForegroundColor', [0.6 0.6 0.6], ...
                 'BackgroundColor', [0.1 0.1 0.1], 'String', 'READY FOR ANALYSIS.');

    % --- MODERN INTERFACE BUTTONS ---
    % Button 1: Load EEG Data
    uicontrol('Style', 'pushbutton', 'String', 'LOAD DATA', 'Position', [50, 40, 200, 50], ...
              'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontSize', 11, 'FontWeight', 'bold', ...
              'Callback', @(src, event) loadData());

    % Button 2: Perform AI Diagnosis
    uicontrol('Style', 'pushbutton', 'String', 'RUN AI DIAGNOSIS', 'Position', [270, 40, 250, 50], ...
              'BackgroundColor', [0 0.7 0.9], 'ForegroundColor', [0 0 0], 'FontSize', 12, 'FontWeight', 'bold', ...
              'Callback', @(src, event) runAIDiagnosis());

    % --- APP DATA STORAGE (MEMORY) ---
    appData = struct('signal', [], 'fs', 128);

    % --- INTERNAL FUNCTIONS ---
    
    % Function to handle file selection and loading
    function loadData()
        [file, path] = uigetfile('*.mat', 'Select an EEG Data File');
        if isequal(file, 0), return; end % Exit if user cancels
        
        raw = load(fullfile(path, file));
        vars = fieldnames(raw);
        appData.signal = raw.(vars{1}); % Dynamically extract the first variable
        
        % Update the plot with a vibrant neon green line
        plot(ax, appData.signal(1:min(length(appData.signal), 1000)), 'LineWidth', 1.5, 'Color', [0.2 1 0.2]);
        title(ax, ['Loaded File: ' file], 'Color', [0 0.8 1]);
        set(statusText, 'String', 'DATA READY.', 'ForegroundColor', [0.8 0.8 0.8]);
    end

    % Function to communicate with the AI model
    function runAIDiagnosis()
        if isempty(appData.signal)
            errordlg('Error: Please load a data file first!'); return;
        end
        
        try
            % Calling the external prediction function (predict_eeg_state.m)
            result = predict_eeg_state(appData.signal, appData.fs);
            
            % Update UI with the result and apply NEON COLORING
            set(statusText, 'String', ['DIAGNOSIS: ' upper(char(result))]);
            
            if strcmp(result, 'Relaxed')
                set(statusText, 'ForegroundColor', [0 1 0]); % Vibrant Green for Relaxed
            else
                set(statusText, 'ForegroundColor', [1 0.2 0.2]); % Vibrant Red for Focused
            end
        catch ME
            errordlg(['AI Error: ' ME.message]);
        end
    end
end