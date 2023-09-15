class Task {
  late final String title;
  late bool done;

  Task(this.title, {this.done = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }
}
