import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pipgesp/main.dart';
import 'package:pipgesp/repository/models/user.dart';
import 'package:pipgesp/services/models/authentication_result.dart';
import 'package:http/http.dart' as http;
import 'package:pipgesp/utils/app_urls.dart';

class AuthenticationServices {
  static String urlEndPoint = AppUrls.endPoint;

  static String emailAlreadyInUseMessage = 'Este email já está em uso';
  static String emailNotVerifiedCode = 'ERROR_EMAIL_NOT_VERIFIED';
  static String emailNotVerifiedMessage =
      'Verifique o código enviado para o seu email';
  // static String userAlreadyRegisteredCode = 'ERROR_USER_ALREADY_REGISTERED';
  // static String userAlreadyRegisteredMessage = 'Usuário já cadastrado';
  static String userAlreadyRegisteredCode = 'ERROR_USER_ALREADY_REGISTERED';
  static String userAlreadyRegisteredMessage =
      'Data conflict when creating user';
  static String failedToCreateUserCode = 'ERROR_FAILED_TO_CREATE_USER';
  static String failedToCreateUserMessage = 'Falha ao criar usuário. Codigo: ';
  static String accCreatedVerifyEmailMessage =
      'Conta criada com sucesso. Verifique seu email e clique no link de confirmação';

  // static User _userToResendEmail;

  // static Future<DocumentSnapshot> isUserAuthenticated() async {
  //   DocumentSnapshot document;

  //   firebaseAuth.User? firebaseUser = firebaseAuth.FirebaseAuth.instance.currentUser;

  //   if (firebaseUser == null) {
  //     return null;
  //   } else {
  //     User.uid = firebaseUser.uid;
  //     print(User.uid);
  //     // TODO: fix exception in this line
  //     //document = await FirestoreHandler.getUser(departamento: User.departamento, empresa: User.empresa);
  //   }

  //   return document;
  // }

  // static Future<AuthenticationResult> createUserOnDatabase({
  //   required String name,
  //   required String registration,
  //   required String email,
  //   required String uid,
  //   required String phoneID,
  // }) async {
  //   AuthenticationResult authResult = AuthenticationResult(status: false);
  //   String url = urlEndPoint + "/user";
  //   bool active = true;
  //   int points = 0;
  //   int totalPoints = 0;
  //   String body = '''
  //   {
  //     "name": "$name",
  //     "registration": "$registration",
  //     "email": "$email",
  //     "uid": "$uid",
  //     "active":  $active,
  //     "points":  $points,
  //     "totalPoints": $totalPoints,
  //     "phoneID": "$phoneID"

  //   }
  //    ''';
  //   Map<String, String> headers = new Map<String, String>();
  //   headers["Content-type"] = "application/json";
  //   try {
  //     http.Response response =
  //         await http.post(url, body: body, headers: headers);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print(response.body);
  //       authResult.status = true;
  //       authResult.errorMessage = response.body;
  //       authResult.errorCode = response.statusCode.toString();
  //     } else {
  //       authResult.status = false;
  //       authResult.errorMessage = response.body;
  //       authResult.errorCode = response.statusCode.toString();
  //     }
  //     return authResult;
  //   } catch (exception) {
  //     authResult.status = false;
  //     authResult.errorCode = failedToCreateUserCode;
  //     authResult.errorMessage =
  //         failedToCreateUserMessage + exception.toString();
  //     return authResult;
  //   }
  // }

  ///Atualiza as informações do usuário [displayName]
  // static void _updateUserInfo(User user) async {
  //   UserUpdateInfo updateInfo = UserUpdateInfo();
  //   updateInfo.displayName = User.displayName;
  //   await user.updateProfile(updateInfo);
  // }

  // static Future<AuthenticationResult> emailSignUp({
  //   @required String name,
  //   @required String registration,
  //   @required String email,
  //   @required String password,
  //   @required String phoneID,
  // }) async {
  //   AuthenticationResult authResult = AuthenticationResult();

  //   try {
  //     User user =
  //         (await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     ))
  //             .user;
  //     await user.sendEmailVerification();
  //     authResult = await createUserOnDatabase(
  //         name: name,
  //         registration: registration,
  //         email: email,
  //         uid: user.uid,
  //         phoneID: phoneID);
  //     if (authResult.status) {
  //       authResult.errorMessage = accCreatedVerifyEmailMessage;
  //     } else {
  //       user.delete();
  //     }
  //     await FirebaseAuth.instance.signOut();

  //     return authResult;
  //   } catch (error) {
  //     print(error.code);
  //     authResult.errorCode = error.code;
  //     if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE')
  //       authResult.errorMessage = emailAlreadyInUseMessage;
  //     else
  //       authResult.errorMessage = error.message;
  //     authResult.status = false;
  //     await FirebaseAuth.instance.signOut();
  //     return authResult;
  //   }
  // }

  static Future<AuthenticationResult> emailSingIn(
      String? email, String? password) async {
    AuthenticationResult authResult = AuthenticationResult(status: false);

    debugPrint("Email: $email");

    try {
      firebaseAuth.User? user =
          (await firebaseAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      ))
              .user;

      //User.uid = user.uid;

      if (user!.emailVerified || true) {
        authResult.status = true;
      } else {
        authResult.status = false;
        authResult.errorCode = emailNotVerifiedCode;
        authResult.errorMessage = emailNotVerifiedMessage;
        await firebaseAuth.FirebaseAuth.instance.signOut();
      }

      return authResult;
    } on PlatformException catch (error) {
      authResult.errorCode = error.code;
      authResult.errorMessage = error.message;
      authResult.status = false;
      return authResult;
    } on FirebaseException catch (error) {
      authResult.errorCode = error.code;
      authResult.errorMessage = error.message;
      authResult.status = false;
      return authResult;
    } catch (error){
      authResult.errorCode = "error.code";
      authResult.errorMessage = "error.message";
      authResult.status = false;
      return authResult;
    }
  }

  static Future<void> userLogout() async {
    await firebaseAuth.FirebaseAuth.instance.signOut();

    main();
  }

  // static Future<void> resendVerificationEmail() async {
  //   try {
  //     await _userToResendEmail.sendEmailVerification();
  //   } catch (exception) {
  //     print(exception.message);
  //     return exception;
  //   }
  // }

  // static Future<AuthenticationResult> sendVerificationEmail(
  //     {@required String email, @required String password}) async {
  //   AuthenticationResult authResult = AuthenticationResult();
  //   try {
  //     User user =
  //         (await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     ))
  //             .user;
  //     await Future.delayed(Duration(milliseconds: 1000));
  //     await user.sendEmailVerification();
  //     authResult.status = true;
  //     authResult.errorCode = '200';
  //     authResult.errorMessage = accCreatedVerifyEmailMessage;
  //     await FirebaseAuth.instance.signOut();

  //     return authResult;
  //   } catch (exception) {
  //     print(exception.message);
  //     authResult.errorCode = exception.code;
  //     authResult.errorMessage = exception.message;
  //     authResult.status = false;
  //     await FirebaseAuth.instance.signOut();
  //     return authResult;
  //   }
  // }

  // static Future<AuthenticationResult> resetPassword(
  //     {@required String email}) async {
  //   AuthenticationResult authResult = AuthenticationResult();
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //     authResult.status = true;
  //     return authResult;
  //   } catch (e) {
  //     authResult.status = false;
  //     authResult.errorCode = e.code;
  //     authResult.errorMessage = e.toString();
  //     return authResult;
  //   }
  // }
}
