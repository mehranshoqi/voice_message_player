import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final double? progress;
  final Function onClose;
  final Widget stopDownloadingIcon ; 
  final Color loadingColor ;

  const LoadingWidget({
    Key? key,
    required this.progress,
    required this.onClose,
    required this.stopDownloadingIcon,
    required this.loadingColor
  }) : super(key: key);

  @override
  LoadingWidgetState createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * 3.1416,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: widget.loadingColor,
                  value: widget.progress ?? 0,
                ),
              ),
            );
          },
        ),
        Positioned(
          child: InkWell(
            child: widget.stopDownloadingIcon ,
            onTap: () => widget.onClose(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
