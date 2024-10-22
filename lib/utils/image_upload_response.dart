class ImageUploadResponseData {
  int? status;
  String? fileName;
  String? fileUrl;

  ImageUploadResponseData({this.status, this.fileName, this.fileUrl});

  ImageUploadResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    fileName = json['file_name'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['file_name'] = this.fileName;
    data['file_url'] = this.fileUrl;
    return data;
  }
}