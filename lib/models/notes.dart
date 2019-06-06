class Note {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority, _color;

  Note(this._title, this._date, this._priority, this._color,
      [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority, this._color,
      [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  int get color => _color;

  String get date => _date;

  Note.fromJson(Map<String, dynamic> json) {
    this._title = json['title'];
    this._description = json['description'];
  }

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 3) {
      this._priority = newPriority;
    }
  }

  set color(int newColor) {
    if (newColor >= 0 && newColor <= 9) {
      this._color = newColor;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }
}
