import '../../export_all.dart';

/// Business Profile tab with info card, QR Profile Card, Edit Profile and Log Out.
class BusinessProfileTab extends StatelessWidget {
  const BusinessProfileTab({super.key});

  static const String _businessName = 'Greentree Cafe';
  static const String _address = '123 st, Springfield, Lt';
  static const String _email = 'info@greentreecafe.com';
  static const String _phone = '(555) 123 4567';

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Business Profile',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBusinessInfoCard(context),
            16.ph,
            _buildQRProfileCard(context),
            24.ph,
            CustomButtonWidget(
              label: 'Edit Profile',
              onPressed: () => AppRouter.push(const BusinessEditProfileView()),
              variant: CustomButtonVariant.primary,
              height: 52,
            ),
            12.ph,
            CustomButtonWidget(
              label: 'Log Out',
              onPressed: () => showLogoutDialog(context),
              variant: CustomButtonVariant.secondary,
              backgroundColor: Colors.grey.shade400,
              height: 52,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(23),
       
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3,
        children: [
          Column(
            children: [
              Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: AssetImage(Assets.userAvatar),
                  ),
                  Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _businessName,
                  style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
                ),
                4.ph,
                Text(
                  _address,
                  style: context.robotoFlexMedium(
                    fontSize: 14,
                    
                  ),
                ),
               
              ],
            ),
          ),
        
                ],
              ),
            ],
          ),
           Divider(height: 24, thickness: 1, color: Colors.black.withValues(alpha: 0.3)),
                Row(
                 
                  children: [
                    10.pw,
                    Icon(Icons.email, size: 18, color: Colors.black),
                    8.pw,
                    Expanded(
                      child: Text(
                        _email,
                        style: context.robotoFlexRegular(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                3.ph,
                Row(
                  children: [
                     10.pw,
                    Icon(Icons.phone, size: 18, color: Colors.black),
                    8.pw,
                    Text(
                      _phone,
                      style: context.robotoFlexRegular(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
          ],
      ),
    );
  }

  Widget _buildQRProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'QR Profile Card',
            style: context.robotoFlexBold(fontSize: 24, color: Colors.black),
          ),
          // 10.ph,
          Icon(Icons.qr_code_2, size: 250, color: Colors.black87),
          // 12.ph,
          Text(
            'Kindra Friendly',
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          20.ph,
          CustomButtonWidget(
            label: 'View Certification',
            onPressed: () => AppRouter.push(const KindraFriendlyView()),
            variant: CustomButtonVariant.primary,
            height: 48,
          ),
          12.ph,
          CustomButtonWidget(
            label: 'Share Kindra Profile',
            onPressed: () {
              // TODO: share
            },
            variant: CustomButtonVariant.outlined,
            icon: Icon(Icons.share_outlined, size: 22, color: Colors.black87),
            borderColor: Colors.black87,
            textColor: Colors.black87,
            height: 48,
          ),
        ],
      ),
    );
  }
}
