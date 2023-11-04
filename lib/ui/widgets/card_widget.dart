import 'package:flutter/material.dart';
import 'package:prova_flutter/ui/styles/custom_icons.dart';
import 'package:prova_flutter/ui/styles/text_styles.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final int editingIndex;
  final String info;
  final bool isEditing;
  final VoidCallback onEdit;
  final void Function(String value) onEdited;
  final VoidCallback onDelete;

  const CardWidget(
      {Key? key,
      required this.info,
      required this.isEditing,
      required this.onEdit,
      required this.onEdited,
      required this.onDelete,
      required this.index,
      required this.editingIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            title: Center(
              child: isEditing
                  ? index == editingIndex
                      ? TextFormField(
                          controller: TextEditingController(text: info),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) {
                            onEdited(value);
                          },
                        )
                      : Text(info,
                          style: context.textStyles.textPrimaryFontBold)
                  : Text(info, style: context.textStyles.textPrimaryFontBold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                !isEditing
                    ? IconButton(
                        onPressed: onEdit,
                        icon: const Icon(
                          MyCustomIcons.edit,
                          color: Colors.black,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          onEdited(info);
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    MyCustomIcons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
