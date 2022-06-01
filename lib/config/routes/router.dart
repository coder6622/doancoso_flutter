// ignore_for_file: no_duplicate_case_values

import 'package:flutter/material.dart';

import 'package:student_app/modules/info_school/screen/info_school_page.dart';
import 'package:student_app/modules/map/screen/body_sheet.dart';
import 'package:student_app/modules/map/screen/description_page.dart';
import 'package:student_app/modules/map/screen/information_page.dart';
import 'package:student_app/modules/map/screen/overview_page.dart';
import 'package:student_app/modules/map/screen/photos_page.dart';

import 'package:student_app/modules/sign_in_sign_up/screen/sign_in_page.dart';

import 'package:student_app/modules/sign_in_sign_up/screen/sign_up_page.dart';
import 'package:student_app/modules/sign_in_sign_up/screen/verify_email_view.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/note_view.dart';

import 'package:student_app/widgets/stateless/error_page.dart';
import 'package:student_app/widgets/stateless/no_result.dart';

import '../../constants/constant.dart';
import '../../modules/map/screen/map_page.dart';

import '../../modules/welcome/screen/welcome_page.dart';
import '../../test_screen.dart';

class Routers {
  static Route<dynamic>? generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'TestScreen':
        {
          if (TEST) {
            return MaterialPageRoute(builder: (_) => TestScreen());
          }
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No router defined for ${settings.name}'),
                    ),
                  ));
        }

      /// router home
      case 'WelcomePage':
        {
          return MaterialPageRoute(builder: (_) => const WelcomePage());
        }
      /// router map
      case 'MapPage':
        {
          return MaterialPageRoute(builder: (_) => const MapPage());
        }
      case 'information':
        {
          return MaterialPageRoute(builder: (_) => const InformationPage());
        }
      case 'body-sheet':
        {
          return MaterialPageRoute(builder: (_) => BodySheet());
        }
      case 'overview':
        {
          return MaterialPageRoute(builder: (_) => const OverViewPage());
        }

      case 'photo':
        {
          return MaterialPageRoute(builder: (_) => const PhotosViewPage());
        }
      case 'description':
        {
          return MaterialPageRoute(builder: (_) => const DescriptionPage());
        }

      case 'InfoSchoolPage':
        {
          return MaterialPageRoute(builder: (_) => const InfoSchoolPage());
        }

      case 'SignInPage':
        {
          return MaterialPageRoute(builder: (_) => const SignInPage());
        }
      
      case 'NoteView':
        {
          return MaterialPageRoute(builder: (_) => const NotesView());
        }
      case 'SignUpPage':
        {
          return MaterialPageRoute(builder: (_) => SignUpPage());
        }
      case 'VerifyEmail':
        {
          return MaterialPageRoute(builder: (_) => const VerifyEmailView());
        }
   
      case 'Error':
        {
          return MaterialPageRoute(builder: (_) => const ErrorPage());
        }
      case 'NoResult':
        {
          return MaterialPageRoute(builder: (_) => const NoResult());
        }
      
      
      // case 'UserAccount':
      //   return MaterialPageRoute(builder: (_) => const UserAccount());
      // // case 'HotelDetail':
      // //   {
      // //     return MaterialPageRoute(builder: (_) => const HotelDetailsPage());
      // //   }
    }
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('No router defined for ${settings.name}'),
              ),
            ));
  }
}
