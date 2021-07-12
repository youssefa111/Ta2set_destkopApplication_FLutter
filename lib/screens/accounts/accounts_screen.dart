import 'package:flutter/material.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/screens/accounts/buy_screen.dart';
import 'package:ta2set_app/screens/accounts/sell_screen.dart';
import 'package:ta2set_app/widgets/option_container_screen.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TabBarWidget(
              tabName: "اليومية",
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .2,
                child: Scrollbar(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      OptionContainer(
                        optionIcon: Icons.stroller_outlined,
                        optionName: "عملية بيع",
                        widgetName: SellScreen(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      OptionContainer(
                        optionIcon: Icons.add,
                        optionName: "عملية شراء",
                        widgetName: BuyScreen(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      OptionContainer(
                        optionIcon: Icons.gradient_sharp,
                        optionName: "تحصيل قسط",
                        widgetName: BuyScreen(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      OptionContainer(
                        optionIcon: Icons.dialpad_outlined,
                        optionName: "دفع مبلغ",
                        widgetName: BuyScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
