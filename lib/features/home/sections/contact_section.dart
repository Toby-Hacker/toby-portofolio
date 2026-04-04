import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toby_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/stack_icon.dart';
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
              child: Column(
                children: [
                  const _DirectContactActions(),
                  const SizedBox(height: 32),
                  Text(
                    'Or send a message',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _ContactForm(l10n: l10n),
                ],
              ),
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
    defaultValue: 'https://portfolio-api-hv2e.onrender.com/api/contact',
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

class _DirectContactActions extends StatelessWidget {
  const _DirectContactActions();

  static const _whatsAppUrl = String.fromEnvironment(
    'WHATSAPP_URL',
    defaultValue:
        'https://wa.me/2290161417254?text=Hello%20Amzath%2C%20I%20saw%20your%20portfolio.',
  );
  static const _upworkUrl = String.fromEnvironment(
    'UPWORK_URL',
    defaultValue: 'https://www.upwork.com/freelancers/~01296beb27e87bc5b0',
  );

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 720;
    final cards = [
      _DirectContactCard(
        label: 'Upwork',
        description: 'Hire me through Upwork for a structured contract',
        stackIcon: StackIcon.upwork,
        accentColor: const Color(0xFF6FDA44),
        url: _upworkUrl,
      ),
      _DirectContactCard(
        label: 'WhatsApp',
        description: 'Quick chat for project ideas and urgent questions',
        stackIcon: StackIcon.whatsapp,
        accentColor: const Color(0xFF25D366),
        url: _whatsAppUrl,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Or contact me directly',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textOnDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        if (isCompact)
          Column(
            children: [
              for (final card in cards) ...[
                card,
                if (card != cards.last) const SizedBox(height: 14),
              ],
            ],
          )
        else
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 14),
              Expanded(child: cards[1]),
            ],
          ),
      ],
    );
  }
}

class _DirectContactCard extends StatefulWidget {
  const _DirectContactCard({
    required this.label,
    required this.description,
    required this.stackIcon,
    required this.accentColor,
    required this.url,
  });

  final String label;
  final String description;
  final StackIcon stackIcon;
  final Color accentColor;
  final String url;

  @override
  State<_DirectContactCard> createState() => _DirectContactCardState();
}

class _DirectContactCardState extends State<_DirectContactCard> {
  bool _hovered = false;

  bool get _enabled => widget.url.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final accent = _enabled ? widget.accentColor : AppColors.borderOnDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.cardOnDark,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? accent : AppColors.borderOnDark,
            width: 1.2,
          ),
          boxShadow: _hovered && _enabled
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.18),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: _enabled ? () => _launch(context) : null,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.string(widget.stackIcon.svgStr),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.label,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: _enabled
                                    ? AppColors.textOnDark
                                    : AppColors.mutedOnDark,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _enabled
                          ? AppColors.textOnDark.withOpacity(0.84)
                          : AppColors.mutedOnDark,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launch(BuildContext context) async {
    final uri = Uri.tryParse(widget.url.trim());
    if (uri == null) {
      _showError(context, 'Invalid contact URL.');
      return;
    }

    final didLaunch = await launchUrl(uri, webOnlyWindowName: '_blank');
    if (!didLaunch && context.mounted) {
      _showError(context, 'Could not open ${widget.label}.');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
