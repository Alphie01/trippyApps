class Lastscreens {
  static List lastscreens = [];
  void addLastScreen(pageId) {
    lastscreens.add(pageId);
  }

  static void _removeLastscreen() {
    lastscreens.removeLast();
  }

  static int returnGoingpage() {
    if (lastscreens.length >= 2 || lastscreens[lastscreens.length - 1] != 96) {
      _removeLastscreen();
      int ret = lastscreens.last;
      _removeLastscreen();
      return ret;
    } else {
      return lastscreens.last;
    }
  }
}
