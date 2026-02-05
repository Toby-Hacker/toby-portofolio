import 'package:flutter/material.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glow_button.dart';
import '../../../core/widgets/max_width.dart';
import '../../../core/widgets/section_header.dart';

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
    final l10n = widget.l10n;
    final fieldStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF111111),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LabeledField(
          label: l10n.contact_email_label,
          child: TextField(
            controller: _emailController,
            style: fieldStyle,
            decoration: InputDecoration(hintText: l10n.contact_email_hint),
          ),
        ),
        const SizedBox(height: 16),
        _LabeledField(
          label: l10n.contact_mobile_label,
          child: TextField(
            controller: _mobileController,
            style: fieldStyle,
            decoration: InputDecoration(hintText: l10n.contact_mobile_hint),
          ),
        ),
        const SizedBox(height: 16),
        _LabeledField(
          label: l10n.contact_message_label,
          child: TextField(
            controller: _messageController,
            maxLines: 6,
            style: fieldStyle,
            decoration: InputDecoration(hintText: l10n.contact_message_hint),
          ),
        ),
        const SizedBox(height: 20),
        GlowButton(
          label: l10n.contact_submit,
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
