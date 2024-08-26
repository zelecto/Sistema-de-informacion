import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';

class UpdateColors extends StatelessWidget {
  const UpdateColors({
    super.key,
    required this.selectedColor,
  });

  final ValueNotifier<Color> selectedColor;
  void onColorSelected(Color color) {
    selectedColor.value = color;
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.amber,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: colors.map((colorItem) {
            final isSelected = colorItem == selectedColor.value;
            return GestureDetector(
              onTap: () => onColorSelected(colorItem),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: ScreenSize.getWidth(context) * 0.08,
                decoration: BoxDecoration(
                  color: colorItem,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: Colors.black54,
                          width: 2,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
