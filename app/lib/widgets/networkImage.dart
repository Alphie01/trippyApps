import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:flutter/material.dart';

class NetworkContainer extends StatefulWidget {
  const NetworkContainer(
      {super.key,
      required this.imageUrl,
      required this.onLoad,
      this.child,
      this.fit = BoxFit.cover,
      this.borderRadius});

  @override
  _NetworkContainerState createState() => _NetworkContainerState();
  final NetworkImage imageUrl;
  final Widget? child;
  final BoxFit fit;
  final Function onLoad;
  final BorderRadius? borderRadius;
}

class _NetworkContainerState extends State<NetworkContainer> {
  bool _isLoading = true;
  ImageProvider? _imageProvider;
  BorderRadius? borderRadius;
  @override
  void initState() {
    super.initState();

    _imageProvider = widget.imageUrl;

    _imageProvider!.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, synchronousCall) {
        if (mounted) {
          setState(() {
            _isLoading = false; // Yükleme tamamlandı
          });
          
        }
      }),
    );
    widget.onLoad!();
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme.dataSaverMode
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AppTheme.background == AppBlackTheme.background
                      ? AssetImage('assets/logo.png')
                      : AppTheme.logo,
                  fit: widget.fit),
              borderRadius: widget.borderRadius ?? defaultRadius,
            ),
            child: widget.child,
          )
        : Container(
            child: _isLoading
                ? Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: AppTheme.textColor,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _imageProvider!, fit: widget.fit),
                      borderRadius: widget.borderRadius ?? defaultRadius,
                    ),
                    child: widget.child,
                  ),
          );
  }
}
