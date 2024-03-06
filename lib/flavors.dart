enum Flavor {
  dev,
  sit,
  uat,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'CarpeYom DEV';
      case Flavor.sit:
        return 'CarpeYom SIT';
      case Flavor.uat:
        return 'CarpeYom UAT';
      case Flavor.prod:
        return 'CarpeYom';
      default:
        return 'title';
    }
  }

}
