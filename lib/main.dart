import 'dart:html' as html;
import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'pages/projects_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';

void main() {
  runApp(const KhawlahPortfolio());
}

class KhawlahPortfolio extends StatelessWidget {
  const KhawlahPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khawlah Abdullah',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 800;

            return Center(
              child: Container(
                width: isMobile
                    ? constraints.maxWidth - 24
                    : constraints.maxWidth - 80,
                height: isMobile ? null : constraints.maxHeight - 40,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.white.withOpacity(0.18)),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: isMobile
                    ? const SingleChildScrollView(
                        child: Column(
                          children: [NavigationBar(), HeroSection()],
                        ),
                      )
                    : const Column(
                        children: [
                          NavigationBar(),
                          Expanded(child: HeroSection()),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// NAVIGATION BAR
// ============================================================

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
      child: Row(
        children: [
          Row(
            children: [
              const Text(
                'K.',
                style: TextStyle(
                  color: AppColors.teal,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'KHAWLAH',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const Spacer(),

          if (!isMobile)
            Row(
              children: [
                _NavItem(title: 'Home', active: true, onTap: () {}),
                _NavItem(
                  title: 'About',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutPage()),
                    );
                  },
                ),
                _NavItem(
                  title: 'Projects',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProjectsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

          const SizedBox(width: 25),

          if (!isMobile)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.burgundy,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Contact Me', style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// NAV ITEM
// ============================================================

class _NavItem extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: active ? AppColors.teal : AppColors.white.withOpacity(0.65),
            fontSize: 13,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HERO SECTION
// ============================================================

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 65,
        vertical: isMobile ? 30 : 15,
      ),
      child: isMobile
          ? const Column(
              children: [HeroText(), SizedBox(height: 40), HeroImage()],
            )
          : const Row(
              children: [
                Expanded(flex: 5, child: HeroText()),
                Expanded(flex: 5, child: HeroImage()),
              ],
            ),
    );
  }
}

// ============================================================
// HERO TEXT
// ============================================================

class HeroText extends StatelessWidget {
  const HeroText({super.key});

  // ============================================================
  // DOWNLOAD CV
  // ============================================================
void _downloadCV() {
  final pathname = html.window.location.pathname ?? '/';

  final basePath = pathname
      .split('/')
      .where((part) => part.isNotEmpty)
      .first;

  final cvUrl = '/$basePath/assets/assets/cv/khawlah_cv.pdf';

  final anchor = html.AnchorElement(href: cvUrl)
    ..setAttribute('download', 'khawlah_cv.pdf')
    ..style.display = 'none';

  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          "HELLO, I'M",
          style: TextStyle(
            color: AppColors.teal,
            fontSize: 14,
            letterSpacing: 4,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Khawlah\nAbdullah',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: AppColors.white,
            fontSize: isMobile ? 48 : 68,
            height: 0.95,
            fontWeight: FontWeight.w300,
            letterSpacing: -2,
          ),
        ),

        const SizedBox(height: 22),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 45, height: 2, color: AppColors.burgundy),
            const SizedBox(width: 12),
            const Text(
              'FLUTTER DEVELOPER',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 12,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        const SizedBox(height: 22),

        SizedBox(
          width: 420,
          child: Text(
            'I build clean, practical and beautiful digital '
            'experiences using Flutter, Dart and modern '
            'database technologies.',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ),

        const SizedBox(height: 32),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProjectsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.burgundy,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'View My Work',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(width: 14),

            OutlinedButton(
              onPressed: _downloadCV,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.white,
                side: BorderSide(color: AppColors.white.withOpacity(0.25)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 27,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('My CV', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// HERO IMAGE
// ============================================================

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return SizedBox(
      height: isMobile ? 500 : 560,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Burgundy shape
          Positioned(
            right: isMobile ? 10 : 35,
            top: 35,
            bottom: 25,
            width: isMobile ? 260 : 350,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.burgundy,
                borderRadius: BorderRadius.circular(180),
              ),
            ),
          ),

          // Teal outline
          Positioned(
            right: isMobile ? 0 : 10,
            top: 75,
            child: Container(
              width: isMobile ? 100 : 125,
              height: isMobile ? 300 : 370,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.teal.withOpacity(0.4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),

          // Profile image
          Positioned(
            left: isMobile ? 30 : 55,
            top: 10,
            bottom: 0,
            width: isMobile ? 270 : 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(180),
              child: Image.asset(
                'assets/images/a.jpeg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // Vertical text
          Positioned(
            right: isMobile ? 25 : 60,
            top: 150,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                'SOFTWARE DEVELOPER',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.7),
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
