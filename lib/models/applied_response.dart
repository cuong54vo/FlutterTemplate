class AppliedResponse {
  int? currentPage;
  List<AppliedData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AppliedResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory AppliedResponse.fromJson(Map<String, dynamic> json) {
    return AppliedResponse(
      currentPage: json['current_page'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => AppliedData.fromJson(item as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((v) => v.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }

  AppliedResponse addNextDataList(AppliedResponse nextResponse) {
    final List<AppliedData> oldItems = data ?? [];
    final List<AppliedData> newItems = [...oldItems, ...?nextResponse.data];
    nextResponse.data = newItems;
    return nextResponse;
  }
}

class AppliedData {
  int jobId;
  String jobTitle;
  String jobDescription;
  String addrFull;
  String addrStreet;
  String addrDistrict;
  String addrState;
  String addrPostalcode;
  String addrLat;
  String addrLng;
  int positionId;
  String positionTitle;
  int numberSeeker;
  int skilled;
  String timeStartWork;
  String timeEndWork;
  int hoursPerDay;
  String startDate;
  String endDate;
  List<dynamic> daysInWeek;
  String payType;
  int payRate;
  String payTypeName; // Đã thêm lại trường này
  double branchPayRate;
  String branchNote;
  String lastApplyDate;
  String clientName;
  String clientLogo;
  String seekerStatus;
  int favorite;
  int filled;
  int payRateTo;
  bool payRateHidden;
  String payRateLabel;
  String rateLabel;

  AppliedData({
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
    required this.addrFull,
    required this.addrStreet,
    required this.addrDistrict,
    required this.addrState,
    required this.addrPostalcode,
    required this.addrLat,
    required this.addrLng,
    required this.positionId,
    required this.positionTitle,
    required this.numberSeeker,
    required this.skilled,
    required this.timeStartWork,
    required this.timeEndWork,
    required this.hoursPerDay,
    required this.startDate,
    required this.endDate,
    required this.daysInWeek,
    required this.payType,
    required this.payRate,
    required this.branchPayRate,
    required this.branchNote,
    required this.lastApplyDate,
    required this.clientName,
    required this.clientLogo,
    required this.seekerStatus,
    required this.favorite,
    required this.filled,
    required this.payRateTo,
    required this.payRateHidden,
    required this.payRateLabel,
    required this.rateLabel,
  }) : payTypeName = _mapPayTypeName(payType); // Khởi tạo payTypeName ở đây

  factory AppliedData.fromJson(Map<String, dynamic> json) {
    return AppliedData(
      jobId: json['job_id'],
      jobTitle: json['job_title'],
      jobDescription: json['job_description'],
      addrFull: json['addr_full'],
      addrStreet: json['addr_street'],
      addrDistrict: json['addr_district'],
      addrState: json['addr_state'],
      addrPostalcode: json['addr_postalcode'],
      addrLat: json['addr_lat'],
      addrLng: json['addr_lng'],
      positionId: json['position_id'],
      positionTitle: json['position_title'],
      numberSeeker: json['number_seeker'],
      skilled: json['skilled'],
      timeStartWork: json['time_start_work'],
      timeEndWork: json['time_end_work'],
      hoursPerDay: json['hours_per_day'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      daysInWeek: json['days_in_week'],
      payType: json['pay_type'],
      payRate: json['pay_rate'],
      branchPayRate: (json['branch_pay_rate'] as num?)?.toDouble() ?? 0.0,
      branchNote: json['branch_note'],
      lastApplyDate: json['last_apply_date'],
      clientName: json['client_name'],
      clientLogo: json['client_logo'],
      seekerStatus: json['seeker_status'],
      favorite: json['favorite'],
      filled: json['filled'],
      payRateTo: json['pay_rate_to'],
      payRateHidden: json['pay_rate_hidden'] == 1,
      payRateLabel: json['pay_rate_label'],
      rateLabel: json['rate_label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'job_title': jobTitle,
      'job_description': jobDescription,
      'addr_full': addrFull,
      'addr_street': addrStreet,
      'addr_district': addrDistrict,
      'addr_state': addrState,
      'addr_postalcode': addrPostalcode,
      'addr_lat': addrLat,
      'addr_lng': addrLng,
      'position_id': positionId,
      'position_title': positionTitle,
      'number_seeker': numberSeeker,
      'skilled': skilled,
      'time_start_work': timeStartWork,
      'time_end_work': timeEndWork,
      'hours_per_day': hoursPerDay,
      'start_date': startDate,
      'end_date': endDate,
      'days_in_week': daysInWeek,
      'pay_type': payType,
      'pay_rate': payRate,
      'branch_pay_rate': branchPayRate,
      'branch_note': branchNote,
      'last_apply_date': lastApplyDate,
      'client_name': clientName,
      'client_logo': clientLogo,
      'seeker_status': seekerStatus,
      'favorite': favorite,
      'filled': filled,
      'pay_rate_to': payRateTo,
      'pay_rate_hidden': payRateHidden ? 1 : 0,
      'pay_rate_label': payRateLabel,
      'rate_label': rateLabel,
    };
  }

  static String _mapPayTypeName(String payTypeKey) {
    switch (payTypeKey) {
      case "hour":
        return 'Giờ';
      case "bi_week":
        return 'Hai tuần';
      case "month":
        return 'Tháng';
      case "year":
        return 'Năm';
      default:
        return '';
    }
  }
}
