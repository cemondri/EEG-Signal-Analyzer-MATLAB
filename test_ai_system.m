%% EEG AI SYSTEM VALIDATION TEST
clear; clc;
fs = 128; % Sampling frequency (Hz)
t = 0:1/fs:1-1/fs; % 1-second time vector

fprintf('--- Testing EEG Diagnosis System ---\n\n');

% --- TEST 1: SYNTHETIC "RELAXED" DATA ---
% Generating a 10 Hz (Alpha band) sine wave with slight white noise.
% Alpha waves (8-13 Hz) are typical of a relaxed, wakeful state.
relaxed_signal = sin(2*pi*10*t) + 0.1*randn(1, fs); 
prediction1 = predict_eeg_state(relaxed_signal, fs);
fprintf('Test 1 (10 Hz Alpha) -> Expected: Relaxed | Result: %s\n', char(prediction1));

% --- TEST 2: SYNTHETIC "FOCUSED" DATA ---
% Generating a 25 Hz (Beta band) high-frequency sine wave.
% Beta waves (13-30 Hz) are associated with active concentration and focus.
focused_signal = sin(2*pi*25*t) + 0.1*randn(1, fs);
prediction2 = predict_eeg_state(focused_signal, fs);
fprintf('Test 2 (25 Hz Beta)  -> Expected: Focused | Result: %s\n', char(prediction2));

fprintf('\n--- Test Validation Complete! ---\n');