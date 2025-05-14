class BaseResponse<T> {
  final bool success;
  final bool restore;
  final String message;
  final int? totalItem;
  final int? currentPage;
  final int? perPage;
  final T? error;
  final T? data;
  final String? status;

  BaseResponse({
    required this.success,
    required this.message,
    this.totalItem,
    this.restore = false,
    this.currentPage,
    this.perPage,
    this.error,
    this.data,
    this.status,
  });

  factory BaseResponse.fromResponse(dynamic data) {
    return BaseResponse(
      success: data['status'] == "success" ? true : false,
      message: data['message'] ?? "",
      restore: data['restore'] ?? false,
      totalItem: data['total_items'],
      currentPage: data['current_page'],
      perPage: data['per_page'],
      error: data['error'],
      data: data['data'],
      status: data['status'],
    );
  }

  BaseResponse copyWith({
    bool? success,
    String? message,
    int? totalPage,
    int? currentPage,
    int? perPage,
    T? error,
    T? data,
    String? status,
  }) {
    return BaseResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data,
      error: error,
      totalItem: totalPage ?? this.totalItem,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'BaseResponse(status: $success, message: $message, Total Items: $totalItem, Current Page: $currentPage, Per Page: $perPage, error: $error, data: $data, status: $status)';
  }
}
