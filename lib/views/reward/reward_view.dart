import '../../export_all.dart';

class RewardView extends StatelessWidget {
  const RewardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reward',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
            24.ph,
            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                label: 'View Points',
                onPressed: () => AppRouter.push(const PointsView()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}