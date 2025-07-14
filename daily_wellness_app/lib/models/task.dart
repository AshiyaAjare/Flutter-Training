class Task {
  final String id;
  final String name;
  final String? notes;
  final DateTime createdAt;
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    this.notes,
    required this.createdAt,
    this.isCompleted = false,
  });
}