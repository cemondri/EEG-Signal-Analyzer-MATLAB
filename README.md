# EEG-Signal-Analyzer-MATLAB
#  Professional EEG Signal Processing & Analysis GUI

An interactive, event-driven MATLAB application designed for researchers, neuroscientists, and digital signal processing (DSP) enthusiasts. This GUI provides a real-time, user-friendly environment to load, filter, clean, and analyze raw EEG data without writing a single line of code during operation.

##  Features

* ** Real Data Integration:** Easily load single-channel EEG records from `.mat` files. Includes dynamic sampling rate (Fs) allocation.
* ** Live Bandpass Filtering:** An interactive slider that acts as a live "frequency tuner." Instantly isolate specific brainwave bands (Delta, Theta, Alpha, Beta, Gamma) and visualize the clean signal overlaid on the raw data.
* ** Automated Artifact Removal:** A one-click preprocessing tool that detects and clips high-amplitude noise (like eye blinks and muscle artifacts) using a robust 3-standard-deviation thresholding algorithm.
* ** FFT Spectrum Analysis:** Generate a high-resolution frequency domain plot (Fast Fourier Transform) in a separate window to inspect the power distribution of the brainwaves.

##  Screenshots
**1. Raw EEG Data with Eye-Blink Artifacts**
<img width="1470" height="956" alt="raw_data" src="https://github.com/user-attachments/assets/ead9b6d2-385c-43c5-9366-dbbce50b685f" />


**2. Cleaned Signal (After Artifact Removal)**
<img width="1470" height="956" alt="removed_artifacts" src="https://github.com/user-attachments/assets/966bc4ed-8b35-4772-8f34-09ab615745eb" />


**3. Frequency Domain Analysis (FFT)**
<img width="1470" height="956" alt="frequency_spectrum" src="https://github.com/user-attachments/assets/7d5fe4f4-662a-48f6-848b-c0322b092bf4" />



##  Installation & Usage

1. **Prerequisites:** You need MATLAB installed on your system. (Signal Processing Toolbox is recommended).
2. **Download:** Clone this repository or download the `eeg_gui_v1.m` file.
3. **Run:** Open MATLAB, navigate to the folder containing the file, and type the name of the script in the Command Window (or press the Run button).
4. **Analyze:**
   * Click **Load Real Data** to import your `.mat` file.
   * Use the **Remove Artifacts** button to clean the raw signal.
   * Slide the **Live Bandpass Filter** to sweep through frequencies.
   * Click **Frequency Spectrum (FFT)** to view the spectral density.

##  Future Roadmap (v2.0)
* [ ] Export cleaned/filtered data as `.mat` or `.csv`
* [ ] Support for standard medical formats (e.g., `.edf` files)
* [ ] Time-Frequency analysis (Spectrogram window)
* [ ] Multi-channel support and Topographic Maps (Topoplots)

##  Author
Developed as a comprehensive project to bridge the gap between complex DSP mathematics and accessible user interfaces.
