import '../../export_all.dart';

class AllNewsView extends StatelessWidget {
  const AllNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'News',
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: demoNewsList.length,
        itemBuilder: (context, index) =>
            NewsItemWidget(news: demoNewsList[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ),
    );
  }
}