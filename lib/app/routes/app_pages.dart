import 'package:get/get.dart';
import 'package:power_maids/app/modules/TermsAndConditions/bindings/terms_and_conditions_binding.dart';
import 'package:power_maids/app/modules/TermsAndConditions/views/terms_and_conditions_view.dart';

import '../modules/AddPropertyScreen/bindings/add_property_screen_binding.dart';
import '../modules/AddPropertyScreen/views/add_property_screen_view.dart';
import '../modules/AddRequirementCleaner/bindings/add_requirement_cleaner_binding.dart';
import '../modules/AddRequirementCleaner/views/add_requirement_cleaner_view.dart';
import '../modules/AddRequirementCleanerSummery/bindings/add_requirement_cleaner_summery_binding.dart';
import '../modules/AddRequirementCleanerSummery/views/add_requirement_cleaner_summery_view.dart';
import '../modules/AddRequirementCreateBid/bindings/add_requirement_create_bid_binding.dart';
import '../modules/AddRequirementCreateBid/views/add_requirement_create_bid_view.dart';
import '../modules/AudioCall/bindings/audio_call_binding.dart';
import '../modules/AudioCall/views/audio_call_view.dart';
import '../modules/BidSummary/bindings/bid_summary_binding.dart';
import '../modules/BidSummary/views/bid_summary_view.dart';
import '../modules/BiderDetailScreen/bindings/bider_detail_screen_binding.dart';
import '../modules/BiderDetailScreen/views/bider_detail_screen_view.dart';
import '../modules/BlogsDetailsScreen/bindings/blogs_details_binding.dart';
import '../modules/BlogsDetailsScreen/views/blogs_details_view.dart';
import '../modules/BlogsScreen/bindings/blogs_binding.dart';
import '../modules/BlogsScreen/views/blogs_view.dart';
import '../modules/BookAppointment/bindings/book_appointment_binding.dart';
import '../modules/BookAppointment/views/book_appointment_view.dart';
import '../modules/BookingDetail/bindings/booking_detail_binding.dart';
import '../modules/BookingDetail/views/booking_detail_view.dart';
import '../modules/BookingScreen/bindings/booking_screen_binding.dart';
import '../modules/BookingScreen/views/booking_screen_view.dart';
import '../modules/BookingSummary/bindings/booking_summary_binding.dart';
import '../modules/BookingSummary/views/booking_summary_view.dart';
import '../modules/ChangePassword/bindings/change_password_binding.dart';
import '../modules/ChangePassword/views/change_password_view.dart';
import '../modules/ChatBodScreen/bindings/chat_bod_screen_binding.dart';
import '../modules/ChatBodScreen/views/chat_bod_screen_view.dart';
import '../modules/ChatBodVerify/bindings/chat_bod_verify_binding.dart';
import '../modules/ChatBodVerify/views/chat_bod_verify_view.dart';
import '../modules/ChatList/bindings/chat_list_binding.dart';
import '../modules/ChatList/views/chat_list_view.dart';
import '../modules/ChatScreen/bindings/chat_screen_binding.dart';
import '../modules/ChatScreen/views/chat_screen_view.dart';
import '../modules/ChatbootverifyOtp/bindings/chatbootverify_otp_binding.dart';
import '../modules/ChatbootverifyOtp/views/chatbootverify_otp_view.dart';
import '../modules/CleanerAndCo_hostList/bindings/cleaner_co_hostlist_binding.dart';
import '../modules/CleanerAndCo_hostList/views/cleaner_co_hostlist_view.dart';
import '../modules/CleanerBidsList/bindings/cleaner_bids_list_binding.dart';
import '../modules/CleanerBidsList/views/cleaner_bids_list_view.dart';
import '../modules/CongratsScreen/bindings/congrats_screen_binding.dart';
import '../modules/CongratsScreen/views/congrats_screen_view.dart';
import '../modules/ConnectivityScreen/bindings/connectivity_screen_binding.dart';
import '../modules/ConnectivityScreen/views/connectivity_screen_view.dart';
import '../modules/CreateBidForCleanerAndCohost/bindings/create_bid_for_cleaner_and_cohost_binding.dart';
import '../modules/CreateBidForCleanerAndCohost/views/create_bid_for_cleaner_and_cohost_view.dart';
import '../modules/CreateBidSummary/bindings/create_bid_summary_binding.dart';
import '../modules/CreateBidSummary/views/create_bid_summary_view.dart';
import '../modules/CustomerInformation/bindings/customer_information_binding.dart';
import '../modules/CustomerInformation/views/customer_information_view.dart';
import '../modules/Deshboard/bindings/deshboard_binding.dart';
import '../modules/Deshboard/views/deshboard_view.dart';
import '../modules/EditProfile/bindings/edit_profile_binding.dart';
import '../modules/EditProfile/views/edit_profile_view.dart';
import '../modules/ExtraworkAddScreen/bindings/extrawork_add_screen_binding.dart';
import '../modules/ExtraworkAddScreen/views/extrawork_add_screen_view.dart';
import '../modules/FilterScreen/bindings/filter_screen_binding.dart';
import '../modules/FilterScreen/views/filter_screen_view.dart';
import '../modules/ForgotPassword/bindings/forgot_password_binding.dart';
import '../modules/ForgotPassword/views/forgot_password_view.dart';
import '../modules/HelpScreen/bindings/help_screen_binding.dart';
import '../modules/HelpScreen/views/help_screen_view.dart';
import '../modules/HomeScreen/bindings/home_screen_binding.dart';
import '../modules/HomeScreen/views/home_screen_view.dart';
import '../modules/LocationScreen/bindings/location_screen_binding.dart';
import '../modules/LocationScreen/views/location_screen_view.dart';
import '../modules/MaidDetails/bindings/maid_details_binding.dart';
import '../modules/MaidDetails/views/maid_details_view.dart';
import '../modules/MakeAccountWithScreen/bindings/make_account_with_screen_binding.dart';
import '../modules/MakeAccountWithScreen/views/make_account_with_screen_view.dart';
import '../modules/MyFavourite/bindings/my_favourite_binding.dart';
import '../modules/MyFavourite/views/my_favourite_view.dart';
import '../modules/NewCleanerBidsList/bindings/new_cleaner_bids_list_binding.dart';
import '../modules/NewCleanerBidsList/views/new_cleaner_bids_list_view.dart';
import '../modules/NotificationDetails/bindings/notification_details_binding.dart';
import '../modules/NotificationDetails/views/notification_details_view.dart';
import '../modules/NotificationScreen/bindings/notification_screen_binding.dart';
import '../modules/NotificationScreen/views/notification_screen_view.dart';
import '../modules/PaymentSuccessfulScreen/bindings/payment_successful_screen_binding.dart';
import '../modules/PaymentSuccessfulScreen/views/payment_successful_screen_view.dart';
import '../modules/PhotoViewMaidDetails/bindings/photo_view_maid_details_binding.dart';
import '../modules/PhotoViewMaidDetails/views/photo_view_maid_details_view.dart';
import '../modules/ProfileScreen/bindings/profile_screen_binding.dart';
import '../modules/ProfileScreen/views/profile_screen_view.dart';
import '../modules/RecommendedViewAll/bindings/recommended_view_all_binding.dart';
import '../modules/RecommendedViewAll/views/recommended_view_all_view.dart';
import '../modules/ResetChangePassword/bindings/reset_change_password_binding.dart';
import '../modules/ResetChangePassword/views/reset_change_password_view.dart';
import '../modules/ResetPassword/bindings/reset_password_binding.dart';
import '../modules/ResetPassword/views/reset_password_view.dart';
import '../modules/ReviewBookingDetail/bindings/review_booking_detail_binding.dart';
import '../modules/ReviewBookingDetail/views/review_booking_detail_view.dart';
import '../modules/SavedCard/bindings/saved_card_binding.dart';
import '../modules/SavedCard/views/saved_card_view.dart';
import '../modules/SearchCleaners/bindings/search_cleaners_binding.dart';
import '../modules/SearchCleaners/views/search_cleaners_view.dart';
import '../modules/SelectServices/bindings/select_services_binding.dart';
import '../modules/SelectServices/views/select_services_view.dart';
import '../modules/SignIn/bindings/sign_in_binding.dart';
import '../modules/SignIn/views/sign_in_view.dart';
import '../modules/SignUp/bindings/sign_up_binding.dart';
import '../modules/SignUp/views/sign_up_view.dart';
import '../modules/SignUpBasicDetailsScreen/bindings/sign_up_basic_details_screen_binding.dart';
import '../modules/SignUpBasicDetailsScreen/views/sign_up_basic_details_screen_view.dart';
import '../modules/SignUpVerifyOtp/bindings/sign_up_verify_otp_binding.dart';
import '../modules/SignUpVerifyOtp/views/sign_up_verify_otp_view.dart';
import '../modules/Splash/bindings/splash_binding.dart';
import '../modules/Splash/views/splash_view.dart';
import '../modules/TrackYourcleanerScreen/bindings/track_yourcleaner_screen_binding.dart';
import '../modules/TrackYourcleanerScreen/views/track_yourcleaner_screen_view.dart';
import '../modules/VericationOtp/bindings/verication_otp_binding.dart';
import '../modules/VericationOtp/views/verication_otp_view.dart';
import '../modules/VerifyChangePassword/bindings/verify_change_password_binding.dart';
import '../modules/VerifyChangePassword/views/verify_change_password_view.dart';
import '../modules/VideoCall/bindings/video_call_binding.dart';
import '../modules/VideoCall/views/video_call_view.dart';
import '../modules/Wallet/bindings/wallet_binding.dart';
import '../modules/Wallet/views/wallet_view.dart';
import '../modules/WellcomeScreen/bindings/wellcome_screen_binding.dart';
import '../modules/WellcomeScreen/views/wellcome_screen_view.dart';
import '../modules/writereview/bindings/writereview_binding.dart';
import '../modules/writereview/views/writereview_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WELLCOME_SCREEN,
      page: () => const WellcomeScreenView(),
      binding: WellcomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERICATION_OTP,
      page: () => const VericationOtpView(),
      binding: VericationOtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DESHBOARD,
      page: () => const DeshboardView(),
      binding: DeshboardBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => const ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SCREEN,
      page: () => const BookingScreenView(),
      binding: BookingScreenBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      page: () => const NotificationScreenView(),
      binding: NotificationScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileScreenView(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_DETAILS,
      page: () => const NotificationDetailsView(),
      binding: NotificationDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.MAID_DETAILS,
      page: () => const MaidDetailsView(),
      binding: MaidDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_APPOINTMENT,
      page: () => const BookAppointmentView(),
      binding: BookAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_INFORMATION,
      page: () => const CustomerInformationView(),
      binding: CustomerInformationBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_BOOKING_DETAIL,
      page: () => const ReviewBookingDetailView(),
      binding: ReviewBookingDetailBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SUMMARY,
      page: () => const BookingSummaryView(),
      binding: BookingSummaryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_LIST,
      page: () => const ChatListView(),
      binding: ChatListBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_SCREEN,
      page: () => const LocationScreenView(),
      binding: LocationScreenBinding(),
    ),
    GetPage(
      name: _Paths.CLEANER_BIDS_LIST,
      page: () => const CleanerBidsListView(),
      binding: CleanerBidsListBinding(),
    ),
    GetPage(
      name: _Paths.NEW_CLEANER_BIDS_LIST,
      page: () => const NewCleanerBidsListView(),
      binding: NewCleanerBidsListBinding(),
    ),
    GetPage(
      name: _Paths.BIDER_DETAIL_SCREEN,
      page: () => const BiderDetailScreenView(),
      binding: BiderDetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_BASIC_DETAILS_SCREEN,
      page: () => const SignUpBasicDetailsScreenView(),
      binding: SignUpBasicDetailsScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_ACCOUNT_WITH_SCREEN,
      page: () => const MakeAccountWithScreenView(),
      binding: MakeAccountWithScreenBinding(),
    ),
    GetPage(
      name: _Paths.CONGRATS_SCREEN,
      page: () => const CongratsScreenView(),
      binding: CongratsScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_VERIFY_OTP,
      page: () => const SignUpVerifyOtpView(),
      binding: SignUpVerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BID_SUMMARY,
      page: () => const CreateBidSummaryView(),
      binding: CreateBidSummaryBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SCREEN,
      page: () => const HelpScreenView(),
      binding: HelpScreenBinding(),
    ),
    GetPage(
      name: _Paths.MY_FAVOURITE,
      page: () => const MyFavouriteView(),
      binding: MyFavouriteBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_CHANGE_PASSWORD,
      page: () => const VerifyChangePasswordView(),
      binding: VerifyChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_CHANGE_PASSWORD,
      page: () => const ResetChangePasswordView(),
      binding: ResetChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SAVED_CARD,
      page: () => const SavedCardView(),
      binding: SavedCardBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_BOD_SCREEN,
      page: () => const ChatBodScreenView(),
      binding: ChatBodScreenBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_BOD_VERIFY,
      page: () => const ChatBodVerifyView(),
      binding: ChatBodVerifyBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOOTVERIFY_OTP,
      page: () => const ChatbootverifyOtpView(),
      binding: ChatbootverifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESSFUL_SCREEN,
      page: () => const PaymentSuccessfulScreenView(),
      binding: PaymentSuccessfulScreenBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => const FilterScreenView(),
      binding: FilterScreenBinding(),
    ),
    GetPage(
      name: _Paths.RECOMMENDED_VIEW_ALL,
      page: () => const RecommendedViewAllView(),
      binding: RecommendedViewAllBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_CLEANERS,
      page: () => const SearchCleanersView(),
      binding: SearchCleanersBinding(),
    ),
    GetPage(
      name: _Paths.EXTRAWORK_ADD_SCREEN,
      page: () => const ExtraworkAddScreenView(),
      binding: ExtraworkAddScreenBinding(),
    ),
    GetPage(
      name: _Paths.TRACK_YOURCLEANER_SCREEN,
      page: () => const TrackYourcleanerScreenView(),
      binding: TrackYourcleanerScreenBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_SERVICES,
      page: () => const SelectServicesView(),
      binding: SelectServicesBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAIL,
      page: () => const BookingDetailView(),
      binding: BookingDetailBinding(),
    ),
    GetPage(
      name: _Paths.CLEANER_And_Cohost_LIST,
      page: () => const CleanerAndCoHostListView(),
      binding: CleanerAndCoHostListBinding(),
    ),
    GetPage(
      name: _Paths.PHOTO_VIEW_MAID_DETAILS,
      page: () => PhotoViewMaidDetailsView(),
      binding: PhotoViewMaidDetailsBinding(),
    ),

    GetPage(
      name: _Paths.ADD_PROPERTY_SCREEN,
      page: () => const AddPropertyScreenView(),
      binding: AddPropertyScreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BID_FOR_CLEANER_AND_COHOST,
      page: () => const CreateBidForCleanerAndCohostView(),
      binding: CreateBidForCleanerAndCohostBinding(),
    ),
    GetPage(
      name: _Paths.ADD_REQUIREMENT_CLEANER,
      page: () => const AddRequirementCleanerView(),
      binding: AddRequirementCleanerBinding(),
    ),
    GetPage(
      name: _Paths.ADD_REQUIREMENT_CREATE_BID,
      page: () => const AddRequirementCreateBidView(),
      binding: AddRequirementCreateBidBinding(),
    ),
    GetPage(
      name: _Paths.ADD_REQUIREMENT_CLEANER_SUMMERY,
      page: () => const AddRequirementCleanerSummeryView(),
      binding: AddRequirementCleanerSummeryBinding(),
    ),
    GetPage(
      name: _Paths.WRITEREVIEW,
      page: () => const WritereviewView(),
      binding: WritereviewBinding(),
    ),
    GetPage(
      name: _Paths.BLOGSDETAILS,
      page: () => const BlogsDetailsView(),
      binding: BlogsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BLOGSSCREEN,
      page: () => const BlogsView(),
      binding: BlogsBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => const VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_CALL,
      page: () => AudioCallView(),
      binding: AudioCallBinding(),
    ),
    GetPage(
      name: _Paths.BIDSUMMARYBOOKING,
      page: () => BidSummaryView(),
      binding: BidSummaryBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTIVITY_SCREEN,
      page: () => const ConnectivityScreenView(),
      binding: ConnectivityScreenBinding(),
    ),

    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),

  ];
}
