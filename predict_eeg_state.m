function result = predict_eeg_state(signal, fs)
    % --- STEP 1: Load the AI Model ---
    % Loading the trained brain from the .mat file.
    % Ensure the filename matches your exported model (v2).
    data = load('eeg_brain_model_v2.mat'); 
    
    % Dynamically assign the first variable in the file to 'model'
    % This handles cases where the variable name inside the file varies.
    fields = fieldnames(data);
    model = data.(fields{1}); 

    % --- STEP 2: Feature Extraction ---
    % AI cannot process raw signals directly. We calculate frequency band powers.
    % Analyzing only the last 1 second to provide real-time diagnosis.
    last_sec = signal(end-fs+1 : end);
    
    % Extracting power values for specific brainwave bands:
    d = bandpower(last_sec, fs, [0.5 4]);  % Delta (Deep Sleep / Artifacts)
    t = bandpower(last_sec, fs, [4 8]);    % Theta (Drowsiness / Light Sleep)
    a = bandpower(last_sec, fs, [8 13]);   % Alpha (Relaxation / Relaxed State)
    b = bandpower(last_sec, fs, [13 30]);  % Beta (Active Thinking / Focused State)

    % --- STEP 3: Decision Making (Prediction) ---
    % The model expects inputs in a Table format with specific VariableNames.
    input_table = table(d, t, a, b, 'VariableNames', {'Delta','Theta','Alpha','Beta'});
    
    % Inference: The model evaluates the features and returns the classification result.
    result = model.predictFcn(input_table);
end