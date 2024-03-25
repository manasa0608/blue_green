abstract class GenericComponentRepository<GenericComponent> {
  void sortComponents(List<GenericComponent> components);

  void addComponentToDatabase(GenericComponent component);

  void deleteComponentToDatabase(GenericComponent component);

  void generateComponents(List<GenericComponent> components);

  Future<List<GenericComponent>> getAllComponents();
}
