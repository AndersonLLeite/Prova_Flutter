import 'package:flutter/material.dart';
import 'package:prova_flutter/ui/styles/custom_icons.dart';
import 'package:prova_flutter/ui/styles/text_styles.dart';

class CardWidget extends StatefulWidget {
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
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.info;
    super.initState();
  }

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
                child: widget.isEditing && widget.index == widget.editingIndex
                    ? TextFormField(
                        maxLines: 4,
                        controller: controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (value) {
                          widget.onEdited(value);
                        },
                      )
                    : Text(widget.info,
                        style: context.textStyles.textPrimaryFontBold)),
            trailing: widget.isEditing && widget.index == widget.editingIndex
                ? IconButton(
                    onPressed: () {
                      widget.onEdited(controller.text);
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: widget.onEdit,
                        icon: const Icon(
                          MyCustomIcons.edit,
                          color: Colors.black,
                        ),
                      ),
                      !widget.isEditing
                          ? IconButton(
                              onPressed: widget.onDelete,
                              icon: const Icon(
                                MyCustomIcons.delete,
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
