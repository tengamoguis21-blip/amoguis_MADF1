import 'package:flutter/material.dart'; 
import 'package:flutter_test/flutter_test.dart'; 
import 'package:student_registration_app/main.dart'; 
  
void main() { 
  testWidgets('Home screen opens successfully', 
      (WidgetTester tester) async { 
    await tester.pumpWidget(const StudentApp()); 
    expect(find.text('Student Application'), findsOneWidget); 
    expect(find.text('Open Registration Screen'), findsOneWidget); 
    expect(find.byType(TextField), findsOneWidget); 
  }); 
  
  testWidgets('Registration navigation works', 
      (WidgetTester tester) async { 
    await tester.pumpWidget(const StudentApp()); 
    await tester.tap(find.text('Open Registration Screen')); 
    await tester.pumpAndSettle(); 
    expect(find.text('Student Registration'), findsOneWidget); 
    expect(find.text('Register Student'), findsOneWidget); 
  }); 
} 