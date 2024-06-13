{inputs, ...}: {
    time.timeZone = "Japan/Tokyo";

    i18n.defaultLocale = "en_AU.UTF-8";

    console.useXkbConfig = true;
    services.xserver.xkb.layout = "us";
}
