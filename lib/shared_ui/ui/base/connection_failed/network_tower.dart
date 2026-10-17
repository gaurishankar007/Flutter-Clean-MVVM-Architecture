import 'package:clean_architecture/shared_ui/utils/screen_util/screen_util.dart';
import 'package:material_ui/material_ui.dart';

class const NetworkTower({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const deepPurple = Colors.deepPurple;
    const purpleAccent = Colors.purpleAccent;

    return Container(
      padding: .all(ScreenUtil.I.widthPart(8)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [deepPurple.withAlpha(19), purpleAccent.withAlpha(19)],
        ),
        shape: .circle,
      ),
      child: Container(
        padding: .all(ScreenUtil.I.widthPart(6.5)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [deepPurple.withAlpha(25), purpleAccent.withAlpha(25)],
          ),
          shape: .circle,
        ),
        child: Container(
          padding: .all(ScreenUtil.I.widthPart(5)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [deepPurple.withAlpha(32), purpleAccent.withAlpha(32)],
            ),
            shape: .circle,
          ),
          child: Container(
            height: ScreenUtil.I.widthPart(35),
            width: ScreenUtil.I.widthPart(35),
            decoration: BoxDecoration(
              shape: .circle,
              gradient: const LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [deepPurple, purpleAccent],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(51),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Icon(
              Icons.cell_tower_rounded,
              size: ScreenUtil.I.widthPart(25),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
