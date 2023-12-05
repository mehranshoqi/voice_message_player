enum PlayStatus { init, playing, pause, stop, downloading, downloadError }

enum PlaySpeed { x1, x1_25, x1_5, x1_75, x2, x2_25 }

extension GetSpeed on PlaySpeed {
  double get getSpeed {
    switch (this) {
      case PlaySpeed.x1:
        return 1.0;
      case PlaySpeed.x1_25:
        return 1.25;
      case PlaySpeed.x1_5:
        return 1.50;
      case PlaySpeed.x1_75:
        return 1.75;
      case PlaySpeed.x2:
        return 2.00;
      case PlaySpeed.x2_25:
        return 2.25;
    }
  }
}
