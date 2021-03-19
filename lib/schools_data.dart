class Schools {
  EC eC;
  EC fS;
  EC gT;
  EC kZN;
  EC lP;
  EC mP;
  EC nC;
  EC nW;
  EC wC;

  Schools(
      {this.eC,
      this.fS,
      this.gT,
      this.kZN,
      this.lP,
      this.mP,
      this.nC,
      this.nW,
      this.wC});

  Schools.fromJson(Map<String, dynamic> json) {
    eC = json['EC'] != null ? new EC.fromJson(json['EC']) : null;
    fS = json['FS'] != null ? new EC.fromJson(json['FS']) : null;
    gT = json['GT'] != null ? new EC.fromJson(json['GT']) : null;
    kZN = json['KZN'] != null ? new EC.fromJson(json['KZN']) : null;
    lP = json['LP'] != null ? new EC.fromJson(json['LP']) : null;
    mP = json['MP'] != null ? new EC.fromJson(json['MP']) : null;
    nC = json['NC'] != null ? new EC.fromJson(json['NC']) : null;
    nW = json['NW'] != null ? new EC.fromJson(json['NW']) : null;
    wC = json['WC'] != null ? new EC.fromJson(json['WC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eC != null) {
      data['EC'] = this.eC.toJson();
    }
    if (this.fS != null) {
      data['FS'] = this.fS.toJson();
    }
    if (this.gT != null) {
      data['GT'] = this.gT.toJson();
    }
    if (this.kZN != null) {
      data['KZN'] = this.kZN.toJson();
    }
    if (this.lP != null) {
      data['LP'] = this.lP.toJson();
    }
    if (this.mP != null) {
      data['MP'] = this.mP.toJson();
    }
    if (this.nC != null) {
      data['NC'] = this.nC.toJson();
    }
    if (this.nW != null) {
      data['NW'] = this.nW.toJson();
    }
    if (this.wC != null) {
      data['WC'] = this.wC.toJson();
    }
    return data;
  }
}

class EC {
  List<String> institutionName;

  EC({this.institutionName});

  EC.fromJson(Map<String, dynamic> json) {
    institutionName = json['Institution_Name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Institution_Name'] = this.institutionName;
    return data;
  }
}
