extension SwitchItem<T> on List<T> {
  void toggle(T item) {
    if (contains(item)) {
      remove(item);
    } else {
      add(item);
    }
  }
}
