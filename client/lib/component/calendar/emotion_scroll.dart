import "package:client/theme/color.dart";
import "package:flutter/material.dart";

class EmotionScroll extends StatefulWidget {
  final Function(String) onEmotionSelected;

  EmotionScroll({Key? key, required this.onEmotionSelected}) : super(key: key);

  @override
  _EmotionScrollState createState() => _EmotionScrollState();
}

class _EmotionScrollState extends State<EmotionScroll> {
  String selectedEmotion = '';

  final List<String> emotionImages = [
    'Happy',
    'Excited',
    'Angry',
    'Sad',
    'Stress',
    'Tired'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      // Horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: emotionImages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedEmotion = emotionImages[index];
              });
              widget.onEmotionSelected(selectedEmotion);
            },
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/emotion/emotion_text/m_${emotionImages[index]}_t.png',
                    height: 120,
                    width: 120,
                  ),
                  if (selectedEmotion == emotionImages[index])
                    Positioned(
                      child: Container(
                        width: 110,
                        height: 110, // Set the width and height to be the same
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorTheme.primaryColor,
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
