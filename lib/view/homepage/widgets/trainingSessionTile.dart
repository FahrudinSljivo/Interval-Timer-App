import 'package:flutter/material.dart';
import 'package:interval_timer_app/models/trainingSessionModel.dart';
import 'package:interval_timer_app/utils/colors.dart';
import 'package:interval_timer_app/utils/sizeConfig.dart';
import 'package:interval_timer_app/utils/styles.dart';
import 'package:interval_timer_app/view/trainingSession/pages/trainingSession.dart';

///This is a widget we use on our homepage when we display different training sessions. When we fetch all the training sessions for the currently logged in user, we map each document's data into these tiles which we display in ListView widget
///on the HomePage.
class TrainingSessionTile extends StatelessWidget {
  final TrainingSessionModel tsm;

  TrainingSessionTile(
    this.tsm,
  );
  @override
  Widget build(BuildContext context) {
    ///After size config is initialized, we have Center widget with some padding and GestureDetector child (clickable component). Child of GestureDetector is LimitedBox widget which basically sizes itself to how much it needs based on its children's
    ///requirements. onTap method GestureDetector specifies where the screen navigates next - to the trainin session with provided training session parameters.
    ///Each tile consists of its title in one row and then in the next one number of rounds, training interval duration and break interval durations.
    SizeConfig().init(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal,
            right: SizeConfig.blockSizeHorizontal,
            top: SizeConfig.blockSizeVertical * 2),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TrainingSession(tsm)));
          },
          child: LimitedBox(
            child: Container(
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
                      right: SizeConfig.blockSizeHorizontal * 5,
                      top: SizeConfig.blockSizeVertical * 3,
                      bottom: SizeConfig.blockSizeVertical * 2,
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
                      ]),
                    ),
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
