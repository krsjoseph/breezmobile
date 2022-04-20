import 'package:breez/services/breezlib/data/rpc.pb.dart';
import 'package:flutter/cupertino.dart';

extension LnurlMetadata on List<LNUrlPayMetadata> {
  String metadataText() {
    final textSource = firstWhere(
      (e) => e.hasDescription(),
      orElse: () => null,
    );
    if (textSource == null) return "";
    return textSource.description;
  }

  Image metadataImage() {
    final imageSource = firstWhere(
      (e) => e.hasImage(),
      orElse: () => null,
    );
    if (imageSource == null) return null;
    return Image.memory(imageSource.image.bytes);
  }
}
