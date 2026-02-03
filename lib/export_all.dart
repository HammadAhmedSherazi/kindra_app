// Packages
export 'package:flutter/material.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_svg/flutter_svg.dart';

// Data
export 'data/demo_news_list.dart';
export 'data/enums/api_status.dart';
export 'data/network/api_endpoints.dart';
export 'data/network/api_exceptions.dart';
export 'data/network/api_response.dart';
export 'data/network/http_client.dart';

// Models
export 'models/news_model.dart';
export 'models/user_data_model.dart';

// Providers
export 'providers/auth_provider/auth_provider.dart';
export 'providers/auth_provider/auth_state.dart';
export 'providers/navigation_provider/navigation_provider.dart';

// Services
export 'services/base_api_services.dart';
export 'services/secure_storage.dart';
export 'services/shared_preferences.dart';

// Utils
export 'utils/assets.dart';
export 'utils/colors.dart';
export 'utils/constant.dart';
export 'utils/enums.dart';
export 'utils/extension.dart';
export 'utils/helper.dart';
export 'utils/localization_service.dart';
export 'utils/router.dart';
export 'utils/theme.dart';

// Views
export 'views/auth/create_new_password_view.dart';
export 'views/auth/login_view.dart';
export 'views/auth/otp_verification_view.dart';
export 'views/auth/registration_view.dart';
export 'views/auth/reset_password_view.dart';
export 'views/home/home_view.dart';
export 'views/navigation/navigation_view.dart';
export 'views/onboarding/onboarding_view.dart';
export 'views/profile/profile_view.dart';
export 'views/reward/reward_view.dart';
export 'views/trainer/trainer_view.dart';
export 'views/home/all_news_view.dart';


// Widgets
export 'widget/back_button_widget.dart';
export 'widget/custom_back_arrow_widget.dart';
export 'widget/news_item_widget.dart';
export 'widget/custom_button_widget.dart';
export 'widget/custom_loading_widget.dart';
export 'widget/custom_text_field_widget.dart';
export 'widget/password_success_dialog.dart';
export 'widget/custom_inner_screen_template.dart';