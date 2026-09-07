import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 25 : 65,
              isMobile ? 35 : 45,
              isMobile ? 25 : 65,
              60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AboutHeader(),

                const SizedBox(height: 45),

                _AboutIntroduction(isMobile: isMobile),

                const SizedBox(height: 70),

                const _SkillsSection(),

                const SizedBox(height: 70),

                const _JourneySection(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// ABOUT HEADER
// ============================================================

class _AboutHeader extends StatelessWidget {
  const _AboutHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET TO KNOW ME',
          style: TextStyle(
            color: AppColors.teal,
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 12),

        Text(
          'ABOUT ME',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 42,
            fontWeight: FontWeight.w300,
            letterSpacing: -1,
          ),
        ),

        SizedBox(height: 14),

        _AccentLine(),
      ],
    );
  }
}

// ============================================================
// ACCENT LINE
// ============================================================

class _AccentLine extends StatelessWidget {
  const _AccentLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 2,
      color: AppColors.burgundy,
    );
  }
}

// ============================================================
// ABOUT INTRODUCTION
// ============================================================

class _AboutIntroduction extends StatelessWidget {
  final bool isMobile;

  const _AboutIntroduction({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset(
        'assets/images/a.jpeg',
        width: isMobile ? double.infinity : 360,
        height: isMobile ? 360 : 430,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: isMobile ? double.infinity : 360,
            height: isMobile ? 360 : 430,
            color: AppColors.backgroundSecondary,
            child: const Icon(
              Icons.person_outline,
              color: AppColors.grey,
              size: 70,
            ),
          );
        },
      ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Junior Flutter Developer',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'I am a Software Engineering student focused on '
          'building practical, responsive, and user-friendly '
          'applications with Flutter and Dart.',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 15,
            height: 1.8,
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'My interests extend to databases, backend and API '
          'integration, and modern AI-assisted development. '
          'I enjoy learning through practical projects and '
          'turning ideas into clean, usable interfaces.',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 15,
            height: 1.8,
          ),
        ),

        const SizedBox(height: 28),

        const Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _SkillTag('Flutter'),
            _SkillTag('Dart'),
            _SkillTag('UI/UX'),
            _SkillTag('Databases'),
            _SkillTag('REST APIs'),
            _SkillTag('AI'),
          ],
        ),
      ],
    );

    if (isMobile) {
      return Column(
        children: [
          image,
          const SizedBox(height: 35),
          content,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        const SizedBox(width: 65),
        Expanded(child: content),
      ],
    );
  }
}

// ============================================================
// SKILL TAG
// ============================================================

class _SkillTag extends StatelessWidget {
  final String text;

  const _SkillTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white.withOpacity(0.10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 11,
        ),
      ),
    );
  }
}

// ============================================================
// SKILLS SECTION
// ============================================================

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    const categories = [
      _SkillCategory(
        icon: Icons.phone_android_outlined,
        title: 'Mobile & Desktop Development',
        skills: [
          'Flutter',
          'Dart',
          'Flutter Desktop',
          'Responsive UI Development',
          'UI/UX Implementation',
        ],
      ),
      _SkillCategory(
        icon: Icons.account_tree_outlined,
        title: 'State Management & Architecture',
        skills: [
          'Provider',
          'ChangeNotifier',
          'MVC',
          'Clean Code',
          'SOLID Principles',
        ],
      ),
      _SkillCategory(
        icon: Icons.api_outlined,
        title: 'Backend & APIs',
        skills: [
          'REST APIs',
          'JSON',
          'API Integration',
          'Firebase',
          'Supabase',
          'Authentication',
        ],
      ),
      _SkillCategory(
        icon: Icons.storage_outlined,
        title: 'Databases',
        skills: [
          'SQL',
          'PostgreSQL',
          'MySQL',
          'SQLite',
          'Firebase Cloud Firestore',
          'Oracle SQL',
          'Oracle APEX',
        ],
      ),
      _SkillCategory(
        icon: Icons.auto_awesome_outlined,
        title: 'AI & Modern Development',
        skills: [
          'Generative AI',
          'LLM Integration',
          'RAG',
          'AI-assisted Development',
          'Prompt Engineering',
          'Claude AI',
          'Claude Code',
          'Model Context Protocol (MCP)',
        ],
      ),
      _SkillCategory(
        icon: Icons.build_outlined,
        title: 'Development Tools',
        skills: [
          'Git',
          'GitHub',
          'VS Code',
          'Android Studio',
          'Postman',
          'Figma',
        ],
      ),
      _SkillCategory(
        icon: Icons.bug_report_outlined,
        title: 'Testing & Development Practices',
        skills: [
          'Widget Testing',
          'Unit Testing',
          'Debugging',
          'Error Handling',
          'Version Control',
          'Clean Code Practices',
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          eyebrow: 'WHAT I WORK WITH',
          title: 'SKILLS & EXPERTISE',
        ),

        const SizedBox(height: 30),

        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1050
                ? 3
                : constraints.maxWidth >= 650
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                mainAxisExtent: 250,
              ),
              itemBuilder: (context, index) {
                return _SkillCategoryCard(
                  category: categories[index],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// SKILL CATEGORY DATA
// ============================================================

class _SkillCategory {
  final IconData icon;
  final String title;
  final List<String> skills;

  const _SkillCategory({
    required this.icon,
    required this.title,
    required this.skills,
  });
}

// ============================================================
// SKILL CATEGORY CARD
// ============================================================

class _SkillCategoryCard extends StatelessWidget {
  final _SkillCategory category;

  const _SkillCategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.burgundy.withOpacity(0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              category.icon,
              color: AppColors.teal,
              size: 23,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            category.title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Wrap(
                spacing: 7,
                runSpacing: 7,
                children: category.skills
                    .map(
                      (skill) => _SkillBadge(skill),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SKILL BADGE
// ============================================================

class _SkillBadge extends StatelessWidget {
  final String text;

  const _SkillBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.white.withOpacity(0.08),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 10.5,
          height: 1.2,
        ),
      ),
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;

  const _SectionTitle({
    required this.eyebrow,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: AppColors.teal,
            fontSize: 11,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        ),

        const SizedBox(height: 12),

        const _AccentLine(),
      ],
    );
  }
}

// ============================================================
// JOURNEY
// ============================================================

class _JourneySection extends StatelessWidget {
  const _JourneySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          eyebrow: 'MY JOURNEY',
          title: 'EDUCATION & EXPERIENCE',
        ),

        const SizedBox(height: 30),

        const _JourneyItem(
          icon: Icons.school_outlined,
          title: 'Software Engineering',
          subtitle: 'Information Technology',
          description:
              'Academic background focused on software engineering '
              'and application development.',
        ),

        const SizedBox(height: 30),

        Container(
          height: 1,
          color: AppColors.white.withOpacity(0.08),
        ),

        const SizedBox(height: 30),

        const _JourneyItem(
          icon: Icons.code_outlined,
          title: 'Software Development Training',
          subtitle: 'Namo Soft',
          description:
              'Practical training in software development with a '
              'focus on application development and modern '
              'development practices.',
        ),
      ],
    );
  }
}

// ============================================================
// JOURNEY ITEM
// ============================================================

class _JourneyItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;

  const _JourneyItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.burgundy.withOpacity(0.14),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: AppColors.teal,
            size: 22,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.teal,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 9),

              Text(
                description,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}