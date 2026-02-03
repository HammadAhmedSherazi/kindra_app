import '../../export_all.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  height: context.screenHeight * 0.33,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),

                  decoration: BoxDecoration(color: AppColors.primaryColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello \nFajar Firmansyah',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w500,
                                height: 1.65,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        padding: EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                        ),
                        child: Image.asset(Assets.notificationIcon),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    // shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      130.ph,
                      Text(
                        'Services Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      17.ph,
                      Container(
                        width: 371,
                        // height: 77,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFECEFF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 55,
                            height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF4C9A31),
                              shape: OvalBorder(),
                            ),
                            child: Image.asset(Assets.addLocationIcon),
                          ),
                          title: Text(
                            'Used Oil Collection Point.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Earn your points',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                      40.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'News',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.40),
                                fontSize: 16,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          height: 114,
                          child: Row(
                            spacing: 10,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8kvhwsPdeSIGSEvbktsxc_4pQpEqu4ykg4A&s",
                                  height: double.infinity,
                                  width: 114,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kindra Green Campaign: P...',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'Roboto Flex',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'In commemoration of Earth Day, Kindra launched  campaign by planting....',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black.withValues(
                                          alpha: 0.66,
                                        ),
                                        fontSize: 14,
                                        fontFamily: 'Roboto Flex',
                                        fontWeight: FontWeight.w300,
                                        height: 1.37,
                                      ),
                                    ),
                                    Row(
                                      spacing: 4,
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          color: Colors.black.withValues(
                                            alpha: 0.40,
                                          ),
                                          size: 18,
                                        ),
                                        Text(
                                          '20 Jun 2025',
                                          style: TextStyle(
                                            color: Colors.black.withValues(
                                            alpha: 0.40,
                                          ),
                                            fontSize: 14,
                                            fontFamily: 'Roboto Flex',
                                            fontWeight: FontWeight.w300,
                                            height: 1.14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
                        itemCount: 2,
                      ),
                      200.ph
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: context.screenHeight * 0.20,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              height: 221,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(23),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
