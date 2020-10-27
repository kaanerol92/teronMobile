import 'package:teronmobile/repository/ParametersRepository.dart';

class NumberFormatRepository {
  static const String KUSURAT_TUTAR = "KUSURAT_TUTAR"; //
  static const String KUSURAT_MIKTAR = "KUSURAT_MIKTAR"; //
  static const String KUSURAT_BIRIMFIYAT = "KUSURAT_BIRIMFIYAT"; //
  static const String KUSURAT_FIRE = "KUSURAT_FIRE"; //
  static const String KUSURAT_DOVTUT = "KUSURAT_DOVTUT"; //
  static const String KUSURAT_DOVBIRFIY = "KUSURAT_DOVBIRFIY"; //
  static const String KUSURAT_DOVKUR = "KUSURAT_DOVKUR"; //
  static const String KUSURAT_DIGER = "KUSURAT_DIGER"; //
  static const String KUSURAT_INTEGER = "KUSURAT_INTEGER";
  static const String KUSURAT_BIRIM_MIKTAR = "KUSURAT_BIRIM_MIKTAR"; //

  static int getFormat(String key) {
    String format = ParametersRepository.getParameter(key);
    return int.parse(format);
  }
}
