<div align="center">

# Brain Pulse: AI-Powered EEG Signal Analysis

**An integrated solution combining a custom EEG headset, mobile application, and a deep learning backend to revolutionize neurological diagnostics.**

<br>

![alt text](https://github.com/mohamedelsayadd/BrainPulse/blob/23cb90c48662558a7152b0a28040d7c387c953ee/Images/logo.png)

</div>

<div align="center">

[![Python](https://img.shields.io/badge/Python-3.11-3776AB.svg?style=flat&logo=python&logoColor=white)](https://www.python.org/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.0-EE4C2C.svg?style=flat&logo=pytorch&logoColor=white)](https://pytorch.org/)
[![.NET](https://img.shields.io/badge/.NET-Core-blueviolet.svg?style=flat&logo=.net)](https://dotnet.microsoft.com/)
[![Flutter](https://img.shields.io/badge/Flutter-blue.svg?style=flat&logo=flutter)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

---

## 📝 Table of Contents
- [Overview](#-overview)
- [The Problem](#-the-problem)
- [Our Solution](#-our-solution)
- [Hardware](#-hardware)
- [Mobile Application](#-mobile-application)
- [Backend](#-backend)
- [AI](#-ai)
- [Getting Started](#-getting-started)
- [Prerequisites](#prerequisites)
- [Project Team](#-project-team)
- [Acknowledgements](#-acknowledgements)
- [Installation](#installation)

## 💡 Overview
**Brain Pulse** is a graduation project from Misr Engineering and Technology Academy (MET) that bridges the gap between complex neurological diagnostics and accessibility. The project features an integrated system combining a custom-designed EEG Helmet, a user-friendly mobile application, and a powerful AI backend.

This repository provides a deep dive into the technical architecture of the project, with a special focus on the core innovation: **a Deep Learning model for the automated classification of EEG signals**.

## ❗ The Problem
Interpreting EEG data is a time-consuming process that requires highly specialized neurologists. This creates significant challenges, especially in resource-constrained environments.

- **High Misdiagnosis Rate:** Approximately **30%** of epilepsy cases are initially misdiagnosed or missed entirely, leading to incorrect treatment or none at all.
- **Lack of Access:** In regions like Egypt, over **80%** of patients, particularly in rural and underserved areas, lack proper access to timely diagnosis and treatment.
- **Inefficient Analysis:** Standard EEG recordings detect less than **40%** of actual seizure activity, and manual interpretation can take 30-60 minutes per patient, creating a bottleneck in clinical workflows.

## ✨ Our Solution
Our solution is a complete, end-to-end system designed to empower clinicians. It integrates custom hardware, a cross-platform mobile app, and a robust AI backend to provide a seamless, accurate, and real-time tool for detecting brain abnormalities anytime, anywhere.

<p align="center">
  <img src="https://i.imgur.com/vHqVwJ4.png" alt="Our Solution Stats" width="700"/>
</p>

## ⚙️ Hardware
The foundation of our system is a custom-designed, low-cost, and portable EEG Helmet. The hardware was engineered to be both effective and accessible.
- **Custom 3D-Printed Helmet:** A flexible and comfortable helmet designed in SOLIDWORKS and printed with PLA/TPU material. It includes 20 electrode sockets and internal wire channels for organized and safe routing.
- **16-Channel Data Acquisition:** Utilizes 19 golden-plated cup electrodes (16 active, 1 reference, 1 ground) to capture real-time EEG data.
- **Analog Front-End:** A multi-stage signal conditioning circuit featuring signal amplification (AD620, OP07), and advanced filtering (DRL, Notch, Low-Pass) to ensure a clean, high-quality signal.
- **Digital Conversion & Transmission:** An ESP32 microcontroller handles Analog-to-Digital Conversion and transmits the EEG data packets via Bluetooth Low Energy (BLE) to the mobile application.

<p align="center">
  <img src="https://i.imgur.com/K5d5351.png" alt="Hardware Overview" width="700"/>
</p>

## 📱 Mobile Application
The mobile application serves as the user-friendly interface for doctors, allowing them to manage patients and interact with the AI model's predictions.
- **Built with Flutter:** For a single, high-performance codebase that runs natively on both Android and iOS.
- **MVVM Architecture:** Ensures a clean, scalable, and maintainable code structure.
- **Core Features for Doctors:**
  - **Patient Management:** Add, view, and manage patient records and diagnostic history.
  - **Live EEG Monitoring:** Connect to the EEG headset and visualize brainwave data in real time.
  - **AI-Powered Diagnosis:** Upload EEG data (or connect live) to get instant classification from the AI backend.
  - **Data Visualization:** Presents the AI model's probability scores for each class in an intuitive and clear interface.
  <p align="center">
  <img src="https://i.imgur.com/K5d5351.png" alt="Hardware Overview" width="700"/>
</p>

## ☁️ Backend
The backend is the central nervous system of our project, responsible for handling data, authenticating users, and running the AI model.
- **Technology Stack:** Built with **.NET 8 (ASP.NET Core Web API)** and C#, ensuring a robust, high-performance, and scalable system.
- **REST API:** Provides a secure and efficient communication layer between the mobile app and the server.
- **AI Model Integration:** Utilizes the **ONNX Runtime** to directly load and run our pre-trained PyTorch model within the C# environment. This allows for fast, low-latency inference without needing a separate Python server.
- **Secure & Scalable:** Implements JWT for secure doctor authentication and uses Entity Framework Core with a Microsoft SQL Server database for reliable data management.

## 🧠 AI
Our end-to-end AI pipeline transforms raw brainwave signals into actionable clinical insights. The process is designed to be efficient, robust, and interpretable.

### 1. Data Source & Preprocessing
The model was trained on the **"HMS - Harmful Brain Activity Classification"** dataset from Kaggle. Our unique preprocessing pipeline is the first key step:
- **Raw EEG to Spectrogram:** We convert 10-minute raw EEG segments into spectrograms—visual representations of the signal's frequency content over time. This allows our CNN to "see" patterns in the brainwaves.
- **Normalization & Cleaning:** We normalize the data to ensure consistency and handle any missing values to make the model robust.
- **4-Channel Image Generation:** The core of our feature engineering. The full spectrogram is intelligently split and stacked to create a **4-channel image `(4, 300, 100)`**, where each channel represents a key brain region montage (Left Lateral, Right Lateral, Left Parasagittal, Right Parasagittal). This allows the model to learn spatial and location-based patterns critical for neurological diagnosis.

### 2. Model Architecture
We designed a custom **Convolutional Neural Network (CNN)** in PyTorch, specifically tailored for our 4-channel spectrogram images. The architecture follows a classic funnel structure:
- **Input Stage:** Takes the `4x300x100` image.
- **Feature Spotters (Convolutional Layers):** Multiple blocks of `Conv2D`, `BatchNorm`, `ReLU`, and `MaxPool` layers scan the image to detect low-level features and build up to more complex patterns unique to each EEG class.
- **Simplifiers (Pooling Layers):** Max-pooling layers reduce dimensionality and create a summarized feature map, making the model more efficient.
- **Decision Maker (Classifier):** A `Flatten` layer followed by `Dense` (Linear) layers classifies the features into one of six output categories.


### 3. Training & Validation
- **Framework:** PyTorch
- **Optimizer:** Adam Optimizer (`lr=1e-3`)
- **Loss Function:** Cross-Entropy Loss
- **Performance:** Achieved a **validation accuracy of 91.36%** after 12 epochs.

### 4. Model Performance
To understand performance in detail, we analyzed predictions using confusion matrices.

**Normalized Confusion Matrix:** Shows high accuracy across all categories, with strong performance on `GPD`, `GRDA`, and `Seizure`.

**Misclassification Matrix:** Highlights only the model's errors, revealing which classes are most often confused. This is crucial for understanding the model's limitations and areas for future improvement.

<p align="center">
  <img src="https://i.imgur.com/xHDBUoA.png" alt="Model Performance" width="800"/>
</p>

## 🚀 Getting Started
This section guides you through setting up and running the AI part of the project.

## Prerequisites
- Python 3.9+
- Pip package manager
- A Kaggle account to download the required dataset.

## 👥 Project Team
This project was brought to life by a talented team of students from the Computer and Systems Engineering Department at MET.

| Name                  | Role             |
| --------------------- | ---------------- |
| **Mohamed Alaa Elsayyad** | AI    |
| Mohamed Rajab         | Data Science     |
| Esraa Ali             | AI               |
| Mohamed Alaa Elbosaty | Flutter          |
| Donia Osama            | Flutter          |
| Ibrahim Ahmed         | Flutter          |
| Mina Ehab Moheb       | Backend          |
| Ahmed Elsherbiny      | Backend          |
| Mohamed Ayman         | Hardware         |
| Doha Mohamed          | Hardware         |
| Yossef Sabry          | Hardware         |
| Amira Elsayed         | Hardware         |

### Supervision
- **Supervisor:** **Assoc. Prof. Mohamed Moawed** (Head of CSE Dept, Mansoura University)


## Installation
1.  **Clone the repository:**
    ```bash
    git clone https:https://github.com/mohamedelsayadd/BrainPulse.git
    cd brain-pulse
    ```
2.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
3.  **Download the dataset:**
    Download the "HMS - Harmful Brain Activity Classification" dataset from [Kaggle](https://www.kaggle.com/competitions/hms-harmful-brain-activity-classification) and place the contents into an `input/` directory within the project folder. Your directory structure should look like this:
    ```
    brain-pulse/
    ├── input/
    │   ├── hms-harmful-brain-activity-classification/
    │   │   ├── train.csv
    │   │   ├── train_spectrograms/
    │   │   └── ...
    ├── eeg-model-notebook.ipynb
    └── README.md
    ```
4.  **Run the Jupyter Notebook:**
    Launch Jupyter Notebook and open `eeg-model-notebook.ipynb` to run the complete data preprocessing, training, and evaluation pipeline.
