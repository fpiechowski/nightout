import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

nightoutTheme(BuildContext context) =>
    ThemeData(
        textTheme: _nightoutTextTheme(context),
        chipTheme: _nightoutChipTheme,
        colorScheme: _nightoutColorScheme,
        appBarTheme: _nightoutAppBarTheme(context),
        iconTheme: _nightoutIconTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        cardTheme: _nightoutCardTheme(context),
        listTileTheme: _nightoutListTileTheme(context),
        floatingActionButtonTheme: _floatingActionButtonTheme(context),
    );

_floatingActionButtonTheme(context) =>
    FloatingActionButtonThemeData(
      backgroundColor: _nightoutColorScheme.primary
    );

_nightoutAppBarTheme(BuildContext context) =>
    AppBarTheme(
      titleTextStyle: GoogleFonts.raleway(
          textStyle: _nightoutTextTheme(context).titleLarge),
    );

_nightoutCardTheme(BuildContext context) =>
    CardTheme(color: _nightoutColorScheme.surface, elevation: 10);

final _nightoutChipTheme = ChipThemeData(
  backgroundColor: _nightoutColorScheme.background,
  selectedColor: _nightoutColorScheme.primary,
  secondarySelectedColor: _nightoutColorScheme.secondary,
  shadowColor: _nightoutColorScheme.background,
);

final _nightoutColorScheme = ColorScheme(
  surfaceTint: Colors.white54,
  surfaceVariant: const Color.fromRGBO(128, 99, 204, 1).withOpacity(0.8),
  brightness: Brightness.dark,
  primary: const Color.fromRGBO(130, 209, 213, 1),
  secondary: const Color.fromRGBO(128, 99, 204, 1),
  background: const Color.fromRGBO(22, 22, 22, 1),
  surface: const Color.fromRGBO(45, 45, 45, 1),
  error: const Color.fromRGBO(154, 52, 67, 1),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onError: Colors.white,
  onBackground: const Color.fromRGBO(142, 142, 142, 1),
  onSurface: Colors.white,
);

final _nightoutIconTheme = IconThemeData(
  color: _nightoutColorScheme.onPrimary,);

_nightoutTextTheme(BuildContext context) =>
    TextTheme(
      /*titleLarge: GoogleFonts.raleway(
          textStyle: Theme.of(context).textTheme.titleLarge),
      titleMedium: GoogleFonts.raleway(
          textStyle: Theme.of(context).textTheme.titleMedium),
      titleSmall: GoogleFonts.raleway(
          textStyle: Theme.of(context).textTheme.titleSmall),
      displayLarge: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.displayLarge),
      displayMedium: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.displayMedium),
      displaySmall: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.displaySmall),
      headlineLarge: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.headlineLarge),
      headlineMedium: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.headlineMedium),
      headlineSmall: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.headlineSmall),
      bodyLarge:
          GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyLarge),
      bodyMedium:
          GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodyMedium),
      bodySmall:
          GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.bodySmall),*/
      bodyText1: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .bodyText1),
      bodyText2: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .bodyText2),
      headline6: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .headline6),
      headline5: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .headline5),
      headline4: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .headline4),
      headline3: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .headline3),
      headline2: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .headline2),
      headline1: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .headline1),
      subtitle1: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .subtitle1),
      subtitle2: GoogleFonts.kanit(
          color: _nightoutColorScheme.surfaceTint,
          textStyle: Theme
              .of(context)
              .textTheme
              .subtitle2),
      caption: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .caption),
      overline: GoogleFonts.kanit(
          color: _nightoutColorScheme.onSurface,
          textStyle: Theme
              .of(context)
              .textTheme
              .overline),
      button: GoogleFonts.kanit(
        color: _nightoutColorScheme.onPrimary,
        shadows: [
          Shadow(color: _nightoutColorScheme.background, blurRadius: 1),
        ],
      ),
    );

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.only(left: 8, right: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    padding: const EdgeInsets.only(left: 20, right: 20),
    backgroundColor: _nightoutColorScheme.secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);

_nightoutListTileTheme(BuildContext context) =>
    ListTileThemeData(textColor: _nightoutColorScheme.onSurface);
