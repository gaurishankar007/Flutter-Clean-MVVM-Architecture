class const GridViewLayoutArgs({
  final int crossAxisCount = 2,
  final double childAspectRatio = 1,
  required final double crossAxisSpacing,
  required final double mainAxisSpacing,
}) {
  GridViewLayoutArgs copyWith({
    int? crossAxisCount,
    double? childAspectRatio,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
  }) {
    return GridViewLayoutArgs(
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      childAspectRatio: childAspectRatio ?? this.childAspectRatio,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
    );
  }
}
