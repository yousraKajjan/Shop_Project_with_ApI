
//هي الدالة وظيفتها أنها تطبع كافة النص مهما ما كان طويل 

void printFullText(String text) {
  final pattern = RegExp('.{1.800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
