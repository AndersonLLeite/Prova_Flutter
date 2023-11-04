import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prova_flutter/models/infostore.dart';
import 'package:prova_flutter/ui/styles/colors_app.dart';
import 'package:prova_flutter/ui/styles/text_styles.dart';
import 'package:prova_flutter/ui/widgets/card_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validatorless/validatorless.dart';

class InformationCapture extends StatefulWidget {
  const InformationCapture({Key? key}) : super(key: key);

  @override
  State<InformationCapture> createState() => _InformationCaptureState();
}

class _InformationCaptureState extends State<InformationCapture> {
  InfoStore infoStore = InfoStore();
  final TextEditingController _textEditingController = TextEditingController();
  final Uri _url = Uri.parse('https://google.com.br');
  final FocusNode _textFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isEditing = false;
  int editingIndex = -1;

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (!_textFocus.hasFocus) {
            FocusScope.of(context).requestFocus(_textFocus);
          }
        },
        child: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [context.colors.primary, context.colors.secondary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Card(
                      child: Observer(
                        builder: (_) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: infoStore.infoList.length,
                            itemBuilder: (_, index) {
                              return CardWidget(
                                info: infoStore.infoList[index],
                                isEditing: isEditing,
                                index: index,
                                editingIndex: editingIndex,
                                onEdit: () {
                                  setState(() {
                                    isEditing = true;
                                    editingIndex = index;
                                  });
                                },
                                onEdited: (value) {
                                  setState(() {
                                    isEditing = false;
                                    editingIndex = -1;
                                  });
                                  infoStore.updateInfo(index, value);
                                  _textFocus.requestFocus();
                                },
                                onDelete: () {
                                  showDeleteConfirmationDialog(index);
                                  _textFocus.requestFocus();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: _textFocus,
                            autofocus: true,
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              labelText: 'Digite seu texto',
                              labelStyle:
                                  context.textStyles.textPrimaryFontBold,
                              border: const OutlineInputBorder(),
                            ),
                            validator:
                                Validatorless.required('Não pode ser vazio'),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                if (isEditing) {
                                  infoStore.updateInfo(editingIndex, value);
                                } else {
                                  infoStore.addInfo(value);
                                }
                                _textEditingController.clear();
                                setState(() {
                                  isEditing = false;
                                  editingIndex = -1;
                                });
                              }
                              _textFocus.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Informação?'),
          content:
              const Text('Tem certeza que deseja excluir esta informação?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                infoStore.removeInfo(infoStore.infoList[index]);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
