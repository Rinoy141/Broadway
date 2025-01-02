class Job {
  final String title;
  final String description;

  Job({required this.title, required this.description});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
    );
  }
}
