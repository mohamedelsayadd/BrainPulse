# 🧠 Brain Pulse

<p align="center">
An end-to-end platform for AI-driven neurological diagnosis using EEG data.
</p>

<p align="center">
<a href="https://github.com/your-username/brain-pulse"><strong>Explore the docs »</strong></a>  
<a href="https://github.com/your-username/brain-pulse/issues">Report Bug</a> ·
<a href="https://github.com/your-username/brain-pulse/issues">Request Feature</a>
</p>

<p align="center">
<a href="LICENSE"><img src="https://img.shields.io/github/license/your-username/brain-pulse?style=for-the-badge" alt="License"></a>
<a href="https://github.com/your-username/brain-pulse/stargazers"><img src="https://img.shields.io/github/stars/your-username/brain-pulse?style=for-the-badge" alt="Stars"></a>
<a href="https://github.com/your-username/brain-pulse/network/members"><img src="https://img.shields.io/github/forks/your-username/brain-pulse?style=for-the-badge" alt="Forks"></a>
</p>

---

## 📖 Table of Contents

- [About The Project](#about-the-project)
- [Key Features](#key-features)
- [System Architecture](#system-architecture)
- [Technology Stack](#technology-stack)
- [The Components](#the-components)
  - [AI Core](#️-ai-core-eeg-spectrogram-classification)
  - [Hardware](#️-hardware-the-eeg-helmet)
  - [Mobile App](#-mobile-app-clinicians-interface)
  - [Backend](#️-backend-secure-api--database)
- [Getting Started](#-getting-started)
- [Roadmap](#️-roadmap)
- [Contributing](#-contributing)
- [License](#-license)
- [Acknowledgements](#-acknowledgements)

---

## 📌 About The Project

![Brain Pulse App](images/flutter-app.png)

Brain Pulse is a next-generation diagnostic platform that leverages AI to revolutionize the interpretation of EEG data. Neurological disorders like epilepsy affect millions, yet diagnosis is often slow, inaccessible, and prone to error—with misdiagnosis rates as high as 30%.

Developed as a capstone project at **Misr Engineering and Technology Academy (MET)**, Brain Pulse combines custom hardware, a state-of-the-art deep learning model, a cross-platform mobile app, and a secure backend to empower clinicians with real-time brain activity insights.

---

## ✨ Key Features

- 🧠 **AI-Powered Diagnostics:** Classifies harmful brain activity into six critical categories with 91%+ accuracy.  
- ⏱️ **Real-Time Analysis:** Provides instant predictions to support rapid clinical decision-making.  
- 🔬 **Cost-Effective Hardware:** 3D-printed EEG helmet for affordable data acquisition.  
- 📱 **Intuitive Mobile App:** Live visualization, patient management, and reporting in a Flutter-based app.  
- 🔒 **Secure & Scalable:** ASP.NET Core backend with JWT authentication and SQL Server.

---

## 🏗️ System Architecture

[EEG Helmet] --(Bluetooth)--> [Flutter Mobile App] <--(HTTPS/REST)--> [ASP.NET Backend] <--> [SQL Database]
^ |
| v
+------------------------------------------------------------> [PyTorch/ONNX Model]

less
Copy
Edit

---

## 🛠️ Technology Stack

| Component     | Technology |
|--------------|------------|
| **AI & ML**  | ![PyTorch](https://img.shields.io/badge/PyTorch-%23EE4C2C.svg?style=for-the-badge&logo=PyTorch&logoColor=white) ![ONNX](https://img.shields.io/badge/ONNX-205C9A?style=for-the-badge&logo=onnx&logoColor=white) ![Pandas](https://img.shields.io/badge/Pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white) ![scikit-learn](https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-the-badge&logo=scikit-learn&logoColor=white) |
| **Backend**   | ![.NET](https://img.shields.io/badge/.NET-512BD4?style=for-the-badge&logo=dotnet&logoColor=white) ![SQL Server](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoft%20sql%20server&logoColor=white) |
| **Mobile App**| ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white) |
| **Hardware**  | ![ESP32](https://img.shields.io/badge/ESP32-E7352C?style=for-the-badge&logo=espressif&logoColor=white) ![3D Printing](https://img.shields.io/badge/3D%20Printing-grey?style=for-the-badge) |

---

## 🔧 The Components

### 🧠 AI Core: EEG Spectrogram Classification

Trained on the **HMS - Harmful Brain Activity Classification** dataset from Harvard Medical School, our CNN model classifies EEG spectrograms into 6 categories: **Seizure, LPD, GPD, LRDA, GRDA, Other**.

- 📊 **Performance:** 91.36% validation accuracy after 12 epochs.  
- ⚙️ **Deployment:** PyTorch → ONNX for efficient inference in backend.

<details>
<summary><b>Click to view Model Architecture (PyTorch)</b></summary>

```python
import torch
import torch.nn as nn

class EEG_Spectrogram_CNN(nn.Module):
    def __init__(self, num_classes=6):
        super().__init__()
        self.conv1 = nn.Sequential(
            nn.Conv2d(4, 32, kernel_size=5, stride=1, padding=2),
            nn.BatchNorm2d(32), nn.ReLU(), nn.MaxPool2d(2)
        )
        self.conv2 = nn.Sequential(
            nn.Conv2d(32, 64, kernel_size=3, stride=1, padding=1),
            nn.BatchNorm2d(64), nn.ReLU(), nn.MaxPool2d(2)
        )
        self.conv3 = nn.Sequential(
            nn.Conv2d(64, 128, kernel_size=3, stride=1, padding=1),
            nn.BatchNorm2d(128), nn.ReLU(), nn.MaxPool2d(3)
        )
        self.flatten = nn.Flatten()
        self.classifier = nn.Sequential(
            nn.Linear(128 * 25 * 8, 1024),
            nn.ReLU(), nn.Dropout(0.5),
            nn.Linear(1024, num_classes)
        )

    def forward(self, x):
        x = self.conv1(x)
        x = self.conv2(x)
        x = self.conv3(x)
        x = self.flatten(x)
        return self.classifier(x)
```


</details>

```
</details>