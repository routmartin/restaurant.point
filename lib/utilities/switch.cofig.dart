class SwitchContainer {
  static double firstContainerWidth = 0;
  static double firstContainerHeight = 0;

  static double firstContainerYOffset = 0;
  static double firstContainerXOffset = 0;
  static double seconndContainerYOffset = 0;
  static double secondContainerHeight = 0;

  static double windowWidth = 0;
  static double windowHeight = 0;

  rederAnimateContainer({orientation, size, pageState}) {
    switch (pageState) {
      case 0:
        firstContainerWidth = windowWidth;
        firstContainerYOffset = windowHeight;
        firstContainerXOffset = 0;
        seconndContainerYOffset = windowHeight;
        break;
      case 1:
        firstContainerWidth = windowWidth;
        firstContainerYOffset =
            orientation ? size.height * .06 : size.height * .07;
        firstContainerXOffset = 0;
        seconndContainerYOffset = windowHeight;
        break;
      case 2:
        firstContainerWidth = windowWidth - 40;
        firstContainerYOffset = 120;
        firstContainerXOffset = 0;
        seconndContainerYOffset = 180;
        secondContainerHeight = windowHeight;
        break;
    }
  }
}
