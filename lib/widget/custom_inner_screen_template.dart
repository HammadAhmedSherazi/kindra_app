import '../../export_all.dart';

class CustomInnerScreenTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? actionButton;
  const CustomInnerScreenTemplate({
    super.key,
    required this.title,
    required this.child,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFC),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leadingWidth: 80,
        leading: IconButton(
          onPressed: () {
            AppRouter.back();
          },
          icon: Container(
            width: 40,
            height: 40,

            padding: EdgeInsets.only(
              left: 8,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(
                side: BorderSide(width: 1, color: const Color(0xFFC9C9C9)),
              ),
            ),
            child: Icon(Icons.arrow_back_ios, size: 18,),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [actionButton != null ? actionButton! : SizedBox.shrink()],
      ),
      body: child,
    );
  }
}
