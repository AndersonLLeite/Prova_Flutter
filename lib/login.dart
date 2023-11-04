import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prova_flutter/ui/styles/button_styles.dart';
import 'package:prova_flutter/ui/styles/colors_app.dart';
import 'package:prova_flutter/ui/styles/text_styles.dart';
import 'package:prova_flutter/ui/widgets/button.dart';
import 'package:validatorless/validatorless.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final usernameEC = TextEditingController();

  final passwordEC = TextEditingController();

  final Uri _url = Uri.parse('https://google.com.br');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void dispose() {
    usernameEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colors.primary,
                context.colors.secondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        (MediaQuery.of(context).size.width > 350 ? .30 : .25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 33, bottom: 5),
                    child: Text('Usuário',
                        style: context.textStyles.labelTextField),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                        controller: usernameEC,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Obrigatório'),
                          Validatorless.max(
                              20, 'Deve conter no máximo 20 caracteres'),
                          (value) {
                            if (value!.isNotEmpty &&
                                RegExp(r'\s$').hasMatch(value)) {
                              return 'Último caractere não pode ser espaço';
                            }
                            return null; // Validação passou
                          },
                        ])),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 33, bottom: 5),
                    child:
                        Text('Senha', style: context.textStyles.labelTextField),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: passwordEC,
                      obscureText: true,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Obrigatório'),
                        Validatorless.min(
                            2, 'Deve conter no mínimo 2 caracteres'),
                        Validatorless.max(
                            20, 'Deve conter no máximo 20 caracteres'),
                        (value) {
                          if (value!.isNotEmpty &&
                              RegExp(r'\s$').hasMatch(value)) {
                            return 'Último caractere não pode ser espaço';
                          }
                          return null; // Validação passou
                        },
                        Validatorless.regex(RegExp(r'^[a-zA-Z0-9]*$'),
                            'A senha não pode ter caracteres especiais, sendo apenas possível informar a até Z e 0 até 9'),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Button(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            Navigator.pushNamed(
                                context, '/information_capture');
                          }
                        },
                        style: context.buttonStyles.primaryButton,
                        labelStyle:
                            context.textStyles.textSecondaryFontExtraBold,
                        label: 'Entrar'),
                  )
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Text.rich(
                      TextSpan(
                        text: 'Política de Privacidade',
                        style: context.textStyles.textSecondaryFontItalic
                            .copyWith(color: context.colors.greyDart),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchUrl(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
