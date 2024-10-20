// lib/main.dart
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'tenant_overview_screen.dart';
import 'tenant_detail_screen.dart';
// import 'edit_tenant_screen.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
   return MaterialApp(debugShowCheckedModeBanner: false,
     title:'Room Rent Manager',
     theme:
         ThemeData(primarySwatch:
         Colors.brown, visualDensity:
         VisualDensity.adaptivePlatformDensity,),
     initialRoute:'/welcome',
     routes:{
       '/welcome': (context) => const WelcomeScreen(),
       '/tenantOverview': (context) => const TenantOverviewScreen(),
       '/tenantDetail': (context) => const TenantDetailScreen(),
      //  '/EditTenant':(context)=>const  EditTenantScreen(),
      

     
     },
   );
 }
}