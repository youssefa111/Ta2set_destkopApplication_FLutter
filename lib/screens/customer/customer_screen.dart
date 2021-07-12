import 'package:flutter/material.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';
import 'package:ta2set_app/screens/customer/add_customer_screen.dart';

import 'package:ta2set_app/widgets/option_container_screen.dart';

import 'all_customers_screen.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TabBarWidget(
                tabName: "العميل",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                  child: ListView(
                    children: [
                      OptionContainer(
                        optionIcon: Icons.person_add_alt_1,
                        optionName: "أضافة عميل",
                        widgetName: AddCustomerScreen(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      OptionContainer(
                        optionIcon: Icons.people_alt,
                        optionName: "جميع العملاء",
                        widgetName: AllCustomersScreen(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
