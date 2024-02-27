import "package:client/theme/color.dart";
import "package:flutter/material.dart";

class EmotionScoll extends StatefulWidget {
  @override
  _EmotionScollState createState() => _EmotionScollState();
}

class _EmotionScollState extends State<EmotionScoll> {
  String selectedEmotion = '';

  final List<String> emotionImages = [
    'Default',
    'Happy',
    'Excited',
    'Angry',
    'Sad',
    'Stress',
    'Tired'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
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
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    // Image widget
                    child: Image.asset(
                      'assets/emotion/emotion_text/m_${emotionImages[index]}_t.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  if (selectedEmotion == emotionImages[index])
                    Positioned(
                      child: Container(
                        width: 110,
                        height: 110,
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