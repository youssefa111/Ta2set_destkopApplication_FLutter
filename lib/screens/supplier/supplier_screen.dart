import 'package:flutter/material.dart';
import 'package:ta2set_app/constants/tabbar_widget.dart';

import 'package:ta2set_app/screens/supplier/all_suppliers_screen.dart';

import 'package:ta2set_app/widgets/option_container_screen.dart';

import 'add_supplier_screen.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TabBarWidget(
                tabName: "المورد",
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
                        optionName: "أضافة مورد",
                        widgetName: AddSupplierScreen(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      OptionContainer(
                        optionIcon: Icons.people_alt,
                        optionName: "جميع الموردين",
                        widgetName: AllSuppliersScreen(),
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
