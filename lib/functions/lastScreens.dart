class Lastscreens {
  static List lastscreens = [];
  void addLastScreen(pageId) {
    print(lastscreens);
    lastscreens.add(pageId);
  }

  void removeLastscreen() {
    lastscreens.removeLast();
  }

  int returnCurrPage() {
    return lastscreens.last;
  }

  int returnGoingpage() {
    if (lastscreens.length >= 2 || lastscreens[lastscreens.length - 1] != 96) {
      removeLastscreen();
      int ret = lastscreens.last;
      removeLastscreen();
      return ret;
    } else {
      return lastscreens.last;
    }
  }
}
