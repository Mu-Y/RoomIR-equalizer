# RoomIR-equalizer
Final project for USC course EE522: Immersive Audio Processing

## Introduction
Apply a Parallel Second-order Filter-based Equalizer([Balázs Bank, 2008](https://ieeexplore.ieee.org/document/4529229)) to calibrate Room Impluse Reponse. Different target Impulse Responses are also possible by designing the target curve.

## Prerequisite:
MatLab. Later version is preferred.

## Data
Open-source Room Impulse Response from [openairlib.net](http://www.openairlib.net/auralizationdb/content/live-room-sound-studio-laboratory-university-athens)(Unfortunately, this amazing website is currently down due to unknown reasons.). The file `r8-omni-conf_b.wav` in this repo is one of the recorded Room Impulse Response wav files from a sound studio of the Laboratory of Music Acoustics Technology (LabMAT) at the Department of Music Studies of the University of Athens.

## Run code:
```
Run main.m in Matlab
```

## Results:
The figure shows the calibration of the equalizer to the Room Impulse Response. The original Impulse Response is a relatively extreme condition - mid and high frequency is significantly lost. The equalizer is able to tweak the original Impulse Response to your target - in this case a "flat" Impulse Response.
![Room Impulse Response Calibration][figure]

[figure]: figure.png


## Audio samples
Convolve audio with the Room Impulse Responses, to hear the impact of Room Impulse Response on the listening experience, and also the calibration of the equalizer.
- Sound studio Impulse Response(data accompanying this repo), audio is a classical music clip.
  - Original: [audio](https://soundcloud.com/mu-yang-974011976/classic-short?in=mu-yang-974011976/sets/roomir-equalizer)
  - Conv with Room Impulse Response: [audio](https://soundcloud.com/mu-yang-974011976/classic-short-live-studio?in=mu-yang-974011976/sets/roomir-equalizer)
  - Conv with **Equalized** Room Impulse Response: [audio](https://soundcloud.com/mu-yang-974011976/classic-short-live-studio-eq?in=mu-yang-974011976/sets/roomir-equalizer)
- Another Impulse Response from an office room, audio is an EDM clip.
  - Original: [audio](https://soundcloud.com/mu-yang-974011976/edm-short?in=mu-yang-974011976/sets/roomir-equalizer)
  - Conv with Room Impulse Response: [audio](https://soundcloud.com/mu-yang-974011976/edm-short-air-office?in=mu-yang-974011976/sets/roomir-equalizer)
  - Conv with **Equalized** Room Impulse Response: [audio](https://soundcloud.com/mu-yang-974011976/edm-short-air-office-eq?in=mu-yang-974011976/sets/roomir-equalizer)
