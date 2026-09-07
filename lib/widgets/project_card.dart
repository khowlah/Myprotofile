import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constants/app_colors.dart';
import '../models/project_item.dart';

class ProjectCard extends StatefulWidget {
  final List<ProjectItem> projects;

  const ProjectCard({
    super.key,
    required this.projects,
  }) : assert(
          projects.length > 0,
          'projects لازم يحتوي مشروع واحد على الأقل',
        );

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  int _index = 0;

  VideoPlayerController? _controller;
  String? _currentVideoPath;
  bool _isLoading = true;
  bool _hasVideoError = false;

  ProjectItem get _current => widget.projects[_index];

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  // ============================================================
  // VIDEO
  // ============================================================

  Future<void> _loadVideo() async {
    final String videoPath = _current.videoPath;

    if (mounted) {
      setState(() {
        _isLoading = true;
        _hasVideoError = false;
      });
    }

    await _controllerDispose();

    _currentVideoPath = videoPath;

    final controller = VideoPlayerController.asset(videoPath);

    _controller = controller;

    try {
      await controller.initialize();

      if (!mounted || _controller != controller) {
        await controller.dispose();
        return;
      }

      await controller.setLooping(true);

      setState(() {
        _isLoading = false;
        _hasVideoError = false;
      });
    } catch (e) {
      debugPrint('Video error: $e');

      if (!mounted || _controller != controller) {
        await controller.dispose();
        return;
      }

      setState(() {
        _isLoading = false;
        _hasVideoError = true;
      });
    }
  }

  Future<void> _controllerDispose() async {
    final controller = _controller;

    _controller = null;
    _currentVideoPath = null;

    if (controller != null) {
      await controller.dispose();
    }
  }

  Future<void> _goTo(int newIndex) async {
    if (!mounted || newIndex == _index) return;

    setState(() {
      _index = newIndex;
    });

    await _loadVideo();
  }

  void _toggleVideo() {
    final controller = _controller;

    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.hasError) {
      return;
    }

    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  @override
  void dispose() {
    final controller = _controller;

    _controller = null;

    controller?.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 700;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.burgundy.withOpacity(0.25),
                blurRadius: 40,
                spreadRadius: -8,
                offset: const Offset(0, 24),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: isCompact
              ? Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 250,
                      child: _buildVisualSide(),
                    ),
                    const SizedBox(height: 20),
                    _buildContentSide(isCompact: true),
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildVisualSide(),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 15),
                            Expanded(
                              child: _buildContentSide(
                                isCompact: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.code_rounded,
          color: AppColors.teal,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          'MY PROJECTS',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 12,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        _circleIconButton(Icons.grid_view_rounded),
        const SizedBox(width: 8),
        _circleIconButton(Icons.more_horiz_rounded),
      ],
    );
  }

  Widget _circleIconButton(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
      ),
      child: Icon(
        icon,
        size: 15,
        color: AppColors.grey,
      ),
    );
  }

  // ============================================================
  // VIDEO SIDE
  // ============================================================

  Widget _buildVisualSide() {
    final controller = _controller;

    final bool isInitialized =
        controller != null &&
        controller.value.isInitialized &&
        !controller.value.hasError;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        ..._decorativeDots(),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(_index),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.burgundyLight.withOpacity(0.4),
                width: 1.5,
              ),
              color: AppColors.background,
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildVideoContent(
                  controller: controller,
                  isInitialized: isInitialized,
                ),

                if (isInitialized)
                  GestureDetector(
                    onTap: _toggleVideo,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: controller.value.isPlaying ? 0.0 : 1.0,
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: const BoxDecoration(
                          color: AppColors.burgundy,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                          size: 34,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // VIDEO CONTENT
  // ============================================================

  Widget _buildVideoContent({
    required VideoPlayerController? controller,
    required bool isInitialized,
  }) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.teal,
        ),
      );
    }

    if (_hasVideoError ||
        controller == null ||
        controller.value.hasError) {
      return _buildVideoError();
    }

    if (!isInitialized) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.teal,
        ),
      );
    }

    final double aspectRatio = controller.value.aspectRatio > 0
        ? controller.value.aspectRatio
        : 16 / 9;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }

  Widget _buildVideoError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_library_outlined,
              color: AppColors.grey,
              size: 42,
            ),
            const SizedBox(height: 12),
            const Text(
              'Video unavailable',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'The project preview could not be loaded.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DECORATIVE DOTS
  // ============================================================

  List<Widget> _decorativeDots() {
    const positions = [
      Alignment(-0.9, -0.8),
      Alignment(0.8, -0.9),
      Alignment(-0.7, 0.85),
      Alignment(0.9, 0.7),
      Alignment(0.0, -1.0),
    ];

    return positions
        .map(
          (alignment) => Align(
            alignment: alignment,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey.withOpacity(0.35),
              ),
            ),
          ),
        )
        .toList();
  }

  // ============================================================
  // CONTENT SIDE
  // ============================================================

  Widget _buildContentSide({
    required bool isCompact,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isCompact
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        // Number
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            '0${_index + 1}',
            key: ValueKey('number_$_index'),
            style: const TextStyle(
              color: AppColors.teal,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Category
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            _current.category.toUpperCase(),
            key: ValueKey('category_$_index'),
            style: TextStyle(
              color: AppColors.grey.withOpacity(0.7),
              fontSize: 11,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Title
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            _current.title,
            key: ValueKey('title_$_index'),
            style: TextStyle(
              color: AppColors.white,
              fontSize: isCompact ? 28 : 34,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Description
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            _current.description,
            key: ValueKey('description_$_index'),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 13.5,
              height: 1.6,
            ),
          ),
        ),

        const SizedBox(height: 22),

        // Button
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: _toggleVideo,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: AppColors.burgundy,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.white,
                  size: 18,
                ),
                SizedBox(width: 7),
                Text(
                  'Watch Project',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Dots
        Row(
          children: List.generate(
            widget.projects.length,
            (i) {
              final bool active = i == _index;

              return GestureDetector(
                onTap: () => _goTo(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  width: active ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.teal
                        : AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}