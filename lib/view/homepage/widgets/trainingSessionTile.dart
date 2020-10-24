import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/globals.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';
import 'package:interval_timer_app/viewModel/trainingSession/trainingSession.dart';

class TrainingSessionTile extends StatelessWidget {
  final TrainingSessionModel tsm;

  TrainingSessionTile(this.tsm);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ///To make this work smoothly, I had to comment out lines 577-580 in Dismissible class itself.
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal,
            right: SizeConfig.blockSizeHorizontal,
            top: SizeConfig.blockSizeVertical * 2),
        child: Dismissible(
          onDismissed: (direction) async {
            TrainingSession()
                .deleteTrainingSession(currentlySignedUser, tsm.id);
          },
          key: ValueKey(tsm.id),
          background: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 7),
                child: Icon(Icons.delete,
                    size: SizeConfig.safeBlockHorizontal * 7),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
              color: ternaryTheme,
            ),
          ),
          direction: DismissDirection.endToStart,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: SizeConfig.blockSizeVertical * 12,
              width: SizeConfig.blockSizeHorizontal * 95,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
                color: secondaryTheme,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 5,
                      top: SizeConfig.blockSizeVertical * 2,
                    ),
                    child: Text(
                      tsm.title,
                      style: HomePageStyles().tsTileTitle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 5,
                      top: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "Rounds: "),
                      TextSpan(
                          text: tsm.numberOfTrainingIntervals.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "     Training duration: "),
                      TextSpan(
                          text: tsm.trainingIntervalDuration.toString() + 's',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "     Rest duration: "),
                      TextSpan(
                          text: tsm.breakIntervalDuration.toString() + 's',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
