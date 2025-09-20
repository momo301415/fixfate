import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get manrope {
    return copyWith(
      fontFamily: 'Manrope',
    );
  }

  TextStyle get pingFangTC {
    return copyWith(
      fontFamily: 'PingFang TC',
    );
  }
 TextStyle get pingFangTC3 {
    return copyWith(fontFamily: 'PingFang TC');
  }
    TextStyle get pingFangTC4 {
    return copyWith(fontFamily: 'PingFang TC');
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  static TextStyle get titleMediumPrimary_2 =>
      theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary);
  static TextStyle get labelSmallErrorContainer => theme.textTheme.labelSmall!
      .copyWith(color: theme.colorScheme.errorContainer);
   static TextStyle get bodySmallGray50010_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray500.withValues(alpha: 0.8),
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallPrimary10 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary.withValues(alpha: 0.8),
        fontSize: 10.fSize,
      );
  static TextStyle get pingFangTC3Primary =>
      TextStyle(
        color: theme.colorScheme.primary.withValues(alpha: 0.8),
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).pingFangTC3;
       static TextStyle get bodySmallErrorContainer10_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.8),
        fontSize: 10.fSize,
      );
  static TextStyle get labelMediumPrimary_1 => theme.textTheme.labelMedium!
      .copyWith(color: theme.colorScheme.primary.withValues(alpha: 0.8));
  static TextStyle get pingFangTC4ErrorContainerRegular =>
      TextStyle(
        color: theme.colorScheme.errorContainer,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).pingFangTC4;
  static TextStyle get labelMediumErrorContainer => theme.textTheme.labelMedium!
      .copyWith(color: theme.colorScheme.errorContainer, fontSize: 11.fSize);
  static TextStyle get labelLargePrimary_2 =>
      theme.textTheme.labelLarge!.copyWith(color: theme.colorScheme.primary);
   static TextStyle get bodySmallWhiteA70011 => theme.textTheme.bodySmall!
      .copyWith(color: appTheme.whiteA700, fontSize: 11.fSize);
  static TextStyle get labelLargeBluegray400 =>
      theme.textTheme.labelLarge!.copyWith(color: appTheme.blueGray400);
   static TextStyle get bodySmallPrimaryContainer11_1 => theme
      .textTheme
      .bodySmall!
      .copyWith(color: theme.colorScheme.primaryContainer, fontSize: 11.fSize);
  static TextStyle get bodySmallPrimaryContainer11 => theme.textTheme.bodySmall!
      .copyWith(color: theme.colorScheme.primaryContainer, fontSize: 11.fSize);
    static TextStyle get bodySmallPrimaryContainer_6 => theme.textTheme.bodySmall!
      .copyWith(color: theme.colorScheme.primaryContainer);
  static TextStyle get titleMediumBluegray400 => theme.textTheme.titleMedium!
      .copyWith(color: appTheme.blueGray400, fontSize: 16.fSize);
    static TextStyle get pingFangTC4ErrorContainer =>
      TextStyle(
        color: theme.colorScheme.errorContainer,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w500,
      ).pingFangTC4;
       static TextStyle get pingFangTC4ErrorContainerRegular6 =>
      TextStyle(
        color: theme.colorScheme.errorContainer,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).pingFangTC4;
  static TextStyle get labelLargePrimary =>
      theme.textTheme.labelLarge!.copyWith(color: theme.colorScheme.primary);
  static TextStyle get titleSmallErrorContainer14_1 => theme
      .textTheme
      .titleSmall!
      .copyWith(color: theme.colorScheme.errorContainer, fontSize: 14.fSize);
  static TextStyle get bodySmall8 =>
      theme.textTheme.bodySmall!.copyWith(fontSize: 8.fSize);
   static TextStyle get headlineSmallErrorContainer => theme
      .textTheme
      .headlineSmall!
      .copyWith(color: theme.colorScheme.errorContainer);
  static TextStyle get labelSmallBluegray400 => theme.textTheme.labelSmall!
      .copyWith(color: appTheme.blueGray400, fontSize: 8.fSize);
   static TextStyle get titleSmallPrimary => theme.textTheme.titleSmall!
      .copyWith(color: theme.colorScheme.primary, fontSize: 14.fSize);
    static TextStyle get titleSmallBluegray40014 => theme.textTheme.titleSmall!
      .copyWith(color: appTheme.blueGray400, fontSize: 14.fSize);
   static TextStyle get labelSmallPrimary =>
      theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 8.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get bodySmallBluegray4008 => theme.textTheme.bodySmall!
      .copyWith(color: appTheme.blueGray400, fontSize: 8.fSize);
  static TextStyle get bodySmallBluegray400_1 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.blueGray400);
  static TextStyle get bodyMediumPrimaryContainer_1 =>
      theme.textTheme.bodyMedium!
          .copyWith(color: theme.colorScheme.primaryContainer);
  static TextStyle get bodyMediumGray500_1 =>
      theme.textTheme.bodyMedium!.copyWith(color: appTheme.gray500);
  static TextStyle get bodyMediumPrimaryContainer_3 =>
      theme.textTheme.bodyMedium!
          .copyWith(color: theme.colorScheme.primaryContainer);
  static TextStyle get bodySmallBluegray900 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.blueGray900);
  static TextStyle get bodySmall11_1 =>
      theme.textTheme.bodySmall!.copyWith(fontSize: 11.fSize);
  static TextStyle get titleSmallPrimarySemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmallErrorContainerSemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeSemiBold =>
      theme.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get titleMediumErrorContainer16 => theme
      .textTheme.titleMedium!
      .copyWith(color: theme.colorScheme.errorContainer, fontSize: 16.fSize);
  static TextStyle get bodySmallPrimary10_1 => theme.textTheme.bodySmall!
      .copyWith(color: theme.colorScheme.primary, fontSize: 10.fSize);
  static TextStyle get bodyLargePrimaryContainer16_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.45),
        fontSize: 16.fSize,
      );
  // Body text style
  static TextStyle get bodyLarge16 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLarge16_1 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeBluegray400 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeGray200 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray200,
      );
  static TextStyle get bodyLargeGray500 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray500,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeGray50001 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray50001,
      );
  static TextStyle get bodyLargeGray50016 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray500,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeGray50016_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray500,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeGray500_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray500,
      );
  static TextStyle get bodyLargeGray700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray700,
        fontSize: 19.fSize,
      );
  static TextStyle get bodyLargeGray700_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray700,
      );

  static TextStyle get bodyLargePrimaryContainer =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargePrimaryContainer16 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeWhiteA700 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 19.fSize,
      );
  static TextStyle get bodyLargeWhiteA70016 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeWhiteA700_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
      );

  static TextStyle get bodyMedium13 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 13.fSize,
      );
  static TextStyle get bodyMedium13_1 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 13.fSize,
      );
  static TextStyle get bodyMedium15 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumBluegray400 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray400,
      );
  static TextStyle get bodyMediumBluegray900 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumGray300 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray300,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumGray500 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumGray50001 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray50001,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumGray50002 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray50002,
        fontSize: 13.fSize,
      );
  static TextStyle get bodyMediumGray50013 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
        fontSize: 13.fSize,
      );
  static TextStyle get bodyMediumGray700 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray700,
      );
  static TextStyle get bodyMediumManropePrimaryContainer =>
      theme.textTheme.bodyMedium!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static TextStyle get bodyMediumPrimary =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get bodyMediumPrimary13 => theme.textTheme.bodyMedium!
      .copyWith(color: theme.colorScheme.primary, fontSize: 13.fSize);
  static TextStyle get bodyMediumPrimary15 => theme.textTheme.bodyMedium!
      .copyWith(color: theme.colorScheme.primary, fontSize: 15.fSize);
  static TextStyle get bodyMediumPrimaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumPrimaryContainer15 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumPrimaryContainer15_1 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 15.fSize,
      );

  static TextStyle get bodyMediumPrimaryContainer_2 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(
          alpha: 0.8,
        ),
      );
  static TextStyle get bodyMediumWhiteA700 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 13.fSize,
      );
  static TextStyle get bodyMediumWhite => theme.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 13.fSize,
      );
  static get bodyMedium_1 => theme.textTheme.bodyMedium!;
  static TextStyle get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallBluegray200 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray200,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallBluegray400 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallBluegray40010 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallErrorContainer =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.errorContainer.withValues(
          alpha: 0.86,
        ),
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallErrorContainer_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.errorContainer.withValues(
          alpha: 0.85,
        ),
      );
  static TextStyle get bodySmallGray300 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray300,
      );
  static TextStyle get bodySmallGray500 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray500,
      );
  static TextStyle get bodySmallGray50001 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50001,
      );
  static TextStyle get bodySmallGray50010 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray500,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallGray5008 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray500,
        fontSize: 8.fSize,
      );
  static TextStyle get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 8.fSize,
      );
  static TextStyle get bodySmallPrimaryContainer =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(
          alpha: 0.6,
        ),
      );
  static TextStyle get bodySmallPrimaryContainer_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(
          alpha: 0.8,
        ),
      );
  static TextStyle get bodySmallPrimaryContainer_2 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static TextStyle get bodySmallPrimaryContainer_3 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static TextStyle get bodySmallWhiteA700 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700.withValues(
          alpha: 0.85,
        ),
      );
  static TextStyle get bodySmallWhiteA700_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
      );
  static TextStyle get bodySmallPrimaryContainer_5 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.86),
      );
  static TextStyle get bodySmallPrimaryContainer_4 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.85),
      );
  // Headline text style
  static TextStyle get headlineSmallPrimary => theme.textTheme.headlineSmall!
      .copyWith(color: theme.colorScheme.primary.withValues(alpha: 0.85));
  static TextStyle get labelLargePrimary_1 => theme.textTheme.labelLarge!
      .copyWith(color: theme.colorScheme.primary.withValues(alpha: 0.8));
  static TextStyle get headlineLargePrimaryContainer =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w400,
      );
  // Label text style
  static TextStyle get labelLargePrimaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static TextStyle get labelLargeBlack900 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 15.0.fSize,
      );
  static TextStyle get labelMediumBlack900 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get labelMediumPrimary =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get labelMediumWhiteA700 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.whiteA700,
      );
// Ping text style
  static TextStyle get pingFangTCErrorContainer => TextStyle(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w400,
      ).pingFangTC;
  static TextStyle get pingFangTC1Bluegray400 => TextStyle(
        color: appTheme.blueGray400.withValues(alpha: 0.8),
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).pingFangTC;
// Title text style
  static TextStyle get titleMediumPrimary_1 => theme.textTheme.titleMedium!
      .copyWith(color: theme.colorScheme.primary.withValues(alpha: 0.85));
  static TextStyle get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 20.fSize,
      );
  static TextStyle get titleLargeErrorContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 20.fSize,
      );
  static TextStyle get titleLargePrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get titleLargePrimaryContainer22 =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 22.fSize,
      );
  static TextStyle get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get titleMediumBluegray900 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 17.fSize,
      );
  static TextStyle get titleMediumErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 17.fSize,
      );
  static TextStyle get titleMediumErrorContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 17.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMediumSemiBold => theme.textTheme.titleMedium!
      .copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w600);
  static TextStyle get titleMediumGray500 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray500,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumGray50001 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray50001,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumManrope =>
      theme.textTheme.titleMedium!.manrope.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumManropePrimaryContainer =>
      theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumManropePrimaryContainerSemiBold =>
      theme.textTheme.titleMedium!.manrope.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(
          alpha: 0.9,
        ),
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
      );
  static TextStyle get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 17.fSize,
      );
  static TextStyle get titleMediumPrimaryContainer16 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 16.fSize,
      );
  static TextStyle get titleMediumPrimaryContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 17.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static TextStyle get titleMediumPrimarySemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmall14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
      );
  static TextStyle get titleSmallBluegray400 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray400,
      );
  static TextStyle get titleSmallErrorContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 14.fSize,
      );
  static TextStyle get titleSmallWhiteA700 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
  static TextStyle get bodySmallWhiteA700_2 => theme.textTheme.bodySmall!
      .copyWith(color: appTheme.whiteA700.withValues(alpha: 0.45));
  static TextStyle get titleMediumWhiteA700 => theme.textTheme.titleMedium!
      .copyWith(color: appTheme.whiteA700.withValues(alpha: 0.5));
  // Display text style
  static TextStyle get displayMediumPrimaryContainer =>
      theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.85),
      );
  static TextStyle get displaySmallWhiteA700 =>
      theme.textTheme.displaySmall!.copyWith(
        color: appTheme.whiteA700.withValues(alpha: 0.85),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get displaySmallPrimaryContainer =>
      theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.85),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get displaySmallPrimary =>
      theme.textTheme.displaySmall!.copyWith(color: theme.colorScheme.primary);
  static TextStyle get bodyLargeWhiteA70016_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700.withValues(alpha: 0.45),
        fontSize: 16.fSize,
      );

  static TextStyle get bodySmall11 =>
      theme.textTheme.bodySmall!.copyWith(fontSize: 11.fSize);

  static TextStyle get labelMediumPrimarySemiBold =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 11.fSize,
        fontWeight: FontWeight.w600,
      );
}
