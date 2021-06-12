# Flutter

- VSCode does not recognize device
  ```
  $ rm -rf /Users/hectortakami/Development/flutter/bin/cache
  $ flutter doctor -v
  ```

## Flutter Swipper

https://pub.dev/packages/flutter_swiper

_pubspec.yaml_

```yaml
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  flutter_swiper:
```

_main.dart_

```dart
// @dart=2.9
import ...
```

_widget.dart_

```dart
import 'package:flutter_swiper/flutter_swiper.dart';
// ...
Widget cardSwiper() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: double.infinity,
      height: 300,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        layout: SwiperLayout.STACK, // NULL | SwiperLayout.TINDER | SwiperLayout.STACK | SwiperLayout.CUSTOM
        itemWidth: 300,
        itemHeight: 500,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
```
