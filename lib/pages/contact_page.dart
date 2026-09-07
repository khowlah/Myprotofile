
 import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 70,
            vertical: 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BackButton(),

                  const SizedBox(height: 45),

                  _Header(isMobile: isMobile),

                  const SizedBox(height: 45),

                  _ContactCard(isMobile: isMobile),

                  const SizedBox(height: 30),

                  _AvailabilityCard(isMobile: isMobile),

                  const SizedBox(height: 45),

                  Center(
                    child: Text(
                      '© 2026 Khawlah Abdullah',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
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
}

// ------------------------------------------------------------
// Back Button
// ------------------------------------------------------------

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_rounded),
      color: AppColors.white,
    );
  }
}

// ------------------------------------------------------------
// Header
// ------------------------------------------------------------

class _Header extends StatelessWidget {
  final bool isMobile;

  const _Header({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let’s Connect',
          style: TextStyle(
            color: AppColors.white,
            fontSize: isMobile ? 38 : 54,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Text(
            'Have a project in mind, a question, or just want to say hello?',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: isMobile ? 16 : 18,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// Main Contact Card
// ------------------------------------------------------------

class _ContactCard extends StatelessWidget {
  final bool isMobile;

  const _ContactCard({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 25 : 42),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.burgundy.withOpacity(0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: isMobile
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Introduction(),
                SizedBox(height: 40),
                _ContactInformation(),
              ],
            )
          : const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _Introduction(),
                ),
                SizedBox(width: 70),
                Expanded(
                  child: _ContactInformation(),
                ),
              ],
            ),
    );
  }
}

// ------------------------------------------------------------
// Introduction
// ------------------------------------------------------------

class _Introduction extends StatelessWidget {
  const _Introduction();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GreetingIcon(),

        SizedBox(height: 25),

        Text(
          'Hello, I’m Khawlah.',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),

        SizedBox(height: 16),

        Text(
          'I’m a Flutter Developer focused on building clean, '
          'responsive, and user-friendly applications.',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            height: 1.7,
          ),
        ),

        SizedBox(height: 18),

        Text(
          'I’m interested in creating useful digital products '
          'and working on meaningful ideas.',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// Greeting Icon
// ------------------------------------------------------------

class _GreetingIcon extends StatelessWidget {
  const _GreetingIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.burgundy.withOpacity(0.15),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.burgundy.withOpacity(0.25),
        ),
      ),
      child: const Icon(
        Icons.waving_hand_rounded,
        color: AppColors.teal,
        size: 30,
      ),
    );
  }
}

// ------------------------------------------------------------
// Contact Information
// ------------------------------------------------------------

class _ContactInformation extends StatelessWidget {
  const _ContactInformation();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 25),

        _ContactItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'khawlahalhebshi@gmail.com',
        ),

        SizedBox(height: 18),

        _ContactItem(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: 'Yemen',
        ),

        SizedBox(height: 18),

        _ContactItem(
          icon: Icons.code_rounded,
          title: 'Specialization',
          value: 'Flutter Developer',
        ),

        SizedBox(height: 30),

        _EmailButton(),
      ],
    );
  }
}

// ------------------------------------------------------------
// Contact Item
// ------------------------------------------------------------

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.burgundy.withOpacity(0.12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: AppColors.teal,
            size: 21,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// Email Button
// ------------------------------------------------------------

class _EmailButton extends StatelessWidget {
  const _EmailButton();

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'khawlahalhebshi@gmail.com',
      queryParameters: {
        'subject': 'Portfolio Contact',
        'body': 'Hello Khawlah,\n\nI would like to get in touch with you.',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _sendEmail,
        icon: const Icon(Icons.mail_outline_rounded),
        label: const Text(
          'Send Me a Message',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.burgundy,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// Availability
// ------------------------------------------------------------

class _AvailabilityCard extends StatelessWidget {
  final bool isMobile;

  const _AvailabilityCard({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 25),
      decoration: BoxDecoration(
        color: AppColors.teal.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.teal.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              'Currently open to freelance projects, collaborations, '
              'and new opportunities.',
              style: TextStyle(
                color: AppColors.white,
                fontSize: isMobile ? 14 : 15,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}