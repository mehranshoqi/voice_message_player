## Voicey - Flutter voice message player

<!-- <p align="center">
    <img src="voicey-logos.jpeg" alt="voice message package" width="200" style="border-radius: 50%; overflow:hidden;">
</p> -->
<div style="height:6px;"></div>

<div style="height:32px;"></div>

![](https://img.shields.io/github/license/mehranshoqi/voice_message_player?color=FF5D73&style=for-the-badge)
![](https://img.shields.io/github/languages/code-size/mehranshoqi/voice_message_player?color=6FD08C&label=Size&style=for-the-badge)
![](https://img.shields.io/github/issues/mehranshoqi/voice_message_player?color=E7E393&style=for-the-badge)
![](https://img.shields.io/pub/v/voice_message_package?color=D1F5FF&style=for-the-badge)
![](https://img.shields.io/github/last-commit/mehranshoqi/voice_message_player?color=F0F600&style=for-the-badge)

## Demo

<div style="height:24px;"></div>

![](voice_message_intro.gif)

<div style="height:12px;"></div>
<p style="font-size: 18px" >
Voicey is a flutter package to play voice messages in chats. Also, you can sicking by dragging on voice noises.
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
VoiceMessageView(
  controller: VoiceController(
    audioSrc:
        'https://dl.solahangs.com/Music/1403/02/H/128/Hiphopologist%20-%20Shakkak%20%28128%29.mp3',
    onComplete: () {
      /// do something on complete
    },
    onPause: () {
      /// do something on pause
    },
    onPlaying: () {
      /// do something on playing
    },
    onError: (err) {
      /// do somethin on error
    },
  ),
  maxDuration: const Duration(seconds: 10),
  isFile: false,
  innerPadding: 12,
  cornerRadius: 20,
),
```

## Todo

- [✔️] Cache audio and play from cache.
- [✔️] Seeking on audio by drag on noises.
- [✔️] Change playback speed.
- [✔️] Handle exceptions.
- [✔️] Customization .
- [✔️] Dynamic width for voice widget.

<div style="height:32px;"></div>


<h2>
<a style="text-decoration: none; color: #0000ff" href="https://mehran.monster/">www.mehran.monster</a>
</h2>

<div style="height:16px;"></div>
### Contributing

##### :beer: Pull requests are welcome!

Don't forget that `open-source` makes no sense without contributors. No matter how big your changes are, it helps us a lot even it is a line of change.

## License

Licensed under the MIT license. See [LICENSE](https://github.com/mehranshoqi/voice_message_player/blob/master/LICENSE "LICENSE").

بم میگن اوستا حتی سیاها آفریقا