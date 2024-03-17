import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pokemon_logo.png',
                  height: 120,
                ),
            
                const Spacer(),
            
                const CustomTextFormField(
                  labelText: 'Usuario',
                  hintText: 'Ingrese usuario',
                  keyboardType: TextInputType.emailAddress,
                ),
          
                const SizedBox(height: 8),
          
                const PasswordTextFormField(
                  labelText: 'Contraseña',
                  hintText: 'Ingrese contraseña',
                ),
          
                const SizedBox(height: 8),
          
                PrimaryButton(
                  text: 'Ingresar',
                  onPressedCallback: () {
                    context.push('/home');
                  },
                  radius: 10,
                ),
            
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
