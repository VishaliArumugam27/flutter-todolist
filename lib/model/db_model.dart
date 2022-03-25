

class Taskclass{
  int? id;
  String? task;

  toMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['task'] = task;
    return map;
  }
}

