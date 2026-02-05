import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glow_button.dart';
import '../../../core/widgets/max_width.dart';
import '../../../core/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 90),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Get In Touch',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              dark: true,
            ),
            const SizedBox(height: 34),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: const _ContactForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LabeledField(
          label: 'Email',
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Please enter your email'),
          ),
        ),
        const SizedBox(height: 16),
        _LabeledField(
          label: 'Mobile',
          child: TextField(
            controller: _mobileController,
            decoration: const InputDecoration(hintText: 'Enter mobile'),
          ),
        ),
        const SizedBox(height: 16),
        _LabeledField(
          label: 'Message',
          child: TextField(
            controller: _messageController,
            maxLines: 6,
            decoration: const InputDecoration(hintText: 'Enter your message'),
          ),
        ),
        const SizedBox(height: 20),
        GlowButton(
          label: 'Submit',
          onPressed: () {},
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textOnDark,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
