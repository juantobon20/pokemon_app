import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/config/router/app_router_cubit/app_router_cubit.dart';
import 'package:pokemon_app/presentation/dialogs/dialog.dart';

import '../../blocs/bloc.dart';
import '../../widgets/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
      listener: (context, state) {
        if (state.errorData != null) {
          ErrorProvider(
            context: context, 
            errorData: state.errorData!, 
            onRetryPressed: () {}
          );
        } else if (state.navigateToHome) {
          context.read<AppRouterCubit>().checkAuthStatus();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                  
                        Image.asset(
                          'assets/images/pokemon_logo.png',
                          height: 120,
                        ),
                        const Spacer(),
                        
                        CustomTextFormField(
                          labelText: 'Usuario',
                          hintText: 'Ingrese usuario',
                          keyboardType: TextInputType.emailAddress,
                          errorText: state.isFormPosted ? state.email.errorMessage : null,
                          onChanged: context.read<LoginScreenBloc>().onEmailChanged,
                        ),
                        const SizedBox(height: 8),
                  
                        PasswordTextFormField(
                          labelText: 'Contraseña',
                          hintText: 'Ingrese contraseña',
                          errorText: state.isFormPosted ? state.password.errorMessage : null,
                          onChanged: context.read<LoginScreenBloc>().onPasswordChanged,
                        ),
                  
                        const SizedBox(height: 8),
                  
                        PrimaryButton(
                          text: 'Ingresar',
                          onPressedCallback: context.read<LoginScreenBloc>().onFormSubmit
                        ),
                  
                        const Spacer()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
