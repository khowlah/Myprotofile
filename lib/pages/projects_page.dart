import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/project_item.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'Luxestep',
      description:
          'A Flutter application  e commerce used provider for state mangment and firebase for data it is consist of tow app one for customer and one for seller this is the custoner app.',
      videoPath: 'assets/videos/project1.mp4',
      category: 'Flutter all platform',
    ),

    ProjectItem(
      title: 'chat with your docounents ',
      description:
          'A local RAG-powered PDF assistant built with Flutter and FastAPI. It combines semantic document retrieval, Sentence Transformers embeddings, cosine similarity, and a local Qwen LLM to answer questions strictly from uploaded PDF content, with an additional validation layer to improve answer reliability.',
      videoPath: 'assets/videos/project2.mp4',
      category: 'AI / RAG · Flutter Desktop',
    ),

   ProjectItem(
      title: 'Salawat App',
      description:
          'An electronic Salawat counter (tasbih) app for the Prophet ﷺ, featuring a '
          'personal counter and a shared global counter synced in real time via Firebase.',
      videoPath: 'assets/videos/project3.mp4',
      category: 'Flutter web app',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Projects',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 950,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MY WORK',
                  style: TextStyle(
                    color: AppColors.teal,
                    fontSize: 13,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Selected Projects',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'A collection of projects I have designed and developed.',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                ProjectCard(
                  projects: projects,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}