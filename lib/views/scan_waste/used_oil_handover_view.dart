import 'package:image_picker/image_picker.dart';

import '../../export_all.dart';

/// Screen for "Used Oil Handover" – deposit used cooking oil and collect points.
/// Top section: light green with illustration; bottom: white with CTA.
/// Opens device camera, then image confirmation → form (with calendar for date).
class UsedOilHandoverView extends StatelessWidget {
  const UsedOilHandoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: _lightGreen,
        elevation: 0,
        leadingWidth: 80,
        leading:  IconButton(
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
              color: Colors.transparent,
              shape: OvalBorder(
                side: BorderSide(width: 1, color: const Color(0xFFC9C9C9)),
              ),
            ),
            child: Icon(Icons.arrow_back_ios, size: 18,),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Used Oil Handover',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Top section – light green with illustration
          Expanded(
            child: Container(
              width: double.infinity,
              color: _lightGreen,
              child: SafeArea(
                bottom: false,
                child: Image.asset(Assets.usedOilHandover),
              ),
            ),
          ),
          // Bottom section – white with text and button
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20
                    ),
                    child: Text(
                        'Deposit your used cooking oil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 29.49,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                  ),
                  16.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                        'Deposit your and collect points easily! Every time you drop off your trash',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w200,
                            height: 1.55,
                        ),
                    ),
                  ),
                  32.ph,
                  CustomButtonWidget(
                    label: 'Open Camera',
                    onPressed: _onOpenCamera,
                  ),
                  24.ph,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onOpenCamera() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (photo == null) return;
    if (!AppRouter.navKey.currentContext!.mounted) return;
    await AppRouter.push(UsedOilImageConfirmationView(imagePath: photo.path));
  }
}

const Color _lightGreen =  Color(0xFFE5FFF1);
