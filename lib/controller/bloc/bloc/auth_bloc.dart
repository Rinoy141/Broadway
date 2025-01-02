// import 'package:broadway/controller/apis/api_service.dart';
// import 'package:broadway/controller/bloc/bloc/auth_event.dart';
// import 'package:broadway/controller/bloc/bloc/auth_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;

//   AuthBloc(this.authService) : super(AuthInitial()) {
//     on<RegisterUserEvent>(_registerUser);
//     on<LoginUserEvent>(_loginUser);
//   }


//   Future<void> _registerUser(
//       RegisterUserEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     try {
//       final response = await authService.registerUser(
//         email: event.email,
//         phoneNumber: event.phoneNumber,
//         username: event.username,
//         password: event.password,
//       );

//       if (response['success'] == true) {
//         emit(AuthSuccess(response['msg']));
//       } else {
//         emit(AuthFailure(response['msg']));
//       }
//     } catch (error) {
//       emit(AuthFailure(error.toString()));
//     }
//   }


//   Future<void> _loginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     try {
//       final response = await authService.loginUser(
//         email: event.email,
//         password: event.password,
//       );

//       if (response['success'] == true) {
//         emit(AuthSuccess(response['msg']));
//       } else {
//         emit(AuthFailure(response['msg']));
//       }
//     } catch (error) {
//       emit(AuthFailure(error.toString()));
//     }
//   }
// }
