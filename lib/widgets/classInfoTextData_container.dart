import 'package:flutter/material.dart';

class ClassInfoTextDataContainer extends StatelessWidget {
  const ClassInfoTextDataContainer({
    Key? key,
    required this.thisTimeData,
    required this.nextTimeData,
    required this.currentIndex,
    required this.needBottomBorder,
    this.width,
  }) : super(key: key);

  final String thisTimeData;
  final String nextTimeData;
  final int currentIndex;
  final bool needBottomBorder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      decoration: needBottomBorder
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.brown,
                ),
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: DisplayClassCrossFadeText(
            thisTimeData: thisTimeData,
            nextTimeData: nextTimeData,
            currentIndex: currentIndex),
      ),
    );
  }
}

//currentIndexに応じて、今の講義か次の講義のどちらのテキスト情報を表示するか変える。
//切り替え時にはアニメーションで切り替わる。
class DisplayClassCrossFadeText extends StatelessWidget {
  const DisplayClassCrossFadeText({
    Key? key,
    required this.thisTimeData,
    required this.nextTimeData,
    required this.currentIndex,
  }) : super(key: key);

  final String thisTimeData;
  final String nextTimeData;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.brown,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return AnimatedCrossFade(
      firstChild: Text(
        thisTimeData,
        style: textStyle,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
      secondChild: Text(
        nextTimeData,
        style: textStyle,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
      crossFadeState: currentIndex == 0
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
    );
  }
}
