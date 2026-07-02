import 'package:flutter/material.dart';

class MediaPickerSheet extends StatefulWidget {
  const MediaPickerSheet({super.key});

  @override
  State<MediaPickerSheet> createState() => _MediaPickerSheetState();
}

class _MediaPickerSheetState extends State<MediaPickerSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final Set<int> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
      } else {
        _selectedItems.add(index);
      }
    });
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 100,
      itemBuilder: (context, index) {
        final selected = _selectedItems.contains(index);

        return GestureDetector(
          onTap: () => _toggleSelection(index),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.grey.shade300,
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (selected)
                Container(color: Colors.black.withValues(alpha: 0.35)),

              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black38,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: selected
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                const SizedBox(height: 8),

                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Media',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),

                      if (_selectedItems.isNotEmpty)
                        FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(context, _selectedItems.toList());
                          },
                          icon: const Icon(Icons.send),
                          label: Text('${_selectedItems.length}'),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Photos'),
                    Tab(text: 'Videos'),
                  ],
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [_buildGrid(), _buildGrid()],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
