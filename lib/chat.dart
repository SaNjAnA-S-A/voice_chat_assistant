enum ChatType { user, bot }

class Chat {
  Chat({required this.text, required this.type});
  String? text;
  ChatType? type;
}
