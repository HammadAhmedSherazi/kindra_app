import '../../export_all.dart';

class CustomInnerScreenTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? actionButton;
  final bool showBackButton;
  const CustomInnerScreenTemplate({
    super.key,
    required this.title,
    required this.child,
    this.actionButton,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFC),
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: showBackButton,
        backgroundColor: Colors.transparent,
        leadingWidth: 80,
        leading: showBackButton ? IconButton(
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
        ) : null,
        centerTitle: true,
        title: SizedBox(
          width: context.screenWidth * 0.55,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions:actionButton != null? [ actionButton!, 15.pw] : null,
      ),
      body: child,
    );
  }
}
