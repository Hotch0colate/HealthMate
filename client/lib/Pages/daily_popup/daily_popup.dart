import 'package:client/component/buttons.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';


class SelectEmotionPage extends StatelessWidget {
  const SelectEmotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Image.asset('assets/logos/medium_app_name.png'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              'อารมณ์ของคุณเป็นยังไง?',
              style: FontTheme.subtitle1,
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: CardPage(),
            ),
            SizedBox(height: 20.0),
            SmPrimaryButton(
              text: 'ส่งอารมณ์', 
              onPressed: (){})
          ],
        ),
      ),
    );
  }
}

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int selectedCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: List.generate(
        cardData.length,
        (index) => CardWidget(
          index: index,
          imageAsset: cardData[index]['imageAsset'],
          shadowColor: cardData[index]['shadowColor'],
          isSelected: selectedCardIndex == index,
          onTap: () {
            setState(() {
              if (selectedCardIndex == index) {
                // If the selected card is tapped again, unselect it
                selectedCardIndex = -1;
              } else {
                selectedCardIndex = index;
              }
            });
          },
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int index;
  final String imageAsset;
  final Color shadowColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CardWidget({
    required this.index,
    required this.imageAsset,
    required this.shadowColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: ColorTheme.WhiteColor, // Set splashColor to transparent
      child: Card(
        color: ColorTheme.WhiteColor,
        elevation: isSelected ? 0.0 : 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(isSelected ? 0.2 : 0.0),
                offset: Offset(0, isSelected ? 4.0 : 2.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(imageAsset),
          ),
        ),
      ),
    );
  }
}



final List<Map<String, dynamic>> cardData = [
  {'imageAsset': 'assets/emotion/emotion_text/m_Happy_t.png', 'shadowColor': Colors.yellow},
  {'imageAsset': 'assets/emotion/emotion_text/m_Excited_t.png', 'shadowColor': Colors.pink},
  {'imageAsset': 'assets/emotion/emotion_text/m_Tired_t.png', 'shadowColor': Colors.greenAccent},
  {'imageAsset': 'assets/emotion/emotion_text/m_Angry_t.png', 'shadowColor': Colors.red},
  {'imageAsset': 'assets/emotion/emotion_text/m_Sad_t.png', 'shadowColor': Colors.blue},
  {'imageAsset': 'assets/emotion/emotion_text/m_Stress_t.png', 'shadowColor': Colors.purpleAccent},
];