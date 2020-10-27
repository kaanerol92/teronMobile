import 'dart:convert';

import 'package:teronmobile/interface/LoginInterface.dart';

class ParametersRepository {
  static Map parameters;

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
  static const String STOK_CARI_ENT_TYPE = "STOK_CARI_ENT_TYPE"; //
  static const String PISC_FIS_CARI_ENT_TYPE = "PISC_FIS_CARI_ENT_TYPE"; //
  static const String KESIM_PASTAL_TYPE = "KESIM_PASTAL_TYPE"; //
  static const String PISC_FIS_GIDEN_ADET_CHECK_TYPE = "PISC_FIS_GIDEN_ADET_CHECK_TYPE"; //
  static const String PISC_FIS_GELEN_ADET_CHECK_TYPE = "PISC_FIS_GELEN_ADET_CHECK_TYPE"; //
  static const String PISC_FIS_ONMLY_FIYAT_CHECK_TYPE = "PISC_FIS_ONMLY_FIYAT_CHECK_TYPE"; //
  static const String PISC_FIS_FIYAT_ANLS_CHECK_TYPE = "PISC_FIS_FIYAT_ANLS_CHECK_TYPE"; //
  static const String STOK_FIYAT_AKTAR_TYPE = "STOK_FIYAT_AKTAR_TYPE";
  static const String STOK_FIS_MIKTAR_CHECK_TYPE = "STOK_FIS_MIKTAR_CHECK_TYPE";
  static const String STOK_FIS_PARTI_MIKTAR_CHECK_TYPE = "STOK_FIS_PARTI_MIKTAR_CHECK_TYPE";
  static const String STOK_FIS_TAHSIS_ACCEPT_TYPE = "STOK_FIS_TAHSIS_ACCEPT_TYPE";
  static const String PISC_FIS_FIYAT_AKTAR_TYPE = "PISC_FIS_FIYAT_AKTAR_TYPE"; //
  static const String PISC_FIS_URT_PLAN_FIYAT_COPY_TYPE = "PISC_FIS_URT_PLAN_FIYAT_COPY_TYPE"; //
  static const String PISC_FIS_BRM_FYT_TYPE = "PISC_FIS_BRM_FYT_TYPE"; //
  static const String SIP_FIS_TAHSIS_ACCEPT_TYPE = "SIP_FIS_TAHSIS_ACCEPT_TYPE"; //
  static const String ON_MALIYET_DATA_NAV_TYPE = "ON_MALIYET_DATA_NAV_TYPE";
  static const String ON_MALIYET_HESAP_TYPE = "ON_MALIYET_HESAP_TYPE";
  static const String ORDER_KARLILIK_LIST_RATE_TYPE = "ORDER_KARLILIK_LIST_RATE_TYPE";
  static const String ON_MALIYET_FIRE_DEFAULT_VALUE = "ON_MALIYET_FIRE_DEFAULT_VALUE";
  static const String ON_MALIYET_GENEL_GIEDR_DEFAULT_VALUE = "ON_MALIYET_GENEL_GIEDR_DEFAULT_VALUE";
  static const String ON_MALIYET_DIGER_GIDER_DEFAULT_VALUE = "ON_MALIYET_DIGER_GIDER_DEFAULT_VALUE";
  static const String ON_MALIYET_HESAPLANAN_KAR_DEFAULT_VALUE = "ON_MALIYET_HESAPLANAN_KAR_DEFAULT_VALUE";
  static const String ON_MALIYET_KOMISYON_DEFAULT_VALUE = "ON_MALIYET_KOMISYON_DEFAULT_VALUE";
  static const String FATURA_MUH_ENT_TYPE = "FATURA_MUH_ENT_TYPE";
  static const String CARI_MUH_ENT_TYPE = "CARI_MUH_ENT_TYPE";
  static const String FATURA_CARI_ENT_TYPE = "FATURA_CARI_ENT_TYPE";
  static const String KPL_FATURA_MUH_ENT_TYPE = "KPL_FATURA_MUH_ENT_TYPE";
  static const String CEK_SENET_CARI_ENT_TYPE = "CEK_SENET_CARI_ENT_TYPE";
  static const String CEK_SENET_MUH_ENT_TYPE = "CEK_SENET_MUH_ENT_TYPE";
  static const String CEK_SENET_MUH_ENT_MAS_DTY_TYPE = "CEK_SENET_MUH_ENT_MAS_DTY_TYPE";
  static const String CEK_SENET_CARI_ENT_MAS_DTY_TYPE = "CEK_SENET_CARI_ENT_MAS_DTY_TYPE";
  static const String FATURA_CARI_ISC_ENT_DETAY_TYPE = "FATURA_CARI_ISC_ENT_DETAY_TYPE";
  static const String FATURA_CARI_STOK_ENT_DETAY_TYPE = "FATURA_CARI_STOK_ENT_DETAY_TYPE";
  static const String KOMISYON_MALIYET_TYPE = "KOMISYON_MALIYET_TYPE";
  static const String REKLAMASYON_MALIYET_TYPE = "REKLAMASYON_MALIYET_TYPE";
  static const String OTOMATIK_GENEL_GIDER_CARI_KOD = "OTOMATIK_GENEL_GIDER_CARI_KOD";
  static const String ON_MALIYET_GENEL_GIDER_ORAN = "ON_MALIYET_GENEL_GIDER_ORAN";
  static const String KUMAS_KESIME_SEVK_TYPE = "KUMAS_KESIME_SEVK_TYPE"; //
  static const String KUMAS_KESIMDEN_IADE_TYPE = "KUMAS_KESIMDEN_IADE_TYPE";
  static const String AKSESUAR_URETIME_SEVK_TYPE = "AKSESUAR_URETIME_SEVK_TYPE"; //
  static const String AKSESUAR_URETIMDEN_IADE_TYPE = "AKSESUAR_URETIMDEN_IADE_TYPE"; //
  static const String TRIKO_URETIME_SEVK_TYPE = "TRIKO_URETIME_SEVK_TYPE"; //
  static const String TRIKO_URETIMDEN_IADE_TYPE = "TRIKO_URETIMDEN_IADE_TYPE"; //
  static const String BOYAYA_HAM_KUMAS_SEVK_TYPE = "BOYAYA_HAM_KUMAS_SEVK_TYPE";
  static const String KESIM_KALAN_TYPE = "KESIM_KALAN_TYPE"; //
  static const String SARF_FISI_CARI_KOD = "SARF_FISI_CARI_KOD";
  static const String SARF_FISI_DEPO_KOD = "SARF_FISI_DEPO_KOD";
  static const String FIRE_FISI_CARI_KOD = "FIRE_FISI_CARI_KOD";
  static const String FIRE_FISI_DEPO_KOD = "FIRE_FISI_DEPO_KOD";
  static const String URETIM_ANALIZ_STOK_ENT_TYPE = "URETIM_ANALIZ_STOK_ENT_TYPE";
  static const String SEVKIYAT_STOK_ENT_TYPE = "SEVKIYAT_STOK_ENT_TYPE"; //
  static const String IPLIK_ORMEYE_IPLIK_CIKIS_TYPE = "IPLIK_ORMEYE_IPLIK_CIKIS_TYPE";
  static const String SIPARIS_OVER_TEDARIK_TYPE = "SIPARIS_OVER_TEDARIK_TYPE";
  static const String TRIKO_FATURA_ENT_STOK_KOD = "TRIKO_FATURA_ENT_STOK_KOD"; //
  static const String DOVIZ_KUR_CRT_TYPE = "DOVIZ_KUR_CRT_TYPE";
  static const String DOVIZ_KUR_ENV_TYPE = "DOVIZ_KUR_ENV_TYPE";
  static const String VARYANT_CHECK_TYPE = "VARYANT_CHECK_TYPE";
  static const String ORDER_DURUM_CHECK_TYPE = "ORDER_DURUM_CHECK_TYPE";
  static const String KUMAS_TEDARIK_KESIM_FAZLASI = "KUMAS_TEDARIK_KESIM_FAZLASI";
  static const String AKSESUAR_TEDARIK_KESIM_FAZLASI = "AKSESUAR_TEDARIK_KESIM_FAZLASI";
  static const String TRIKO_TEDARIK_KESIM_FAZLASI = "TRIKO_TEDARIK_KESIM_FAZLASI";
  static const String ACIK_SIPARIS_GUNLUK_KUR_AKTAR = "ACIK_SIPARIS_GUNLUK_KUR_AKTAR"; //
  static const String PISC_FATURA_ENT_TYPE = "PISC_FATURA_ENT_TYPE";
  static const String OTOMATIK_GELEN_TAHSIS_ADET_TYPE = "OTOMATIK_GELEN_TAHSIS_ADET_TYPE";
  static const String OTOMATIK_GELEN_TAHSIS_VRY_TYPE = "OTOMATIK_GELEN_TAHSIS_VRY_TYPE";
  static const String PISC_FIS_GIDEN_ORME_ADET_CHECK_TYPE = "PISC_FIS_GIDEN_ORME_ADET_CHECK_TYPE"; //
  static const String URETIME_CIKIS_FATURALASTIRMA_TYPE = "URETIME_CIKIS_FATURALASTIRMA_TYPE";
  static const String LOG_MUH_FIS = "LOG_MUH_FIS";
  static const String TRIKO_ACTIVE_TYPE = "TRIKO_ACTIVE_TYPE"; //
  static const String CEKI_KESIM_ADET_CHECK_TYPE = "CEKI_KESIM_ADET_CHECK_TYPE"; //
  static const String URETIM_ANALIZ_KESIM_ADET_CHECK_TYPE = "URETIM_ANALIZ_KESIM_ADET_CHECK_TYPE";
  static const String INDIRILECEK_KDV_MIKTAR_TYPE = "INDIRILECEK_KDV_MIKTAR_TYPE"; //
  static const String CORETEX_VERSIYON = "CORETEX_VERSIYON";
  static const String ENVIRO_VERSIYON = "ENVIRO_VERSIYON";
  static const String MUH_FIS_ANA_HESAP_INPUT_TYPE = "MUH_FIS_ANA_HESAP_INPUT_TYPE";
  static const String SUREC_PLANLAMA_SIRALAMA_TYPE = "SUREC_PLANLAMA_SIRALAMA_TYPE";
  static const String MAIL_SMTP_HOST = "MAIL_SMTP_HOST"; //
  static const String MAIL_SMTP_PORT = "MAIL_SMTP_PORT"; //
  static const String MAIL_SSL_TYPE = "MAIL_SSL_TYPE"; //
  static const String FATURA_BELGE_CARI_KONTROL = "FATURA_BELGE_CARI_KONTROL"; //
  static const String FATURA_BELGE_SIRKET_KONTROL = "FATURA_BELGE_SIRKET_KONTROL"; //
  static const String KESIMHANE_CARI_KOD = "KESIMHANE_CARI_KOD"; //
  static const String KESIMHANE_DEPO_KOD = "KESIMHANE_DEPO_KOD"; //
  static const String KESIMHANE_BIRIM_FIYAT = "KESIMHANE_BIRIM_FIYAT"; //
  static const String PISC_FIS_MAIL_AFTER_PRINT_TYPE = "PISC_FIS_MAIL_AFTER_PRINT_TYPE"; //
  static const String SEVKIYAT_ORDER_FIYAT_AKTAR_TYPE = "SEVKIYAT_ORDER_FIYAT_AKTAR_TYPE"; //
  static const String AKSESUAR_DEPO_KOD = "AKSESUAR_DEPO_KOD"; //
  static const String KUMAS_TEDARIK_HAM_TYPE = "KUMAS_TEDARIK_HAM_TYPE";
  static const String ORDER_GIRIS_DEFAULT_PARA_BIRIMI = "ORDER_GIRIS_DEFAULT_PARA_BIRIMI";
  static const String ORDER_GIRIS_DEFAULT_URETIM_TIPI = "ORDER_GIRIS_DEFAULT_URETIM_TIPI";
  static const String SIP_FIS_BIRIM_FIYAT_CHECK_TYPE = "SIP_FIS_BIRIM_FIYAT_CHECK_TYPE"; //
  static const String STOK_FIS_BRUT_MIKTAR_CHECK_TYPE = "STOK_FIS_BRUT_MIKTAR_CHECK_TYPE";
  static const String SUREC_PLAN_RENK1 = "SUREC_PLAN_RENK1";
  static const String SUREC_PLAN_RENK2 = "SUREC_PLAN_RENK2";
  static const String SUREC_PLAN_RENK3 = "SUREC_PLAN_RENK3";
  static const String KUMAS_KESIM_IS_EMRI_SEVK_TYPE = "KUMAS_KESIM_IS_EMRI_SEVK_TYPE"; //
  static const String URT_PLAN_ONMLY_FIYAT_CHECK_TYPE = "URT_PLAN_ONMLY_FIYAT_CHECK_TYPE"; //
  static const String URT_PLAN_ONMLY_ISC_CHECK_TYPE = "URT_PLAN_ONMLY_ISC_CHECK_TYPE"; //
  static const String PISC_FIS_ISC_ANLS_CHECK_TYPE = "PISC_FIS_ISC_ANLS_CHECK_TYPE"; //
  static const String SEVKIYAT_STOK_CARI_ENT_TYPE = "SEVKIYAT_STOK_CARI_ENT_TYPE";
  static const String TRIKO_ORME_TALIMAT_HAZIRLA_DEPO_KOD = "TRIKO_ORME_TALIMAT_HAZIRLA_DEPO_KOD"; //
  static const String URT_PLAN_STOK_KOD_ENT_TYPE = "URT_PLAN_STOK_KOD_ENT_TYPE";
  static const String SEVKIYAT_STOK_KOD_ENT_TYPE = "SEVKIYAT_STOK_KOD_ENT_TYPE";
  static const String SEVKIYAT_DEPO_KOD = "SEVKIYAT_DEPO_KOD"; //
  static const String STOK_MUH_ENT_TYPE = "STOK_MUH_ENT_TYPE";
  static const String PISC_FIS_MUH_ENT_TYPE = "PISC_FIS_MUH_ENT_TYPE";
  static const String PISC_FIS_DK_MLY_FIYAT_AKTAR_TYPE = "PISC_FIS_DK_MLY_FIYAT_AKTAR_TYPE"; //
  static const String URETIM_ANALIZ_MUH_ENT_TYPE = "URETIM_ANALIZ_MUH_ENT_TYPE";
  static const String SEVKIYAT_MUH_ENT_TYPE = "SEVKIYAT_MUH_ENT_TYPE";
  static const String BANKA_CARI_ENT_TYPE = "BANKA_CARI_ENT_TYPE";
  static const String BANKA_MUH_ENT_TYPE = "BANKA_MUH_ENT_TYPE";
  static const String ORDER_DOSYA_DEFAULT_PATH = "ORDER_DOSYA_DEFAULT_PATH";
  static const String MODEL_DOSYA_DEFAULT_PATH = "MODEL_DOSYA_DEFAULT_PATH";
  static const String PISCILIK_DOSYA_DEFAULT_PATH = "PISCILIK_DOSYA_DEFAULT_PATH";
  static const String MODEL_IS_EMRI_DOSYA_DEFAULT_PATH = "MODEL_IS_EMRI_DOSYA_DEFAULT_PATH";
  static const String SEVKIYAT_DOSYA_DEFAULT_PATH = "SEVKIYAT_DOSYA_DEFAULT_PATH";
  static const String STOK_FIS_BARKOD_KOD_LENGTH = "STOK_FIS_BARKOD_KOD_LENGTH"; //
  static const String STOK_FIS_BARKOD_VAR_LENGTH = "STOK_FIS_BARKOD_VAR_LENGTH"; //
  static const String TRIKO_HUCRE_BARKOD_KOD_LENGTH = "TRIKO_HUCRE_BARKOD_KOD_LENGTH"; //
  static const String TRIKO_HUCRE_PARCA_BARKOD_KOD_LENGTH = "TRIKO_HUCRE_PARCA_BARKOD_KOD_LENGTH"; //
  static const String FATURA_DEFAULT_DEPO_KOD = "FATURA_DEFAULT_DEPO_KOD"; //
  static const String FATURA_DEFAULT_TEVKIFAT_KOD = "FATURA_DEFAULT_TEVKIFAT_KOD"; //
  static const String URETIM_ANALIZ_DEFAULT_DEPO_KOD = "URETIM_ANALIZ_DEFAULT_DEPO_KOD";
  static const String ORDER_VARSAYILAN_ANA_RENK_ADI = "ORDER_VARSAYILAN_ANA_RENK_ADI";
  static const String FATURA_STOK_ENT_TYPE = "FATURA_STOK_ENT_TYPE";
  static const String PISC_FIS_ISC_ONMLY_CHECK_TYPE = "PISC_FIS_ISC_ONMLY_CHECK_TYPE"; //
  static const String TRIKO_HUCRE_RAF_ACTIVE_TYPE = "TRIKO_HUCRE_RAF_ACTIVE_TYPE";
  static const String CEK_SENET_BANKA_ENT_TYPE = "CEK_SENET_BANKA_ENT_TYPE";
  static const String MUH_FIS_FORM_DETAY_HESAP_PRINT_TYPE = "MUH_FIS_FORM_DETAY_HESAP_PRINT_TYPE";
  static const String TRIKO_HUCRE_MAKINA_GG_KONTROL = "TRIKO_HUCRE_MAKINA_GG_KONTROL"; //
  static const String GENEL_URETIM_GIDER_PISCILIK_KOD = "GENEL_URETIM_GIDER_PISCILIK_KOD"; //
  static const String TRIKO_HUCRE_OTOMATIK_ORME_ADET = "TRIKO_HUCRE_OTOMATIK_ORME_ADET"; //
  static const String ANA_PARA_BIRIMI = "ANA_PARA_BIRIMI";
  static const String PISC_FIS_GELEN_BELGE_NO_BOS_CHECK_TYPE = "PISC_FIS_GELEN_BELGE_NO_BOS_CHECK_TYPE"; //
  static const String PISC_FIS_GIDEN_BELGE_NO_BOS_CHECK_TYPE = "PISC_FIS_GIDEN_BELGE_NO_BOS_CHECK_TYPE"; //
  static const String URETIM_ANALIZ_BIRIM_FIYAT_TYPE = "URETIM_ANALIZ_BIRIM_FIYAT_TYPE";
  static const String AKSESUAR_SIPARIS_FREE_CHECK_TYPE = "AKSESUAR_SIPARIS_FREE_CHECK_TYPE"; //
  static const String AKSESUAR_TEDARIK_FONKSIYON_ACTIVE_TYPE = "AKSESUAR_TEDARIK_FONKSIYON_ACTIVE_TYPE";
  static const String TRIKO_HUCRE_ORME_GELEN_SICIL_KOD = "TRIKO_HUCRE_ORME_GELEN_SICIL_KOD"; //
  static const String TRIKO_HUCRE_ORME_GELEN_VARDIYA_KOD = "TRIKO_HUCRE_ORME_GELEN_VARDIYA_KOD"; //
  static const String IPLIK_ORME_FIRE_ORANI_DEFAULT_VALUE = "IPLIK_ORME_FIRE_ORANI_DEFAULT_VALUE";
  static const String STOK_FIS_18_ACTIVE_TYPE = "STOK_FIS_18_ACTIVE_TYPE";
  static const String HAM_KUMAS_DEPO_KOD = "HAM_KUMAS_DEPO_KOD";
  static const String MAMUL_KUMAS_DEPO_KOD = "MAMUL_KUMAS_DEPO_KOD";
  static const String KESIM_PISC_FIS_ENT_TYPE = "KESIM_PISC_FIS_ENT_TYPE"; //
  static const String KESIM_PISC_KODU = "KESIM_PISC_KODU"; //
  static const String MALIYET_SARF = "MALIYET_SARF";
  static const String YARI_MAMUL_FIRE_MALIYET_CARI_KOD = "YARI_MAMUL_FIRE_MALIYET_CARI_KOD";
  static const String URETIM_ANALIZ_DEFAULT_CARI_KOD = "URETIM_ANALIZ_DEFAULT_CARI_KOD";
  static const String URETIM_ANALIZ_ISCILIK_CHECK_TYPE = "URETIM_ANALIZ_ISCILIK_CHECK_TYPE";
  static const String KUMAS_TEDARIK_FONKSIYON_ACTIVE_TYPE = "KUMAS_TEDARIK_FONKSIYON_ACTIVE_TYPE";
  static const String STOK_FIS_COPY_ACTIVE_TYPE = "STOK_FIS_COPY_ACTIVE_TYPE";
  static const String PISC_FIS_COPY_ACTIVE_TYPE = "PISC_FIS_COPY_ACTIVE_TYPE"; //
  static const String FATURA_KDV_ENT_TYPE = "FATURA_KDV_ENT_TYPE";
  static const String STOK_FIS_MAL_ALIM_GIRIS_ACTIVE_TYPE = "STOK_FIS_MAL_ALIM_GIRIS_ACTIVE_TYPE";
  static const String CEKI_URETIM_ANALIZ_ADET_CHECK_TYPE = "CEKI_URETIM_ANALIZ_ADET_CHECK_TYPE"; //
  static const String URT_ANALIZ_STOK_KOD_CHECK_TYPE = "URT_ANALIZ_STOK_KOD_CHECK_TYPE";
  static const String ORDER_DURUMU_YARI_MAMUL_FIRE_FIS_CHECK_TYPE = "ORDER_DURUMU_YARI_MAMUL_FIRE_FIS_CHECK_TYPE";
  static const String VARSAYILAN_DIL = "VARSAYILAN_DIL";
  static const String TRIKO_HUCRE_MAKINA_BARKOD_KOD_LENGTH = "TRIKO_HUCRE_MAKINA_BARKOD_KOD_LENGTH"; //
  static const String ON_MALIYET_PARA_BRM1_DEFAULT_VALUE = "ON_MALIYET_PARA_BRM1_DEFAULT_VALUE";
  static const String ON_MALIYET_PARA_BRM2_DEFAULT_VALUE = "ON_MALIYET_PARA_BRM2_DEFAULT_VALUE";
  static const String ON_MALIYET_PARA_BRM3_DEFAULT_VALUE = "ON_MALIYET_PARA_BRM3_DEFAULT_VALUE";
  static const String ON_MALIYET_KUR1_DEFAULT_VALUE = "ON_MALIYET_KUR1_DEFAULT_VALUE";
  static const String ON_MALIYET_KUR2_DEFAULT_VALUE = "ON_MALIYET_KUR2_DEFAULT_VALUE";
  static const String ON_MALIYET_KUR3_DEFAULT_VALUE = "ON_MALIYET_KUR3_DEFAULT_VALUE";
  static const String KESIM_PASTAL_PISC_FIS_ENT_TYPE = "KESIM_PASTAL_PISC_FIS_ENT_TYPE"; //
  static const String SEVKIYAT_URETIM_ANALIZ_TARIH_CHECK_TYPE = "SEVKIYAT_URETIM_ANALIZ_TARIH_CHECK_TYPE"; //
  static const String URETIM_ANALIZ_SEVKIYAT_TARIH_CHECK_TYPE = "URETIM_ANALIZ_SEVKIYAT_TARIH_CHECK_TYPE";
  static const String AKSESUAR_SIPARIS_FIYATLI_AKTAR_CHECK_TYPE = "AKSESUAR_SIPARIS_FIYATLI_AKTAR_CHECK_TYPE"; //
  static const String GENEL_GIDER_CARI_SINIF_KODU = "GENEL_GIDER_CARI_SINIF_KODU";
  static const String ORDER_TERMIN_YUKLEME_TARIH_AKTAR_TYPE = "ORDER_TERMIN_YUKLEME_TARIH_AKTAR_TYPE";
  static const String SIP_FIS_MUS_TEM_ONAY_TYPE = "SIP_FIS_MUS_TEM_ONAY_TYPE"; //
  static const String TRIKO_HUCRELEME_ORULECEK_ADET_KONTROL_TYPE = "TRIKO_HUCRELEME_ORULECEK_ADET_KONTROL_TYPE"; //
  static const String BUTCE_GERCEKLESEN_PLANLANAN_GELIR_HESAP_TYPE = "BUTCE_GERCEKLESEN_PLANLANAN_GELIR_HESAP_TYPE";
  static const String CEKI_URETIM_ANALIZ_ADET_BY_STOK_CHECK_TYPE = "CEKI_URETIM_ANALIZ_ADET_BY_STOK_CHECK_TYPE"; //
  static const String HAM_KUMAS_STOK_LIST_TP_SATIS_ACTIVE_TYPE = "HAM_KUMAS_STOK_LIST_TP_SATIS_ACTIVE_TYPE";
  static const String OTOMATIK_SUREC_PLANLAMA_OLUSTUR_TYPE = "OTOMATIK_SUREC_PLANLAMA_OLUSTUR_TYPE";
  static const String SEVKIYAT_FIS_STOK_MIKTAR_CHECK_TYPE = "SEVKIYAT_FIS_STOK_MIKTAR_CHECK_TYPE"; //
  static const String KARSILASTIRMA_MALIYET_DIP_TOPLAM_TYPE = "KARSILASTIRMA_MALIYET_DIP_TOPLAM_TYPE";
  static const String STOK_FIS_TAHSIS_CHANGE_CHECK_TYPE = "STOK_FIS_TAHSIS_CHANGE_CHECK_TYPE";
  static const String TRIKO_PLANLAMA_YUZDE_ORAN_CHECK_TYPE = "TRIKO_PLANLAMA_YUZDE_ORAN_CHECK_TYPE";
  static const String STOK_FIS_GIRIS_BELGE_NO_BOS_CHECK_TYPE = "STOK_FIS_GIRIS_BELGE_NO_BOS_CHECK_TYPE";
  static const String STOK_FIS_CIKIS_BELGE_NO_BOS_CHECK_TYPE = "STOK_FIS_CIKIS_BELGE_NO_BOS_CHECK_TYPE";
  static const String SEVKIYAT_ORDER_KAPALILIK_CHECK_TYPE = "SEVKIYAT_ORDER_KAPALILIK_CHECK_TYPE";
  static const String URETIM_ANALIZ_CHECK_TYPE = "URETIM_ANALIZ_CHECK_TYPE";
  static const String FATURA_FIS_EFATURA_CARI_CHECK_TYPE = "FATURA_FIS_EFATURA_CARI_CHECK_TYPE";
  static const String KUMAS_TEDARIK_CALCULATION_TYPE = "KUMAS_TEDARIK_CALCULATION_TYPE";
  static const String AKSESUAR_TEDARIK_CALCULATION_TYPE = "AKSESUAR_TEDARIK_CALCULATION_TYPE";
  static const String EFATURA_ENTEGRATOR_TYPE = "EFATURA_ENTEGRATOR_TYPE";

  //Burdan itibaren Sistem Güncelleme Kartı - Parameters Tablosu Scriptleri e_tablosu doğrultusunda eklenmiştir.
  static const String OTOMATIK_KESIM_PLANLAMA_OLUSTUR_TYPE = "OTOMATIK_KESIM_PLANLAMA_OLUSTUR_TYPE";
  static const String SIRKET_CARI_MODEL_ETUT_CHECK_TYPE = "SIRKET_CARI_MODEL_ETUT_CHECK_TYPE";
  static const String EFATURA_DOVIZ_TUTAR = "EFATURA_DOVIZ_TUTAR";
  static const String KAPALI_DONEM_CHECK_TYPE = "KAPALI_DONEM_CHECK_TYPE";
  static const String STOK_KESIM_IS_EMRI_RELATION_CHECK_TYPE = "STOK_KESIM_IS_EMRI_RELATION_CHECK_TYPE";
  static const String STOK_KESIM_RELATION_CHECK_TYPE = "STOK_KESIM_RELATION_CHECK_TYPE";
  static const String TRIKO_ORME_GELEN_DELETE_TYPE = "TRIKO_ORME_GELEN_DELETE_TYPE";
  static const String TRIKO_DEFAULT_PARCA_KOD = "TRIKO_DEFAULT_PARCA_KOD";
  static const String TRIKO_EXPRESS_ORME_GELEN_ACTIVE_TYPE = "TRIKO_EXPRESS_ORME_GELEN_ACTIVE_TYPE";
  static const String ORDER_GIRISI_ONMLY_CHECK_TYPE = "ORDER_GIRISI_ONMLY_CHECK_TYPE";
  static const String GELECEK_MAMUL_KUMAS_TOLERANS_YUZDE = "GELECEK_MAMUL_KUMAS_TOLERANS_YUZDE";
  static const String URETIM_ANALIZ_ORME_ADET_CHECK_TYPE = "URETIM_ANALIZ_ORME_ADET_CHECK_TYPE";
  static const String ORMEYE_IPLIK_CIKIS_FASON_ORGU_DELETE_TYPE = "ORMEYE_IPLIK_CIKIS_FASON_ORGU_DELETE_TYPE";
  static const String TRIKO_IPLIK_TEDARIK_FONKSIYON_ACTIVE_TYPE = "TRIKO_IPLIK_TEDARIK_FONKSIYON_ACTIVE_TYPE";
  static const String URETIM_FAZLASI_YUZDE_TYPE = "URETIM_FAZLASI_YUZDE_TYPE";
  static const String ORMEYE_IPLIK_CIKISI_TALIMATTAN_PLANLANAN_ACTIVE_TYPE = "ORMEYE_IPLIK_CIKISI_TALIMATTAN_PLANLANAN_ACTIVE_TYPE";
  static const String AKSESUAR_HAMMADDE_STOK_GRUP_KOD = "AKSESUAR_HAMMADDE_STOK_GRUP_KOD";
  static const String URT_PLAN_ONMLY_STOK_GRUP_CHECK_TYPE = "URT_PLAN_ONMLY_STOK_GRUP_CHECK_TYPE";
  static const String CARI_KART_VADE_OPSIYON_CHECK_TYPE = "CARI_KART_VADE_OPSIYON_CHECK_TYPE";
  static const String MODELDEN_STOK_KARTI_OLUSUM_TYPE = "MODELDEN_STOK_KARTI_OLUSUM_TYPE";
  static const String ORDERDAN_STOK_KARTI_OLUSUM_TYPE = "ORDERDAN_STOK_KARTI_OLUSUM_TYPE";
  static const String STOK_LIST_SATIS_ACTIVE_TYPE = "STOK_LIST_SATIS_ACTIVE_TYPE";
  static const String STOK_FIS_TAHSIS_FATURA_KONTROL_TYPE = "STOK_FIS_TAHSIS_FATURA_KONTROL_TYPE";
  static const String KUMAS_ORME_TAHSIS_COPY_ACTIVE_TYPE = "KUMAS_ORME_TAHSIS_COPY_ACTIVE_TYPE";
  static const String SEVKIYAT_FISI_BELGE_NO_BOS_CHECK_TYPE = "SEVKIYAT_FISI_BELGE_NO_BOS_CHECK_TYPE";
  static const String OTOMATIK_SATIS_FATURA_ODEME_PLAN_OLUSTUR_TYPE = "OTOMATIK_SATIS_FATURA_ODEME_PLAN_OLUSTUR_TYPE";
  static const String OTOMATIK_ALIS_FATURA_ODEME_PLAN_OLUSTUR_TYPE = "OTOMATIK_ALIS_FATURA_ODEME_PLAN_OLUSTUR_TYPE";
  static const String PISC_FIS_FATURA_AGIRLIK_FIYAT_AKTAR_TYPE = "PISC_FIS_FATURA_AGIRLIK_FIYAT_AKTAR_TYPE";
  static const String URT_PLAN_ONMLY_ONAY_ISC_CHECK_TYPE = "URT_PLAN_ONMLY_ONAY_ISC_CHECK_TYPE";
  static const String PISC_FIS_ISC_ONAYLI_ANLS_CHECK_TYPE = "PISC_FIS_ISC_ONAYLI_ANLS_CHECK_TYPE";
  static const String ON_MALIYET_BIRIM_FIYAT_VIEW_TYPE = "ON_MALIYET_BIRIM_FIYAT_VIEW_TYPE";
  static const String GENEL_GIDER_FISI_OLUSTUR_TYPE = "GENEL_GIDER_FISI_OLUSTUR_TYPE";
  static const String STOK_FIS_ONAY_KONTROL_TYPE = "STOK_FIS_ONAY_KONTROL_TYPE";
  static const String STOK_FIS_MUS_TEM_ONAY_TYPE = "STOK_FIS_MUS_TEM_ONAY_TYPE";
  static const String KESIM_ISLEM_UST_SATIR_COPY_TYPE = "KESIM_ISLEM_UST_SATIR_COPY_TYPE";
  static const String URETIM_ANALIZ_PISCILIK_KOD = "URETIM_ANALIZ_PISCILIK_KOD";
  static const String KUMAS_PLANLAMA_ORDER_ONAY_CHECK_TYPE = "KUMAS_PLANLAMA_ORDER_ONAY_CHECK_TYPE";
  static const String AKSESUAR_PLANLAMA_ORDER_ONAY_CHECK_TYPE = "AKSESUAR_PLANLAMA_ORDER_ONAY_CHECK_TYPE";
  static const String DEFAULT_ATOLYE_CARI_SINIF = "DEFAULT_ATOLYE_CARI_SINIF";
  static const String KUMAS_KESIM_IS_EMRI_PLANLANAN_TYPE = "KUMAS_KESIM_IS_EMRI_PLANLANAN_TYPE";
  static const String KESIM_IS_EMRI_KUMAS_KONTROL_CHECK_TYPE = "KESIM_IS_EMRI_KUMAS_KONTROL_CHECK_TYPE";
  static const String KESIMDEN_IADE_MALIYET_TYPE = "KESIMDEN_IADE_MALIYET_TYPE";
  static const String TRIKO_HUCRE_FASON_ISLEM_KONTROL_TYPE = "TRIKO_HUCRE_FASON_ISLEM_KONTROL_TYPE";
  static const String FATURA_ODEME_PLAN_KDV_TYPE = "FATURA_ODEME_PLAN_KDV_TYPE";
  static const String FATURA_ODEME_PLAN_KDV_ODEME_GUN = "FATURA_ODEME_PLAN_KDV_ODEME_GUN";
  static const String KESIM_BEKLEYEN_KUMAS_IADE_TYPE = "KESIM_BEKLEYEN_KUMAS_IADE_TYPE";
  static const String SIPARIS_FIS_COPY_ACTIVE_TYPE = "SIPARIS_FIS_COPY_ACTIVE_TYPE";
  static const String FATURA_FIS_STOK_FIYAT_AKTAR_TYPE = "FATURA_FIS_STOK_FIYAT_AKTAR_TYPE";
  static const String SEVKIYAT_FISI_BELGE_NO_EXIST_CHECK_TYPE = "SEVKIYAT_FISI_BELGE_NO_EXIST_CHECK_TYPE";
  static const String STOK_RENK_BOYUT_ACTIVE_TYPE = "STOK_RENK_BOYUT_ACTIVE_TYPE";
  static const String URETIM_ANALIZ_STOK_RENK_BOYUT_ENT_TYPE = "URETIM_ANALIZ_STOK_RENK_BOYUT_ENT_TYPE";
  static const String FATURA_FIS_SATIS_ODEME_GUN_CHECK_TYPE = "FATURA_FIS_SATIS_ODEME_GUN_CHECK_TYPE";
  static const String FATURA_FIS_ALIS_ODEME_GUN_CHECK_TYPE = "FATURA_FIS_ALIS_ODEME_GUN_CHECK_TYPE";
  static const String SUREC_KARTI_GERCEKLESEN_BITIS_DURUM_KODU = "SUREC_KARTI_GERCEKLESEN_BITIS_DURUM_KODU";
  static const String SUREC_PLANLAMA_TARIH_KOPYALAMA_CHECK_TYPE = "SUREC_PLANLAMA_TARIH_KOPYALAMA_CHECK_TYPE";
  static const String IPLIK_IS_EMRI_PARTI_NO_PREFIX = "IPLIK_IS_EMRI_PARTI_NO_PREFIX";
  static const String AKSESUAR_SIPARIS_IHTIYAC_TYPE = "AKSESUAR_SIPARIS_IHTIYAC_TYPE";
  static const String IPLIK_ELYAF_HAZIRLAMA_DEPO = "IPLIK_ELYAF_HAZIRLAMA_DEPO";
  static const String IPLIK_MAKINA_IMAL_DEPO = "IPLIK_MAKINA_IMAL_DEPO";
  static const String KUMAS_KONTROL_SARTLI_KABUL_PUANI = "KUMAS_KONTROL_SARTLI_KABUL_PUANI";
  static const String KUMAS_KONTROL_RED_PUANI = "KUMAS_KONTROL_RED_PUANI";
  static const String MODEL_VERIM_KOLILEME_SEFKIYAT_VARYANT_TYPE = "MODEL_VERIM_KOLILEME_SEFKIYAT_VARYANT_TYPE";
  static const String COREERP_KUMAS_ON_MALIYET_OZEL_ALAN_ILISKI_KODU = "COREERP_KUMAS_ON_MALIYET_OZEL_ALAN_ILISKI_KODU";
  static const String SORUMLU_SUREC_PLANLAMA_EKSTRESI_NAVIGASYON_TIME = "SORUMLU_SUREC_PLANLAMA_EKSTRESI_NAVIGASYON_TIME";
  static const String KUMAS_STOK_TOLERANS_KONTROL_TYPE = "KUMAS_STOK_TOLERANS_KONTROL_TYPE";
  static const String AKSESUAR_SIPARIS_TOLERANS_KONTROL_TYPE = "AKSESUAR_SIPARIS_TOLERANS_KONTROL_TYPE";
  static const String TRIKO_IPLIK_STOK_TOLERANS_KONTROL_TYPE = "TRIKO_IPLIK_STOK_TOLERANS_KONTROL_TYPE";
  static const String AKSESUAR_STOK_TOLERANS_KONTROL_TYPE = "AKSESUAR_STOK_TOLERANS_KONTROL_TYPE";
  static const String IPLIK_STOK_TOLERANS_KONTROL_TYPE = "IPLIK_STOK_TOLERANS_KONTROL_TYPE";
  static const String SIPARIS_VERILECEK_ORDER_AKSESUAR_FREE_ACTIVE_TYPE = "SIPARIS_VERILECEK_ORDER_AKSESUAR_FREE_ACTIVE_TYPE";
  static const String FATURA_FIS_SEVKIYAT_FIS_KONTROL_TYPE = "FATURA_FIS_SEVKIYAT_FIS_KONTROL_TYPE";
  static const String ALIS_ISLEMI_DOVIZ_KUR_TYPE = "ALIS_ISLEMI_DOVIZ_KUR_TYPE";
  static const String SATIS_ISLEMI_DOVIZ_KUR_TYPE = "SATIS_ISLEMI_DOVIZ_KUR_TYPE";
  static const String ALIS_IADE_DOVIZ_KUR_TYPE = "ALIS_IADE_DOVIZ_KUR_TYPE";
  static const String SATIS_IADE_DOVIZ_KUR_TYPE = "SATIS_IADE_DOVIZ_KUR_TYPE";
  static const String CIKIS_BEKLEYEN_AKSESUAR_LIST_TAHSIS_KONTROL_TYPE = "CIKIS_BEKLEYEN_AKSESUAR_LIST_TAHSIS_KONTROL_TYPE";
  static const String CIKIS_BEKLEYEN_ORDER_AKSESUAR_LIST_FONKSIYON_TYPE = "CIKIS_BEKLEYEN_ORDER_AKSESUAR_LIST_FONKSIYON_TYPE";
  static const String MIZAN_BILANCO_SINIF_BACKGROUND_COLOR = "MIZAN_BILANCO_SINIF_BACKGROUND_COLOR";
  static const String MIZAN_BILANCO_SINIF_FOREGROUND_COLOR = "MIZAN_BILANCO_SINIF_FOREGROUND_COLOR";
  static const String MIZAN_BILANCO_GRUP_BACKGROUND_COLOR = "MIZAN_BILANCO_GRUP_BACKGROUND_COLOR";
  static const String MIZAN_BILANCO_GRUP_FOREGROUND_COLOR = "MIZAN_BILANCO_GRUP_FOREGROUND_COLOR";
  static const String MIZAN_ANA_HESAP_BACKGROUND_COLOR = "MIZAN_ANA_HESAP_BACKGROUND_COLOR";
  static const String MIZAN_ANA_HESAP_FOREGROUND_COLOR = "MIZAN_ANA_HESAP_FOREGROUND_COLOR";
  static const String MIZAN_MUAVIN_HESAP_BACKGROUND_COLOR = "MIZAN_MUAVIN_HESAP_BACKGROUND_COLOR";
  static const String MIZAN_MUAVIN_HESAP_FOREGROUND_COLOR = "MIZAN_MUAVIN_HESAP_FOREGROUND_COLOR";
  static const String MIZAN_DETAY_HESAP_BACKGROUND_COLOR = "MIZAN_DETAY_HESAP_BACKGROUND_COLOR";
  static const String MIZAN_DETAY_HESAP_FOREGROUND_COLOR = "MIZAN_DETAY_HESAP_FOREGROUND_COLOR";
  static const String VERIMLILIK_ENTEGRASYON_GIDEN_PISCILIK_KODU = "VERIMLILIK_ENTEGRASYON_GIDEN_PISCILIK_KODU";
  static const String GELECEK_ORDER_AKSESUAR_LIST_FONKSIYON_TYPE = "GELECEK_ORDER_AKSESUAR_LIST_FONKSIYON_TYPE";
  static const String ORDER_ON_MALIYET_FIYAT_AKTAR_TYPE = "ORDER_ON_MALIYET_FIYAT_AKTAR_TYPE";
  static const String DIGER_STOK_FIS_MAL_ALIM_GIRIS_ACTIVE_TYPE = "DIGER_STOK_FIS_MAL_ALIM_GIRIS_ACTIVE_TYPE";
  static const String KONTROL_EDILECEK_KUMAS_LISTESI_HAM_ACTIVE_TYPE = "KONTROL_EDILECEK_KUMAS_LISTESI_HAM_ACTIVE_TYPE";
  static const String KUMAS_SIPARIS_TOLERANS_KONTROL_TYPE = "KUMAS_SIPARIS_TOLERANS_KONTROL_TYPE";
  static const String FATURALASTIRMA_IRSALIYE_ONAY_CHECK_TYPE = "FATURALASTIRMA_IRSALIYE_ONAY_CHECK_TYPE";
  static const String SUREC_KARTI_GERCEKLESEN_BASLANGIC_DURUM_KODU = "SUREC_KARTI_GERCEKLESEN_BASLANGIC_DURUM_KODU";
  static const String KUMAS_PLANLAMA_TAMAMLAMA_CHECK_TYPE = "KUMAS_PLANLAMA_TAMAMLAMA_CHECK_TYPE";
  static const String KESIM_IS_EMRI_STOK_FIS_TOLERANS_CHECK_TYPE = "KESIM_IS_EMRI_STOK_FIS_TOLERANS_CHECK_TYPE";
  static const String STOK_KART_INSERT_ACTIVE_TYPE = "STOK_KART_INSERT_ACTIVE_TYPE";
  static const String DEPO_TRANSFER_FISI_KUMAS_TEDARIK_GELEN_MIKTAR_ACTIVE_TYPE = "DEPO_TRANSFER_FISI_KUMAS_TEDARIK_GELEN_MIKTAR_ACTIVE_TYPE";

  //Kaan
  static const String GELECEK_MAMUL_KUMAS_ONAY_CHECK_TYPE = "GELECEK_MAMUL_KUMAS_ONAY_CHECK_TYPE";
  static const String GELECEK_HAM_KUMAS_ONAY_CHECK_TYPE = "GELECEK_HAM_KUMAS_ONAY_CHECK_TYPE";
  static const String GELECEK_IPLIK_ONAY_CHECK_TYPE = "GELECEK_IPLIK_ONAY_CHECK_TYPE";
  static const String GELECEK_TRIKO_IPLIK_ONAY_CHECK_TYPE = "GELECEK_TRIKO_IPLIK_ONAY_CHECK_TYPE";
  static const String GELECEK_AKSESUAR_ONAY_CHECK_TYPE = "GELECEK_AKSESUAR_ONAY_CHECK_TYPE";
  static const String GELECEK_ORDER_AKSESUAR_ONAY_CHECK_TYPE = "GELECEK_ORDER_AKSESUAR_ONAY_CHECK_TYPE";
  static const String KUMAS_TAMIRE_CIKIS_RET_CHECK_TYPE = "KUMAS_TAMIRE_CIKIS_RET_CHECK_TYPE";

  static const String KKEG_BINEK_ARAC_GIDER_ORANI = "KKEG_BINEK_ARAC_GIDER_ORANI";
  static const String KKEG_BINEK_ARAC_KIRA_UST_LIMIT_TUTARI = "KKEG_BINEK_ARAC_KIRA_UST_LIMIT_TUTARI";
  static const String KESIM_IS_EMRI_URETIM_PLANLAMA_CHECK_TYPE = "KESIM_IS_EMRI_URETIM_PLANLAMA_CHECK_TYPE";
  static const String ORDER_GENEL_DURUM_IKI_NAVIGASYON_TIME = "ORDER_GENEL_DURUM_IKI_NAVIGASYON_TIME";
  static const String URETIM_PLANLAMA_SIFIR_BIRIM_FIYAT_CHECK_TYPE = "URETIM_PLANLAMA_SIFIR_BIRIM_FIYAT_CHECK_TYPE";
  static const String ORDER_LISTESI_AGIRLIK_DETAYLI_ACTIVE_TYPE = "ORDER_LISTESI_AGIRLIK_DETAYLI_ACTIVE_TYPE";
  static const String CARI_HZM_NIT_PRM_INDEX = "CARI_HZM_NIT_PRM_INDEX";
  static const String CARI_IML_TED_PRM_INDEX = "CARI_IML_TED_PRM_INDEX";
  static const String STOK_BELGE_CARI_KONTROL = "STOK_BELGE_CARI_KONTROL";
  static const String PISCILIK_BELGE_CARI_KONTROL = "PISCILIK_BELGE_CARI_KONTROL";
  static const String KUMAS_SIPARIS_ON_MALIYET_BUTCE_FIYAT_AKTAR_TYPE = "KUMAS_SIPARIS_ON_MALIYET_BUTCE_FIYAT_AKTAR_TYPE";
  static const String AKSESUAR_SIPARIS_ON_MALIYET_BUTCE_FIYAT_AKTAR_TYPE = "AKSESUAR_SIPARIS_ON_MALIYET_BUTCE_FIYAT_AKTAR_TYPE";
  static const String ORDER_URETIM_FAZLASI_DEFAULT_VALUE = "ORDER_URETIM_FAZLASI_DEFAULT_VALUE";
  static const String ORDER_RENK_SABLON_DEFAULT_VALUE = "ORDER_RENK_SABLON_DEFAULT_VALUE";
  static const String ORDER_BEDEN_SABLON_DEFAULT_VALUE = "ORDER_BEDEN_SABLON_DEFAULT_VALUE";

  static const String TERON_ENTEGRASYON_DEPO_KOD = "TERON_ENTEGRASYON_DEPO_KOD";
  static const String HTTP_SERVER_IP = "HTTP_SERVER_IP";
  static const String HTTP_SERVER_PORT = "HTTP_SERVER_PORT";

  //LOG PARAMETRELERI CONSTANTLARI
  static const String LOG_LOG_LEVEL = "LOG_LOG_LEVEL";
  static const String LOG_APPENDER_CONVERSION_PATTERN = "LOG_APPENDER_CONVERSION_PATTERN";
  static const String LOG_MAX_FILE_SIZE = "LOG_MAX_FILE_SIZE";
  static const String LOG_MAX_BACKUP_INDEX = "LOG_MAX_BACKUP_INDEX";

  static setParameters(LoginInterface loginInterface) async {
    await loginInterface.getHttpManager().httpGet("/ERPService/parameters").then((value) {
      print(value);
      String resp = Utf8Decoder().convert(value.bodyBytes);
      var jsonDecode = json.decode(resp);
      parameters = jsonDecode;
    });
  }

  static String getParameter(String key) {
    return parameters[key];
  }
}