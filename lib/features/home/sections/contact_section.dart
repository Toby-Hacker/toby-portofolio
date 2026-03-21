import 'package:flutter/material.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glow_button.dart';
import '../../../core/widgets/max_width.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/services/resend_email_service.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 90),
      child: MaxWidth(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            SectionHeader(
              title: l10n.contact_title,
              subtitle: l10n.contact_subtitle,
              dark: true,
            ),
            const SizedBox(height: 34),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: _ContactForm(l10n: l10n),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  final AppLocalizations l10n;

  const _ContactForm({required this.l10n});

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  static const _contactApiUrl = String.fromEnvironment(
    'CONTACT_API_URL',
    defaultValue: 'http://localhost:5000/api/contact',
  );

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _messageController = TextEditingController();
  late final ResendEmailService _emailService = ResendEmailService(
    endpoint: _contactApiUrl,
  );
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    _emailService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final fieldStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF111111));
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LabeledField(
            label: l10n.contact_email_label,
            child: TextFormField(
              controller: _emailController,
              style: fieldStyle,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              decoration: InputDecoration(hintText: l10n.contact_email_hint),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: l10n.contact_mobile_label,
            child: TextFormField(
              controller: _mobileController,
              style: fieldStyle,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: l10n.contact_mobile_hint),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: l10n.contact_message_label,
            child: TextFormField(
              controller: _messageController,
              maxLines: 6,
              style: fieldStyle,
              validator: _validateMessage,
              decoration: InputDecoration(hintText: l10n.contact_message_hint),
            ),
          ),
          const SizedBox(height: 20),
          GlowButton(
            label: _isSubmitting ? 'Sending...' : l10n.contact_submit,
            onPressed: _isSubmitting ? null : _submit,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    final message = value?.trim() ?? '';
    if (message.isEmpty) return 'Message is required';
    if (message.length < 10) return 'Message is too short';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isSubmitting = true);

    try {
      await _emailService.sendContactMessage(
        replyToEmail: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (!mounted) return;

      _emailController.clear();
      _mobileController.clear();
      _messageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to send message: $error')));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
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
