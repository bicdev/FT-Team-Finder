import 'UserProfileData.dart';

class Groups {
  int groupID;
  String name;
  String description;
  UserProfileData leader;
  List<UserProfileData> members = List.empty(growable: true);

  Groups({this.groupID, this.name, this.description, this.leader, this.members});

  addMember(UserProfileData member){
    this.members.add(member);
  }

  List<UserProfileData> getAllMembers(){
    List<UserProfileData> l;
    l.add(this.leader);
    l.addAll(this.members);
    return l;
  }
  
}