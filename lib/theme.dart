import 'package:flutter/material.dart';

class AppColors {
  static const Color robinEggBase = Color(0xFF0CCABA);
  static const List<Color> robinEggShades = [
    Color(0xFF90F8EF),
    Color(0xFF6EF6EA),
    Color(0xFF90F8EF),
    Color(0xFF2BF2E1),
    Color(0xFF0EEBD9),
    Color(0xFF0CCABA),
    Color(0xFF0AA89B),
    Color(0xFF08867C),
    Color(0xFF06655D),
    Color(0xFF04433E),
  ];

  static const Color caperBase = Color(0xFFE3F5B7);
  static const List<Color> caperShades = [
    Color(0xFFD6F098),
    Color(0xFFCAEC78),
    Color(0xFFBEE759),
    Color(0xFFB2E339),
    Color(0xFFA4DB1E),
    Color(0xFF8DBC1A),
    Color(0xFF759C15),
    Color(0xFF5E7D11),
    Color(0xFF465E0D),
    Color(0xFF2F3E08),
  ];

  static const Color cornBase = Color(0xFFE6AE00);
  static const List<Color> cornShades = [
    Color(0xFFFFE289),
    Color(0xFFFFD966),
    Color(0xFFFFD142),
    Color(0xFFFFC81E),
    Color(0xFFF9BD00),
    Color(0xFFD6A200),
    Color(0xFFB28700),
    Color(0xFF8E6C00),
    Color(0xFF6B5100),
    Color(0xFF473600),
  ];

  static const Color bambooBase = Color(0xFFD46700);
  static const List<Color> bambooShades = [
    Color(0xFFFFC289),
    Color(0xFFFFB066),
    Color(0xFFFF9D42),
    Color(0xFFFF8B1E),
    Color(0xFFF97900),
    Color(0xFFD66800),
    Color(0xFFB25600),
    Color(0xFF8E4500),
    Color(0xFF6B3400),
    Color(0xFF472200),
  ];

  static const Color oregonBase = Color(0xFF9E3F00);
  static const List<Color> oregonShades = [
    Color(0xFFFFB889),
    Color(0xFFFFA366),
    Color(0xFFFF8D42),
    Color(0xFFFF781E),
    Color(0xFFF96300),
    Color(0xFFD65500),
    Color(0xFFB24700),
    Color(0xFF8E3800),
    Color(0xFF6B2A00),
    Color(0xFF471C00),
  ];
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.robinEggBase,
  scaffoldBackgroundColor: AppColors.caperShades[0],
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.robinEggBase,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(50),
      backgroundColor: AppColors.cornBase,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.cornBase,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(12),
      foregroundColor: Colors.white,
      textStyle: AppStyles.buttonText,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(Colors.white),
      iconSize: WidgetStateProperty.all(24),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white, size: 24),
  textTheme:  TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.oregonBase,
    ),
    bodyLarge: TextStyle(
      color: AppColors.oregonBase.withAlpha((0.8 * 255).toInt()),
      fontSize: 16,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.bambooBase,
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.caperBase,
    insetPadding: const EdgeInsets.all(25),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.bambooBase,
    foregroundColor: Colors.white,
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.all(12),
    tileColor: AppColors.caperShades[4].withAlpha((0.3 * 255).toInt()),
  ),
  cardTheme: CardThemeData(
    color: AppColors.caperBase.withAlpha((0.6 * 255).toInt()),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.zero,
  ),
);

class AppStyles {
  static final TextStyle fadedText = TextStyle(
    fontSize: 18,
    color: AppColors.oregonBase.withAlpha((0.6 * 255).toInt()),
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle containerText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.oregonBase,
  );

  static const TextStyle listTileTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.oregonBase,
  );

  static final TextStyle listTileSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.oregonBase.withAlpha((0.6 * 255).toInt()),
  );

  static const Icon arrowDownIcon = Icon(
    Icons.arrow_drop_down_rounded,
    size: 21,
    color: AppColors.oregonBase,
  );
  static const Icon arrowUpIcon = Icon(
    Icons.arrow_drop_up_rounded,
    size: 21,
    color: AppColors.oregonBase,
  );
  static const Icon backIcon = Icon(Icons.arrow_back_rounded);
  static const Icon cancelIcon = Icon(Icons.cancel_rounded);
  static const Icon cameraIcon = Icon(Icons.camera_alt_rounded);
  static const Icon deleteIcon = Icon(Icons.delete_rounded);
  static const Icon deleteForeverIcon = Icon(Icons.delete_forever_rounded);
  static const Icon historyIcon = Icon(Icons.history_rounded);
  static const Icon screenShotIcon = Icon(
    Icons.center_focus_strong_outlined,
    size: 36,
  );
  static const Icon straightenIcon = Icon(
    Icons.straighten_rounded,
    color: Colors.white,
  );
  static const Icon undoIcon = Icon(Icons.undo_rounded, size: 36);
  static const Icon warningIcon = Icon(
    Icons.warning_amber_rounded,
    size: 32,
    color: AppColors.oregonBase,
  );
  static Icon infoIcon = Icon(
    Icons.info_outline_rounded,
    size: 60,
    color: AppColors.oregonBase.withAlpha((0.6 * 255).toInt()),
  );

  static const EdgeInsetsGeometry paddingBig = EdgeInsets.all(24);
  static const EdgeInsetsGeometry paddingMedium = EdgeInsets.symmetric(
    vertical: 8,
    horizontal: 16,
  );
  static const EdgeInsetsGeometry paddingSmall = EdgeInsets.all(16);

  static const double spacingLarge = 24;
  static const double spacingMedium = 20;
  static const double spacingNormal = 12;
  static const double spacingSmall = 8;

  static InputDecorationTheme inputDecoration = InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: AppColors.caperBase.withAlpha((0.8 * 255).toInt()),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    constraints: BoxConstraints.tightFor(height: 42),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static MenuStyle menu = MenuStyle(
    backgroundColor: WidgetStatePropertyAll(
      AppColors.caperBase.withAlpha((0.6 * 255).toInt()),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide.none,
      ),
    ),
    maximumSize: WidgetStatePropertyAll(Size(300, double.infinity)),
  );

  static Widget materialCard({required Widget child}) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: child,
    );
  }

  static Widget avatar({required Widget child}) {
    return CircleAvatar(backgroundColor: AppColors.robinEggBase, child: child);
  }
}
