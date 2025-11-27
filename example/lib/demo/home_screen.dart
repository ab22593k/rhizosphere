import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _announcement = '';
  final _textController = TextEditingController();

  void _announce() {
    setState(() {
      _announcement = 'Button pressed at ${DateTime.now()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rhizosphere Demo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to Rhizosphere'),
              const SizedBox(height: 20),
              AccessibleTextField(
                label: 'Username',
                hint: 'Enter your username',
                controller: _textController,
              ),
              const SizedBox(height: 20),
              AccessibleButton(
                label: 'Press Me',
                semanticLabel: 'Announce time',
                onPressed: _announce,
              ),
              const SizedBox(height: 20),
              if (_announcement.isNotEmpty)
                LiveAnnouncer(
                  message: _announcement,
                  child: Text(_announcement),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
