class SwitchAnimate {
  // requestOutletArea_________________________________________
  static int pageState = 0;
  static double loginWidth = 0;
  static double loginHeight = 0;

  static double loginYOffset = 0;
  static double loginXOffset = 0;
  static double registerYOffset = 0;
  static double registerHeight = 0;

  static double windowWidth = 0;
  static double windowHeight = 0;

  void initSwitch(orientation, size) {
    switch (pageState) {
      case 0:
        loginWidth = windowWidth;
        loginYOffset = windowHeight;
        loginXOffset = 0;
        registerYOffset = windowHeight;
        break;
      case 1:
        loginWidth = windowWidth;
        loginYOffset = orientation ? size.height * .08 : size.height * .3;
        loginXOffset = 0;
        registerYOffset = windowHeight;
        break;
      case 2:
        loginWidth = windowWidth - 40;
        loginYOffset = 180;
        loginXOffset = 20;
        registerYOffset = 250;
        registerHeight = windowHeight - 100;
        break;
    }
  }
}
