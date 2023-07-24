import 'package:flutter/cupertino.dart';

import '../../theme/colors.dart';
import '../../theme/text_theme.dart';

Widget logo(BuildContext context, {TextStyle? foodStyle, TextStyle? eStyle}) =>
    RichText(
      text: TextSpan(
        style: foodStyle ?? head36(context, textPrimary(context)),
        children: [
          const TextSpan(
            text: "FOODY-",
          ),
          TextSpan(
            text: "OFFICE",
            style: eStyle ?? head36(context, AppColors.primary),
          ),
        ],
      ),
    );
