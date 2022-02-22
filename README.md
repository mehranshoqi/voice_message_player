
## Voicey - Flutter voice message player
<p align="center">
    <img src="voicey-logos.jpeg" alt="voice message package" width="200" style="border-radius: 50%; overflow:hidden;">
</p>
<div style="height:6px;"></div>

<div style="height:32px;"></div>

![](https://img.shields.io/github/license/mehranshoqi/voice_message_player?color=FF5D73&style=for-the-badge)
![](https://img.shields.io/github/languages/code-size/mehranshoqi/voice_message_player?color=6FD08C&label=Size&style=for-the-badge)
![](https://img.shields.io/github/issues/mehranshoqi/voice_message_player?color=E7E393&style=for-the-badge)
![](https://img.shields.io/pub/v/voice_message_package?color=D1F5FF&style=for-the-badge)
![](https://img.shields.io/github/last-commit/mehranshoqi/voice_message_player?color=F0F600&style=for-the-badge)

## Demo

<div style="height:24px;"></div>
<p align="center">
    <img src="voice_message_intro.gif" alt="flutter voice message player demo" style="margin-top: 24px;">
</p>
<div style="height:12px;"></div>
<p style="font-size: 18px"/>
Voicey is a flutter package to play voice messages in chats with playback rates x1/x2.
</p>
<div style="height:40px;"></div>

## Platform Support

| Android | iOS | MacOS | Web |
| :-----: | :-: | :---: | :-: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |

<div style="height:16px;"></div>

## Installation

First add voicey to your pubsbec.yaml file:

```yml
dependencies:
  voice_message_package: <latest-version>
```
<div style="height:12px;"></div>

Next, get package from pub dependencies:
```dart
flutter pub get
```

<div style="height:40px;"></div>

## How to use

All you need is pass your audio file src to VoiceMessage widget:
```dart
VoiceMessage(audioSrc: 'YOUR_AUDIO_URL');
```

## Todo

- [ ] generate noises according to real voice noise.
- [x] add x2 playback speed.
- [ ] dynamic size for voice widget.
- [ ] dynamic size for noises.


<!-- ## Donation

[![Donate with Ripple](https://en.cryptobadges.io/badge/big/r3EazHwqTd7ifeCJj5gm3xdRna71vwmhwp)](https://en.cryptobadges.io/donate/r3EazHwqTd7ifeCJj5gm3xdRna71vwmhwp) -->


## Me

:pushpin:Find me at [mehran-dev.web.app](https://mehran-dev.web.app)




