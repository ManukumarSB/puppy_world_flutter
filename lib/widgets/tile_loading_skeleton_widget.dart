import 'package:flutter/material.dart';
import 'skeleton_widget.dart';

class TileLoadingSkeletonWidget extends StatelessWidget {
  final int numberOfSkeleton;

  TileLoadingSkeletonWidget([this.numberOfSkeleton = 1]);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => _buildOneActionSkeleton(),
      separatorBuilder: (_, __) => _buildDivider(),
      itemCount: numberOfSkeleton,
    );
  }

  SizedBox _buildDivider() {
    return const SizedBox(
      height: 16,
    );
  }

  Container _buildOneActionSkeleton() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 8),
          SkeletonWidget(
            height: 120,
          ),
        ],
      ),
    );
  }
}
