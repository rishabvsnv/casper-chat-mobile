import 'package:flutter/material.dart';

class LocalVideoPreview extends StatefulWidget {
  final bool isPaused;
  final VoidCallback onPauseToggle;

  const LocalVideoPreview({
    super.key,
    required this.isPaused,
    required this.onPauseToggle,
  });

  @override
  State<LocalVideoPreview> createState() => _LocalVideoPreviewState();
}

class _LocalVideoPreviewState extends State<LocalVideoPreview> {
  double previewTop = 24;
  double previewLeft = 20;

  static const double previewWidth = 110;
  static const double previewHeight = 100;

  void _snapToNearestCorner(Size size) {
    final corners = [
      const Offset(20, 24),
      Offset(size.width - previewWidth - 20, 24),
      Offset(20, size.height - previewHeight - 140),
      Offset(size.width - previewWidth - 20, size.height - previewHeight - 140),
    ];

    final current = Offset(previewLeft, previewTop);

    Offset nearest = corners.first;
    double minDistance = double.infinity;

    for (final corner in corners) {
      final distance = (current - corner).distance;

      if (distance < minDistance) {
        minDistance = distance;
        nearest = corner;
      }
    }

    setState(() {
      previewLeft = nearest.dx;
      previewTop = nearest.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      top: previewTop,
      left: previewLeft,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            previewLeft += details.delta.dx;
            previewTop += details.delta.dy;
          });
        },
        onPanEnd: (_) {
          _snapToNearestCorner(MediaQuery.of(context).size);
        },
        child: Container(
          width: 110,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withValues(alpha: .35),
            border: Border.all(color: Colors.white.withValues(alpha: .15)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(color: Colors.black26),

                Center(
                  child: Image.network(
                    'https://picsum.photos/600/950',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'You',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: widget.onPauseToggle,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.isPaused
                            ? Icons.play_arrow_rounded
                            : Icons.pause_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
