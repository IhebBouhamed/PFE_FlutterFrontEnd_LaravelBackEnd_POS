import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/LineChartSample2.dart';
import 'package:admin/screens/dashboard/components/RecapEtat.dart';
import 'package:admin/screens/dashboard/components/RecapMonetiques.dart';
import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/LineChartSample1.dart';
import '../../constants.dart';
import 'components/Raccourcis.dart';
import 'components/header.dart';
import 'components/EtatStock.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const RecapMonetiques(),
                      const SizedBox(height: defaultPadding),
                      //HeaderRaccourcis(),
                      const RecapEtat(),
                      
                      Row(
                        children: [
                          Text(
                            "Evolution du chiffre d'affaires",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      const LineChartSample2(),
                      const SizedBox(height: defaultPadding),
                      
                      Row(
                        children: [
                          Text(
                            "Récapitulatif du flux monétaire",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                           
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      const LineChartSample1(), 
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) const EtatStock(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const [
                        EtatStock(),
                        SizedBox(height: 20),
                        ListeRaccourcis()
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
