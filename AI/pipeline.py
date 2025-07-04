import pandas as pd
import numpy as np
import torch 
from torch import nn
from scipy.signal import stft


class EEG_Spectrogram_CNN(nn.Module):
    """
    EEG_Spectrogram_CNN is a Convolutional Neural Network designed to classify EEG spectrogram images.

    This architecture expects input tensors with shape (Batch, 4, 300, 100), where:
        - 4: number of channels (e.g. different EEG montages or frequency bands)
        - 300: time dimension
        - 100: frequency dimension

    The network includes 3 convolutional blocks followed by a fully connected classification head
    and outputs logits for a specified number of classes (default = 6).

    Args:
        num_classes (int): Number of output classes. Default is 6.

    Forward Input:
        x (Tensor): Input tensor of shape (Batch, 4, 300, 100)

    Forward Output:
        logits (Tensor): Raw class scores of shape (Batch, num_classes)
    """
    
    def __init__(self, num_classes=6):
        super(EEG_Spectrogram_CNN, self).__init__()

        # === Convolutional Block 1 ===
        # Output: (Batch, 32, 150, 50)
        self.conv1 = nn.Sequential(
            nn.Conv2d(in_channels=4, out_channels=32, kernel_size=(5, 5), stride=1, padding=2),
            nn.BatchNorm2d(32),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size=(2, 2), stride=2)
        )

        # === Convolutional Block 2 ===
        # Output: (Batch, 64, 75, 25)
        self.conv2 = nn.Sequential(
            nn.Conv2d(in_channels=32, out_channels=64, kernel_size=(3, 3), stride=1, padding=1),
            nn.BatchNorm2d(64),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size=(2, 2), stride=2)
        )

        # === Convolutional Block 3 ===
        # Output: (Batch, 128, 25, 8)
        self.conv3 = nn.Sequential(
            nn.Conv2d(in_channels=64, out_channels=128, kernel_size=(3, 3), stride=1, padding=1),
            nn.BatchNorm2d(128),
            nn.ReLU(),
            nn.MaxPool2d(kernel_size=(3, 3), stride=3)
        )

        # === Flatten Layer ===
        self.flatten = nn.Flatten()  # Output features: 128 × 25 × 8 = 25,600

        # === Fully Connected Classifier ===
        self.classifier = nn.Sequential(
            nn.Linear(128 * 25 * 8, 1024),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(1024, num_classes)
        )

    def forward(self, x):
        """
        Defines the forward pass of the model.

        Args:
            x (Tensor): Input tensor of shape (Batch, 4, 300, 100)

        Returns:
            logits (Tensor): Output tensor of shape (Batch, num_classes)
        """
        x = self.conv1(x)
        x = self.conv2(x)
        x = self.conv3(x)
        x = self.flatten(x)
        logits = self.classifier(x)
        return logits



def generate_spectrogram_from_eeg(
    raw_eeg_file: str,  
    desired_rows: int = 300
):
    """
    Generates a regional spectrogram with a specified temporal resolution (number of rows).

    This function takes a raw EEG data file and converts it into a spectrogram,
    ensuring the output has at least the desired number of time steps (rows).

    Args:
        raw_eeg_file (str): Path to the input CSV file with raw EEG data.
        output_spectrogram_file (str): Path to save the generated spectrogram CSV.
        desired_rows (int): The target minimum number of rows for the output spectrogram.
    """
    
    # --- 1. Define Parameters & Load Data ---
    
    SAMPLING_RATE = 256  # Hz
    WINDOW_SECONDS = 2   # Using a 2s window for better time localization
    
    try:
        eeg_df = pd.read_csv(raw_eeg_file)
    except FileNotFoundError:
        print(f"ERROR: Input file not found at '{raw_eeg_file}'")
        return
        
    num_samples = len(eeg_df)
    nperseg = int(WINDOW_SECONDS * SAMPLING_RATE)

    # --- KEY CALCULATION to achieve desired rows ---
    # We calculate the required step size (in samples) to get the desired number of rows.
    # The step is `nperseg - noverlap`.
    step_samples = (num_samples - nperseg) / (desired_rows - 1)
    
    if step_samples < 1:
        step_samples = 1 # Set to the minimum possible step

    noverlap = int(nperseg - step_samples)


    # --- 2. Create Bipolar Montage and Group Channels ---
    montages = {
        'LL': ['Fp1-F7', 'F7-T3', 'T3-T5', 'T5-O1'],
        'RL': ['Fp2-F8', 'F8-T4', 'T4-T6', 'T6-O2'],
        'LP': ['Fp1-F3', 'F3-C3', 'C3-P3', 'P3-O1'],
        'RP': ['Fp2-F4', 'F4-C4', 'C4-P4', 'P4-O2']
    }
    bipolar_signals = pd.DataFrame()
    for region_channels in montages.values():
        for channel in region_channels:
            anode, cathode = channel.split('-')
            if anode in eeg_df.columns and cathode in eeg_df.columns:
                bipolar_signals[channel] = eeg_df[anode] - eeg_df[cathode]

    # --- 3. Calculate Regional Spectrograms via STFT ---
    region_psd = {}
    time_vector, freq_vector = None, None

    for region, channels in montages.items():
        region_data = bipolar_signals[channels].values.T
        f, t, Zxx = stft(region_data, fs=SAMPLING_RATE, nperseg=nperseg, noverlap=noverlap)
        
        if time_vector is None: 
            time_vector, freq_vector = t, f

        power_spectrum = np.mean(np.abs(Zxx)**2, axis=0) * 2
        region_psd[region] = power_spectrum

    # --- 4. Format Output to Match Target CSV ---
    
    target_freqs = [
        0.59, 0.78, 0.98, 1.17, 1.37, 1.56, 1.76, 1.95, 2.15, 2.34, 2.54, 2.73, 
        2.93, 3.13, 3.32, 3.52, 3.71, 3.91, 4.1, 4.3, 4.49, 4.69, 4.88, 5.08, 
        5.27, 5.47, 5.66, 5.86, 6.05, 6.25, 6.45, 6.64, 6.84, 7.03, 7.23, 7.42, 
        7.62, 7.81, 8.01, 8.2, 8.4, 8.59, 8.79, 8.98, 9.18, 9.38, 9.57, 9.77, 
        9.96, 10.16, 10.35, 10.55, 10.74, 10.94, 11.13, 11.33, 11.52, 11.72, 
        11.91, 12.11, 12.3, 12.5, 12.7, 12.89, 13.09, 13.28, 13.48, 13.67, 
        13.87, 14.06, 14.26, 14.45, 14.65, 14.84, 15.04, 15.23, 15.43, 15.63, 
        15.82, 16.02, 16.21, 16.41, 16.6, 16.8, 16.99, 17.19, 17.38, 17.58, 
        17.77, 17.97, 18.16, 18.36, 18.55, 18.75, 18.95, 19.14, 19.34, 19.53, 
        19.73, 19.92
    ]
    
    # Generate the time column based on the number of output steps
    num_time_steps = len(time_vector)
    output_time_stamps = np.arange(1, 2 * num_time_steps, 2)
    final_data = {'time': output_time_stamps}

    for region_name in ['LL', 'RL', 'LP', 'RP']:
        for freq_val in target_freqs:
            col_name = f"{region_name}_{freq_val}"
            freq_index = np.argmin(np.abs(freq_vector - freq_val))
            power_values = region_psd[region_name][freq_index, :]
            final_data[col_name] = power_values

    output_df = pd.DataFrame(final_data)

    # --- 5. return Resulting Spectrogram ---
    return output_df  # Return the DataFrame for further use or inspection



def load_model(model_path: str) -> EEG_Spectrogram_CNN:
    """
    Load the pre-trained EEG Spectrogram CNN model from the specified path.

    Args:
        model_path (str): Path to the saved model file.

    Returns:
        EEG_Spectrogram_CNN: The loaded model.
    """
    model = EEG_Spectrogram_CNN(num_classes=6)  # Initialize the model with the number of classes
    # Load the model weights
    model.load_state_dict(torch.load(model_path, weights_only=True, map_location=torch.device('cpu')))
    model.eval()  # Set the model to evaluation mode
    return model

def preprocess_data(data_path: str) -> torch.Tensor:
    """
    Preprocess the input data for the EEG Spectrogram CNN model.

    Args:
        data_path (str): Path to the CSV file containing the EEG data.

    Returns:
        torch.Tensor: Preprocessed input tensor for the model.
    """
    spec = pd.read_csv(data_path)
    spec = spec.iloc[:300, 1:]  # Select the first 300 rows and all columns except the first
    spec = np.array(spec)
    spec = (spec - spec.mean()) / (spec.std() + 1e-8)
    spec = spec.reshape(300, 4, 100).transpose(1, 0, 2)
    spec = torch.from_numpy(spec).unsqueeze(0)  # Add batch dimension
    spec = spec.type(torch.float32)  # Convert to float tensor
    return spec

def predict(model: EEG_Spectrogram_CNN, input_tensor: torch.Tensor) -> str:
    """
    Predict the probability for each class using the EEG Spectrogram CNN model.

    Args:
        model (EEG_Spectrogram_CNN): The pre-trained model.
        input_tensor (torch.Tensor): Preprocessed input tensor.

    Returns:
        str: Probabilities for each class in the format "GPD: 22.00% GRDA: 45.00% ..."
    """
    class_names = ["GPD", "GRDA", "LPD", "LRDA", "Other", "Seizure"]
    with torch.no_grad():
        y_logit = model(input_tensor)
        y_proba = torch.softmax(y_logit, dim=1)[0]  # Get probabilities for the first (and only) sample
        result = " ".join([f"{name}: {prob.item() * 100:.2f}%" for name, prob in zip(class_names, y_proba)])
        return result



def run_pipeline(model_path: str, data_path: str , raw_eeg: bool = False) -> str:
    """
    Run the complete pipeline for EEG spectrogram classification.

    Args:
        model_path (str): Path to the pre-trained model file.
        data_path (str): Path to the CSV file containing the EEG data.

    Returns:
        str: Predicted class label.
    """
    if raw_eeg:
        spec = generate_spectrogram_from_eeg(data_path,desired_rows=300)
        spec = spec.iloc[:300, 1:]  # Select the first 300 rows and all columns except the first
        spec = np.array(spec)
        spec = (spec - spec.mean()) / (spec.std() + 1e-8)
        spec = spec.reshape(300, 4, 100).transpose(1, 0, 2)
        spec = torch.from_numpy(spec).unsqueeze(0)  # Add batch dimension
        spec = spec.type(torch.float32)  # Convert to float tensor
        model = load_model(model_path)
        prediction = predict(model, spec)
        return prediction
    # If the input is already a spectrogram CSV file
    else:
        
      model = load_model(model_path)  # Load the pre-trained model
      input_tensor = preprocess_data(data_path)  # Preprocess the input data
      prediction = predict(model, input_tensor)  # Get the prediction
      return prediction  # Return the predicted class label