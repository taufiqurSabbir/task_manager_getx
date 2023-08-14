
class tasks {
 final String sId, title, description, status, createdDate;

  tasks(this.sId, this.title, this.description, this.status, this.createdDate);

  factory tasks.toJson(Map<String, dynamic> e) {
    return tasks(
        e['sId'], e['title'], e['description'], e['status'], e['createdDate']);
  }
}
