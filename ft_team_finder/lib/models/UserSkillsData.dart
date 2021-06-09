class UserSkillsData {
  int backEnd;
  int frontEnd;
  int qualityAssurance;
  int dataBase;
  int designThinking;
  int scientificThinking;

  UserSkillsData() {
    this.backEnd = 1;
    this.frontEnd = 1;
    this.qualityAssurance = 1;
    this.dataBase = 1;
    this.designThinking = 1;
    this.scientificThinking = 1;
  }

  UserSkillsData.fromList(
      {this.backEnd,
      this.frontEnd,
      this.qualityAssurance,
      this.dataBase,
      this.designThinking,
      this.scientificThinking});

  List<int> asList() {
    return [
      this.backEnd,
      this.frontEnd,
      this.qualityAssurance,
      this.dataBase,
      this.designThinking,
      this.scientificThinking
    ];
  }

  save(List<int> skills) {
    this.backEnd = skills[0];
    this.dataBase = skills[1];
    this.designThinking = skills[2];
    this.frontEnd = skills[3];
    this.qualityAssurance = skills[4];
    this.scientificThinking = skills[5];
  }
}
