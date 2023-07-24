import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/providers/setting_page_provider.dart';
import '../base.dart';
import '../basket/change_address.dart';
import '../basket/change_payment.dart';
import 'AccountAndProfile.dart';
import 'ContactSupport.dart';
import 'OrderHistory.dart';
import 'PrivacyPolicy.dart';
import 'ReferToAFriend.dart';
import 'TermsAndConditions.dart';
import 'WriteAReview.dart';

class SettingsBase extends StatelessWidget {
  const SettingsBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, SettingPageProvider page, Widget? child) {
      return Base(
        child: settingsWidgets[page.page],
      );
    });
  }
}

List<Widget> settingsWidgets = [
  const AccountAndProfile(),
  const ChangePayment(),
  const ChangeAddress(),
  const OrderHistory(),
  const ContactSupport(),
  const ReferToAFriend(),
  const WriteAReview(),
  const TermsAndConditions(),
  const PrivacyPolicy(),
];
