import '../../export_all.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _onboardingImages = [
    Assets.onBoarding1,
    Assets.onBoarding2,
    Assets.onBoarding3,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: _currentPage > 0 ? IconButton(
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          icon: Container(
            width: 32,
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(500),
                bottom: Radius.circular(500),
              ),
              color: const Color(0XFFEFEFEF),
            ),
            child: const Icon(Icons.arrow_back_ios, size: 15),
          ),
        ) : null,
        title: Image.asset(Assets.kindraTextLogo, width: 150, height: 70),
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingImages.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    _onboardingImages[index],
                    // fit: BoxFit.cover,
                    width: context.screenWidth * 0.80,
                  );
                },
              ),
            ),
            // Stepper indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingImages.length,
                (index) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentPage == index
                          ? AppColors.primaryColor
                          : const Color(0xFFD0D0D0),
                    ),
                  ),
                ),
              ),
            ),
            50.ph,
            Text(
              'Welcome to Kindra',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36.37,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Lorem Ipsum is simply dummy is the printing and typesetting industry.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w300,
                height: 1.65,
              ),
            ),
            70.ph,  
            // Bottom buttons
            if(_currentPage < _onboardingImages.length - 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtonWidget(
                  expandWidth: false,
                  backgroundColor: const Color(0xFF818180),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  label: "Skip", onPressed: () {
                     AppRouter.pushReplacement(const LoginView());
                  },),
                
                CustomButtonWidget(
                  expandWidth: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  label: "Next", onPressed: () {
                    if (_currentPage < _onboardingImages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } 
                  },)
              ],
            ),
            if(_currentPage == 2)
            CustomButtonWidget(
              label: 'Get Started',
              onPressed: () {
                 AppRouter.push(const LoginView());
              },
            ),
            60.ph
          ],
        ),
      ),
    );
  }
}
