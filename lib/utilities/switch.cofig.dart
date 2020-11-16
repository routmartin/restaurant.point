class SwitchContainer {
  static double firstContainerWidth = 0;
  static double firstContainerHeight = 0;

  static double firstContainerYOffset = 0;
  static double firstContainerXOffset = 0;
  static double seconndContainerYOffset = 0;
  static double seconndContainerXOffset = 0;
  static double secondContainerHeight = 0;

  static double windowWidth = 0;
  static double windowHeight = 0;

  rederAnimateContainer({orientation, size, pageState}) {
    switch (pageState) {
      case 0:
        firstContainerWidth = windowWidth;
        firstContainerYOffset = windowHeight;
        firstContainerXOffset = size.width >= 1200
            ? size.height * .65
            : size.width >= 1000 ? size.width * 0.2 : 0;
        seconndContainerYOffset = windowHeight;
        break;
      case 1:
        firstContainerWidth = windowWidth;
        firstContainerYOffset = size.width >= 1200
            ? size.height * .08
            : size.width >= 1000 ? size.width * 0.2 : 10;
        firstContainerXOffset = size.width >= 1200
            ? size.height * .65
            : size.width >= 1000 ? size.width * 0.2 : 0;
        seconndContainerYOffset = windowHeight;
        break;
      case 2:
        firstContainerWidth = windowWidth - 40;
        firstContainerYOffset = size.width >= 1200
            ? size.height * .08
            : size.width >= 1000 ? size.width * 0.2 : 10;
        firstContainerXOffset = size.width >= 1200
            ? size.height * .65
            : size.width >= 1000 ? size.width * 0.2 : .65;
        seconndContainerYOffset = 120;
        seconndContainerXOffset = size.width >= 1200
            ? size.height * .68
            : size.width >= 1000 ? size.width * 454 : 0;
        secondContainerHeight = windowHeight;
        break;
    }
  }
}
