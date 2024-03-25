class GenericComponent<T> {
  T data;
  List<T> lowerComponents;
  List<T> higherComponents;
  T id;

  GenericComponent(this.data, this.lowerComponents, this.higherComponents, this.id);
}
