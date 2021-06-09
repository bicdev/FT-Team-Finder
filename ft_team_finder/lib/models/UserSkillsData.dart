class UserSkillsData {
  int be;
  int fe;
  int qa;
  int db;
  int dt;
  int st;

  UserSkillsData() {
    this.be = 1;
    this.fe = 1;
    this.qa = 1;
    this.db = 1;
    this.dt = 1;
    this.st = 1;
  }

  UserSkillsData.fromList(
      {this.be, this.fe, this.qa, this.db, this.dt, this.st});

  List<int> asList() {
    return [this.be, this.fe, this.qa, this.db, this.dt, this.st];
  }

  save(List<int> skills) {
    this.be = skills[0];
    this.db = skills[1];
    this.dt = skills[2];
    this.fe = skills[3];
    this.qa = skills[4];
    this.st = skills[5];
  }
}
