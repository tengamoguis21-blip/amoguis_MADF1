import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final studentIdController = TextEditingController();
  final emailController = TextEditingController();
  int registrationCount = 0;

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> registerStudent() async {
    if (!_formKey.currentState!.validate()) return;

    final studentData = <String, String>{
      'name': nameController.text.trim(),
      'studentId': studentIdController.text.trim(),
      'email': emailController.text.trim(),
    };

    setState(() {
      registrationCount++;
    });

    await Navigator.pushNamed(context, '/profile', arguments: studentData);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Student registration completed successfully!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> clearForm() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Form'),
        content: const Text('Are you sure you want to clear all fields?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (!mounted || confirm != true) return;
    _formKey.currentState!.reset();
    nameController.clear();
    studentIdController.clear();
    emailController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Form has been cleared.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Student Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                'Successful Registrations: $registrationCount',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Student ID is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  final email = value.trim();
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: registerStudent,
                child: const Text('Register Student'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: clearForm,
                child: const Text('Clear Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
