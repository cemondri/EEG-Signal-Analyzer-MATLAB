# EEG-Signal-Analyzer-MATLAB
#  EEG Signal Analyzer & AI Classifier (MATLAB)

An interactive, multi-stage MATLAB application designed for researchers, neuroscientists, and AI enthusiasts. This project has evolved from a fundamental Digital Signal Processing (DSP) tool into a sophisticated AI-driven classifier, allowing users to visualize, clean, and diagnose EEG data within a high-performance environment.

##  Features

# New in Version 2.0: The AI Evolution
The V2 update transforms the analyzer from a visualization tool into an intelligent system capable of "understanding" brain activity.

AI-Driven Mental State Classification: Integrated a trained Linear Support Vector Machine (SVM) model to classify states between Relaxed and Focused.

Professional Dark Mode GUI: A sleek, high-contrast user interface designed for clinical and research environments, reducing eye strain during long analysis sessions.

Automated Feature Extraction: Real-time calculation of spectral power across Delta, Theta, Alpha, and Beta bands to feed the AI engine.

Intelligent File Handling: Dynamic variable detection that automatically identifies signal structures within .mat files.

# Classic Features (Version 1.0)
The foundational DSP engine remains accessible for deep signal inspection and preprocessing:

Live Bandpass Filtering: Interactive frequency tuning to isolate specific brainwave bands and visualize clean overlays on raw data.

Automated Artifact Removal: One-click noise reduction using a robust 3-standard-deviation thresholding algorithm to clip blinks and muscle artifacts.

FFT Spectrum Analysis: High-resolution Fast Fourier Transform plots to inspect power distribution in the frequency domain.

##  Screenshots

### **1. Version 2.0: AI-Powered Dark Mode (Latest)**
> The new intelligent interface designed for high-contrast analysis and real-time mental state classification.
> 
**Data Initialization** 
> <img width="1470" height="956" alt="Data_Initialization" src="https://github.com/user-attachments/assets/e4435e2d-367d-4d5f-94d3-b1f98d79646e" />
**Real-Time AI Diagnosis**
> <img width="1470" height="956" alt="Real-Time_AI_Diagnosis" src="https://github.com/user-attachments/assets/1384a9ab-189d-40dd-ad8a-0c226b3b1cdd" />



### **2. Version 1.0: Classic Signal Processing Foundations**
*The foundational DSP engine focused on artifact removal and spectral density inspection.*

**Raw EEG Data with Eye-Blink Artifacts**
<img width="1470" height="956" alt="raw_data" src="https://github.com/user-attachments/assets/ead9b6d2-385c-43c5-9366-dbbce50b685f" />


**Cleaned Signal (After Artifact Removal)**
<img width="1470" height="956" alt="removed_artifacts" src="https://github.com/user-attachments/assets/966bc4ed-8b35-4772-8f34-09ab615745eb" />


**Frequency Domain Analysis (FFT)**
<img width="1470" height="956" alt="frequency_spectrum" src="https://github.com/user-attachments/assets/7d5fe4f4-662a-48f6-848b-c0322b092bf4" />

## Project Structure & Files

(eeg_smart_app.m)	Main Entry Point (V2). Launches the Dark Mode AI GUI.
(eeg_gui_v1.m)	Classic Entry Point (V1). Launches the original DSP GUI.
(predict_eeg_state.m)	The AI Inference Engine; processes signals for the model.
(eeg_brain_model_v2.mat)	The trained SVM model (The Brain).
(EEG_Dataset_Creator.m)	Automated script for feature extraction and dataset building.
(test_ai_system.m)	Validation script to test AI logic with synthetic data.

##  Installation & Usage

# Prerequisites:

MATLAB (R2021a or newer recommended).
Signal Processing Toolbox.
Statistics and Machine Learning Toolbox (for V2 AI features).

# Run Instructions

1. Clone the Repo: Download or clone all files into a single folder.
2. Launch V2 (AI): Type eeg_smart_app in the Command Window to use the latest AI features.
3. Launch V1 (DSP): Type eeg_gui_v1 for the classic signal cleaning interface.
4. Load Data: Use the included sample_eeg_data.mat for a quick demonstration.

## Technical Specifications

Sampling Rate: 128 Hz (Default)
Frequency Bands: 
Delta: 0.5 - 4 Hz
Theta: 4 - 8 Hz
Alpha: 8 - 13 Hz (Primary indicator for Relaxed state)
Beta: 13 - 30 Hz (Primary indicator for Focused state)
AI Model: Linear SVM (Support Vector Machine) trained on spectral power density.

## Future Roadmap (v3.0)

Real-time streaming support for OpenBCI and Neurosky hardware.
Spectrogram (Time-Frequency) visualization window.
Multi-channel Topographic mapping.
Exporting AI diagnostic reports as PDF/CSV.

##  Author
Developed as a comprehensive project to bridge the gap between complex DSP mathematics and accessible user interfaces.
