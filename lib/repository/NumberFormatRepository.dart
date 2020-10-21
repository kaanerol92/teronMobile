import 'package:teronmobile/repository/ParametersRepository.dart';

class NumberFormatRepository {
  static const String TUTAR = "KUSURAT_TUTAR"; //
  static const String MIKTAR = "KUSURAT_MIKTAR"; //
  static const String BIRIMFIYAT = "KUSURAT_BIRIMFIYAT"; //
  static const String FIRE = "KUSURAT_FIRE"; //
  static const String DOVTUT = "KUSURAT_DOVTUT"; //
  static const String DOVBIRFIY = "KUSURAT_DOVBIRFIY"; //
  static const String DOVKUR = "KUSURAT_DOVKUR"; //
  static const String DIGER = "KUSURAT_DIGER"; //
  static const String INTEGER = "KUSURAT_INTEGER";
  static const String BIRIM_MIKTAR = "KUSURAT_BIRIM_MIKTAR"; //

  static int getFormat(String key) {
    String format = ParametersRepository.getParameter(key);
    return int.parse(format);
  }
}
