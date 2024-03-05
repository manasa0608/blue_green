class TreeNode<T> {
  T data;
  List<TreeNode<T>> children;
  TreeNode<T>? parent;

  TreeNode(this.data) : children = [];

  void setParent(TreeNode<T> parent) {
    this.parent = parent;
  }

  void addChild(TreeNode<T> child) {
    children.add(child);
  }
}
