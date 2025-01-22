# Whisper Flutter New

[![pub package](https://img.shields.io/pub/v/whisper_flutter_new.svg?label=whisper_flutter_new&color=blue)](https://pub.dev/packages/whisper_flutter_new)

# Important Notice:

**I am currently refactoring the functionality and plan to provide flutter bindings for both llama.cpp and whisper.cpp. After the refactoring is complete, I will consider adapting to Windows and MacOS**

Ready to use [whisper.cpp](https://github.com/ggerganov/whisper.cpp) models implementation for iOS
and Android

1. Support AGP8+
2. Support Android 5.0+ & iOS 13+ & MacOS 11+
3. It is optimized and fast

Supported models: tiny、base、small、medium、large-v1、large-v2

Recommended Models：base、small、medium

All models have been actually tested, test devices: Android: Google Pixel 7 Pro, iOS: M1 iOS
simulator，MacOS: M1 MacBookPro & M2 MacMini

## Features

- Supports both Android and iOS platforms
- GPU acceleration using Metal on iOS and Vulkan on Android
- CPU optimization with Accelerate framework on iOS
- High-performance speech recognition

## Requirements

### iOS
- iOS 11.0 or later
- Device with Metal support

### Android
- Android 5.0 (API 21) or later
- Device with Vulkan support

## Install library

```bash
flutter pub add whisper_flutter_new
```

## import library

```dart
import 'package:whisper_flutter_new/whisper_flutter_new.dart';
```

## Quickstart

```dart
// Prepare wav file
final Directory documentDirectory = await getApplicationDocumentsDirectory();
final ByteData documentBytes = await rootBundle.load('assets/jfk.wav');

final String jfkPath = '${documentDirectory.path}/jfk.wav';

await File(jfkPath).writeAsBytes(
    documentBytes.buffer.asUint8List(),
);

// Begin whisper transcription
/// China: https://hf-mirror.com/ggerganov/whisper.cpp/resolve/main
/// Other: https://huggingface.co/ggerganov/whisper.cpp/resolve/main
final Whisper whisper = Whisper(
    model: WhisperModel.base,
    downloadHost: "https://huggingface.co/ggerganov/whisper.cpp/resolve/main"
);

final String? whisperVersion = await whisper.getVersion();
print(whisperVersion);

final String transcription = await whisper.transcribe(
    transcribeRequest: TranscribeRequest(
        audio: jfkPath,
        isTranslate: true, // Translate result from audio lang to english text
        isNoTimestamps: false, // Get segments in result
        splitOnWord: true, // Split segments on each word 
    ),
);
print(transcription);
```

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  whisper_flutter_new:
    git:
      url: https://github.com/[username]/whisper_flutter_new.git
      ref: gpu-support
```

## Usage

The GPU acceleration is automatically enabled on supported devices. No additional configuration is required.

# GPU Acceleration Support

## iOS (Metal)
- Automatically enabled on iOS 11.0+ devices with Metal support
- Uses Metal for GPU acceleration and Accelerate framework for CPU optimization
- Fallbacks to CPU if Metal is not available

## Android (Vulkan)
- Automatically enabled on Android 5.0+ devices with Vulkan support
- Requires Vulkan 1.0 or higher
- Fallbacks to CPU if Vulkan is not available

## Usage Example with GPU Support

```dart
final whisper = Whisper(
    model: WhisperModel.base,
    downloadHost: "https://huggingface.co/ggerganov/whisper.cpp/resolve/main"
);

// Check and initialize GPU support
final bool gpuInitialized = await whisper.initializeGPU();
print('GPU Acceleration: ${gpuInitialized ? 'Enabled' : 'Disabled'}');

// Get GPU information
final gpuInfo = await WhisperGPU.getGPUInfo();
print('GPU Info: $gpuInfo');

// Rest of your existing code...
```

## Performance Considerations

- GPU acceleration can significantly improve performance, especially for larger models
- For small audio files (<30 seconds), CPU might be faster due to initialization overhead
- GPU memory usage is optimized but depends on the model size
