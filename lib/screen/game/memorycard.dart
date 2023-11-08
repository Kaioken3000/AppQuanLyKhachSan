class MemoryCard {
  final String hiddenCardpath = 'assets/memorycard/image_cover.jpg';

  List<String>? gameImg;

  final cardCount = 12;

  List<String> cards_list = [
    'assets/memorycard/image_1.png',
    'assets/memorycard/image_2.png',
    'assets/memorycard/image_3.png',
    'assets/memorycard/image_4.png',
    'assets/memorycard/image_5.png',
    'assets/memorycard/image_6.png',
    'assets/memorycard/image_1.png',
    'assets/memorycard/image_2.png',
    'assets/memorycard/image_3.png',
    'assets/memorycard/image_4.png',
    'assets/memorycard/image_5.png',
    'assets/memorycard/image_6.png',
  ];

  List<Map<int, String>> matchCheck = [];

  void initGame() {
    cards_list.shuffle();
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
