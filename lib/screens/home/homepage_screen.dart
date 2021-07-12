import 'package:flutter/material.dart';
import 'package:ta2set_app/screens/accounts/accounts_screen.dart';
import 'package:ta2set_app/screens/customer/customer_screen.dart';
import 'package:ta2set_app/screens/products/all_products_screen.dart';
import 'package:ta2set_app/screens/supplier/supplier_screen.dart';
import 'package:ta2set_app/widgets/option_container_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .25,
              child: FittedBox(
                child: Text(
                  'تقسيط',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: ListView(
                children: [
                  OptionContainer(
                    optionIcon: Icons.business_center,
                    optionName: "موردين",
                    widgetName: SupplierScreen(),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  OptionContainer(
                    optionIcon: Icons.add_business,
                    optionName: "عملاء",
                    widgetName: CustomerScreen(),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  OptionContainer(
                    optionIcon: Icons.account_balance_wallet,
                    optionName: "اليومية",
                    widgetName: AccountsScreen(),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  OptionContainer(
                    optionIcon: Icons.inventory,
                    optionName: "بضائع",
                    widgetName: AllCustomersScreen(),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
