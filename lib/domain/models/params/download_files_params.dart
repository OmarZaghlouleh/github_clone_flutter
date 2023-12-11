import 'package:equatable/equatable.dart';

class DownloadFilesParams extends Equatable {
  final List<String> filesKeys;

  const DownloadFilesParams({
    required this.filesKeys,
  });

  Map<String, dynamic> toJson() => {
        'files_keys': filesKeys,
      };

  @override
  List<Object> get props {
    return [filesKeys];
  }
}
