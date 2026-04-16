import 'enums.dart';

class AppConstant {
  AppConstant._();

  static UserType userType = UserType.customer;
}

/// Business sign-up: category dropdown (extend as needed).
const List<String> kBusinessSignupCategories = [
  'Restaurant',
  'Hotel & hospitality',
  'Catering',
  'Retail / grocery',
  'Food processing',
  'Manufacturing',
  'Other',
];
