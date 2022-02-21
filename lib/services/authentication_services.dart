import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pipgesp/main.dart';
import 'package:pipgesp/services/firestore_handler.dart';
import 'package:pipgesp/services/models/result.dart';
import 'package:pipgesp/services/utils/database_collections.dart';

class AuthenticationServices {
  static String emailAlreadyInUseMessage = 'Este email já está em uso';
  static String emailNotVerifiedCode = 'ERROR_EMAIL_NOT_VERIFIED';
  static String emailNotVerifiedMessage =
      'Verifique o código enviado para o seu email';
  static String userAlreadyRegisteredCode = 'ERROR_USER_ALREADY_REGISTERED';
  static String userAlreadyRegisteredMessage = 'Usuário já cadastrado';
  static String failedToCreateUserCode = 'ERROR_FAILED_TO_CREATE_USER';
  static String failedToCreateUserMessage = 'Falha ao criar usuário. Codigo: ';
  static String accCreatedVerifyEmailMessage =
      'Conta criada com sucesso. Verifique seu email e clique no link de confirmação';

  // static Future<DocumentSnapshot> isUserAuthenticated() async {
  //   DocumentSnapshot document;

  //   firebase_auth.User? firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;

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

  static Future<Result> emailSignUp({
    required String name,
    required String registration,
    required String raspberryIP,
    required String email,
    required String password,
  }) async {
    debugPrint("state: services");
    Result authResult = Result(status: false);

    debugPrint("Email: $email");

    try {
      firebase_auth.User? user = (await firebase_auth.FirebaseAuth.instance
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      await user!.sendEmailVerification();

      Map<String, dynamic> params = {
        'uid': user.uid,
        'name': name,
        'email': email,
        'registration': registration,
        'raspberryIP': raspberryIP,
        'gadgets': []
      };

      await FirestoreHandler.addDocument(
        collection: DatabaseCollections.users,
        identifier: email,
        params: params,
      );

      await firebase_auth.FirebaseAuth.instance.signOut();

      authResult.status = true;
      authResult.errorMessage = accCreatedVerifyEmailMessage;
      authResult.errorCode = '201';
      return authResult;
    } on PlatformException catch (error) {
      debugPrint(error.code);
      authResult.errorCode = error.code;
      authResult.errorMessage = error.message;
      authResult.status = false;
      return authResult;
    } on FirebaseException catch (error) {
      debugPrint(error.code);
      authResult.errorCode = error.code;
      if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        authResult.errorMessage = emailAlreadyInUseMessage;
      } else {
        authResult.errorMessage = error.message;
      }
      authResult.status = false;
      await firebase_auth.FirebaseAuth.instance.signOut();
      return authResult;
    } catch (e) {
      authResult.errorCode = "error.code";
      authResult.errorMessage = "error.message";
      authResult.status = false;
      return authResult;
    }
  }

  static Future<Result> emailSingIn(String? email, String? password) async {
    debugPrint("state: services");
    Result authResult = Result(status: false);

    debugPrint("Email: $email");

    try {
      firebase_auth.User? user =
          (await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      ))
              .user;

      //User.uid = user.uid;

      if (user!.emailVerified) {
        authResult.status = true;
      } else {
        authResult.status = false;
        authResult.errorCode = emailNotVerifiedCode;
        authResult.errorMessage = emailNotVerifiedMessage;
        await firebase_auth.FirebaseAuth.instance.signOut();
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
    } catch (error) {
      authResult.errorCode = "error.code";
      authResult.errorMessage = "error.message";
      authResult.status = false;
      return authResult;
    }
  }

  static Future<void> userLogout() async {
    debugPrint("state: services");
    await firebase_auth.FirebaseAuth.instance.signOut();
  }

  static Future<Result> sendVerificationEmail(
      {required String email, required String password}) async {
    debugPrint("state: services");
    Result authResult = Result(status: false);
    try {
      firebase_auth.User? user =
          (await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
              .user;
      //await Future.delayed(Duration(milliseconds: 1000));
      await user!.sendEmailVerification();
      authResult.status = true;
      authResult.errorCode = '200';
      authResult.errorMessage = accCreatedVerifyEmailMessage;
      await firebase_auth.FirebaseAuth.instance.signOut();

      return authResult;
    } on FirebaseException catch (error) {
      authResult.errorCode = error.code;
      authResult.errorMessage = error.message;
      authResult.status = false;
      return authResult;
    } catch (exception) {
      authResult.status = false;
      await firebase_auth.FirebaseAuth.instance.signOut();
      return authResult;
    }
  }

  static Future<Result> resetPassword({required String email}) async {
    debugPrint("state: services");
    Result authResult = Result(status: false);
    try {
      await firebase_auth.FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      authResult.status = true;
      return authResult;
    } on FirebaseException catch (error) {
      authResult.errorCode = error.code;
      authResult.errorMessage = error.message;
      authResult.status = false;
      return authResult;
    } catch (e) {
      authResult.status = false;
      authResult.errorMessage = e.toString();
      return authResult;
    }
  }
}
