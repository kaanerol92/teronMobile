class TextRepository {
  static Map textMap = Map();

  static const String MOBILE_TITLE = "MOBILE_TITLE";
  static const String IP_AYARLARI = "IP_AYARLARI";
  static const String GIRIS_YAPILIYOR = "GIRIS_YAPILIYOR";
  static const String GIRIS_BASARISIZ = "GIRIS_BASARISIZ";
  static const String SISTEM_YUKLENIYOR = "SISTEM_YUKLENIYOR";
  static const String KULLANICI_ADI = "KULLANICI_ADI";
  static const String SIFRE = "SIFRE";
  static const String SIRKET = "SIRKET";
  static const String DONEM = "DONEM";
  static const String CIKIS = "CIKIS";
  static const String GIRIS = "GIRIS";
  static const String ICIP = "ICIP";
  static const String ICPORT = "ICPORT";
  static const String DISIP = "DISIP";
  static const String DISPORT = "DISPORT";
  static const String TAMAM = "TAMAM";
  static const String ANA_MENU = "ANA_MENU";
  static const String SIPARIS_ISLEMLERI = "SIPARIS_ISLEMLERI";
  static const String STOK_ISLEMLERI = "STOK_ISLEMLERI";
  static const String MUSTERI_SIPARISI = "MUSTERI_SIPARISI";
  static const String MAL_ALIM = "MAL_ALIM";
  static const String TOPTAN_SATIS = "TOPTAN_SATIS";
  static const String PERAKENDE_SATIS = "PERAKENDE_SATIS";
  static const String URETIM = "URETIM";
  static const String KAYDET = "KAYDET";
  static const String EVET = "EVET";
  static const String HAYIR = "HAYIR";
  static const String SIL = "SIL";
  static const String DUZENLE = "DUZENLE";

  //MODULLER
  static const String BASLIK = "BASLIK";
  static const String DETAY = "DETAY";
  static const String OZET = "OZET";
  static const String SIPARIS_TARIHI = "SIPARIS_TARIHI";
  static const String TERMIN_TARIHI = "TERMIN_TARIHI";
  static const String CARI_KODU = "CARI_KODU";
  static const String CARI_ADI = "CARI_ADI";
  static const String SEVK_CARI_KODU = "SEVK_CARI_KODU";
  static const String SEVK_CARI_ADI = "SEVK_CARI_ADI";
  static const String DEPO_KODU = "DEPO_KODU";
  static const String DEPO_ADI = "DEPO_ADI";
  static const String MUSTERI_SIPARIS_NO = "MUSTERI_SIPARIS_NO";
  static const String ACIKLAMA = "ACIKLAMA";
  static const String BARKOD = "BARKOD";
  static const String STOK_KODU = "STOK_KODU";
  static const String STOK_ADI = "STOK_ADI";
  static const String RENK = "RENK";
  static const String BEDEN = "BEDEN";
  static const String ADET = "ADET";
  static const String TARIH = "TARIH";
  static const String SEVK_TARIHI = "SEVK_TARIHI";
  static const String GIRIS_DEPO_KODU = "GIRIS_DEPO_KODU";
  static const String GIRIS_DEPO_ADI = "GIRIS_DEPO_ADI";
  static const String CIKIS_DEPO_KODU = "CIKIS_DEPO_KODU";
  static const String CIKIS_DEPO_ADI = "CIKIS_DEPO_ADI";
  static const String PARA_BIRIMI = "PARA_BIRIMI";
  static const String FIYAT = "FIYAT";
  static const String FIS_TIPI = "FIS_TIPI";
  static const String KODU = "KODU";
  static const String ADI = "ADI";
  static const String TOPLAM_ADET = "TOPLAM_ADET";
  static const String MIKTAR = "MIKTAR";
  static const String TUTAR = "TUTAR";
  static const String LOT_ICI_ADEDI = "LOT_ICI_ADEDI";
  static const String LOT_ADEDI = "LOT_ADEDI";

  static void setTexts() {
    textMap.clear();
    textMap.putIfAbsent(MOBILE_TITLE, () => "Teron Mobil");
    textMap.putIfAbsent(IP_AYARLARI, () => "Ip Ayarları");
    textMap.putIfAbsent(GIRIS_YAPILIYOR, () => "Giriş Yapılıyor");
    textMap.putIfAbsent(GIRIS_BASARISIZ, () => "Giriş Başarısız");
    textMap.putIfAbsent(SISTEM_YUKLENIYOR, () => "Sistem Yükleniyor..");
    textMap.putIfAbsent(KULLANICI_ADI, () => "Kullanıcı Adı");
    textMap.putIfAbsent(SIFRE, () => "Şifre");
    textMap.putIfAbsent(SIRKET, () => "Şirket");
    textMap.putIfAbsent(DONEM, () => "Dönem");
    textMap.putIfAbsent(GIRIS, () => "Giriş");
    textMap.putIfAbsent(CIKIS, () => "Çıkış");
    textMap.putIfAbsent(ICIP, () => "İç Ip");
    textMap.putIfAbsent(ICPORT, () => "İç Port");
    textMap.putIfAbsent(DISIP, () => "Dış Ip");
    textMap.putIfAbsent(DISPORT, () => "Dış Port");
    textMap.putIfAbsent(TAMAM, () => "Tamam");
    textMap.putIfAbsent(ANA_MENU, () => "Ana Menü");
    textMap.putIfAbsent(SIPARIS_ISLEMLERI, () => "Sipariş İşlemleri");
    textMap.putIfAbsent(STOK_ISLEMLERI, () => "Stok İşlemleri");
    textMap.putIfAbsent(MUSTERI_SIPARISI, () => "Müşteri Siparişi");
    textMap.putIfAbsent(MAL_ALIM, () => "Mal Alım");
    textMap.putIfAbsent(TOPTAN_SATIS, () => "Toptan Satış");
    textMap.putIfAbsent(PERAKENDE_SATIS, () => "Perakende Satış");
    textMap.putIfAbsent(URETIM, () => "Üretim");
    textMap.putIfAbsent(BASLIK, () => "Başlık");
    textMap.putIfAbsent(DETAY, () => "Detay");
    textMap.putIfAbsent(OZET, () => "Özet");
    textMap.putIfAbsent(EVET, () => "Evet");
    textMap.putIfAbsent(HAYIR, () => "Hayır");
    textMap.putIfAbsent(SIL, () => "Sil");
    textMap.putIfAbsent(DUZENLE, () => "Düzenle");
    textMap.putIfAbsent(KAYDET, () => "Kaydet");

    textMap.putIfAbsent(SIPARIS_TARIHI, () => "Sipariş Tarihi");
    textMap.putIfAbsent(TERMIN_TARIHI, () => "Termin Tarihi");
    textMap.putIfAbsent(CARI_KODU, () => "Cari Kodu");
    textMap.putIfAbsent(CARI_ADI, () => "Cari Adı");
    textMap.putIfAbsent(SEVK_CARI_KODU, () => "Sevk Cari Kodu");
    textMap.putIfAbsent(SEVK_CARI_ADI, () => "Sevk Cari Adı");
    textMap.putIfAbsent(DEPO_KODU, () => "Depo Kodu");
    textMap.putIfAbsent(DEPO_ADI, () => "Depo Adı");
    textMap.putIfAbsent(MUSTERI_SIPARIS_NO, () => "Müşteri Sipariş No");
    textMap.putIfAbsent(ACIKLAMA, () => "Açıklama");
    textMap.putIfAbsent(BARKOD, () => "Barkod");
    textMap.putIfAbsent(STOK_KODU, () => "Stok Kodu");
    textMap.putIfAbsent(STOK_ADI, () => "Stok Adı");
    textMap.putIfAbsent(RENK, () => "Renk");
    textMap.putIfAbsent(BEDEN, () => "Beden");
    textMap.putIfAbsent(ADET, () => "Adet");
    textMap.putIfAbsent(TARIH, () => "Tarih");
    textMap.putIfAbsent(SEVK_TARIHI, () => "Sevk Tarihi");
    textMap.putIfAbsent(GIRIS_DEPO_KODU, () => "Giriş Depo Kodu");
    textMap.putIfAbsent(GIRIS_DEPO_ADI, () => "Giriş Depo Adı");
    textMap.putIfAbsent(CIKIS_DEPO_KODU, () => "Çıkış Depo Kodu");
    textMap.putIfAbsent(CIKIS_DEPO_ADI, () => "Çıkış Depo Adı");
    textMap.putIfAbsent(PARA_BIRIMI, () => "Para Birimi");
    textMap.putIfAbsent(FIYAT, () => "Fiyat");
    textMap.putIfAbsent(FIS_TIPI, () => "Fiş Tipi");
    textMap.putIfAbsent(KODU, () => "Kodu");
    textMap.putIfAbsent(ADI, () => "Adı");
    textMap.putIfAbsent(TOPLAM_ADET, () => "Toplam Adet");
    textMap.putIfAbsent(MIKTAR, () => "Miktar");
    textMap.putIfAbsent(TUTAR, () => "Tutar");
    textMap.putIfAbsent(LOT_ICI_ADEDI, () => "Lot İçi Adedi");
    textMap.putIfAbsent(LOT_ADEDI, () => "Lot Adedi");

  }

  static void setEnTexts() {
    textMap.clear();
    textMap.putIfAbsent(MOBILE_TITLE, () => "Teron Mobile");
    textMap.putIfAbsent(IP_AYARLARI, () => "Ip Settings");
    textMap.putIfAbsent(GIRIS_YAPILIYOR, () => "Entering");
    textMap.putIfAbsent(GIRIS_BASARISIZ, () => "Entering failed");
    textMap.putIfAbsent(SISTEM_YUKLENIYOR, () => "System Loading..");
    textMap.putIfAbsent(KULLANICI_ADI, () => "Username");
    textMap.putIfAbsent(SIFRE, () => "Password");
    textMap.putIfAbsent(SIRKET, () => "Company");
    textMap.putIfAbsent(DONEM, () => "Period");
    textMap.putIfAbsent(GIRIS, () => "Enter");
    textMap.putIfAbsent(CIKIS, () => "Exit");
    textMap.putIfAbsent(ICIP, () => "Inside Ip");
    textMap.putIfAbsent(ICPORT, () => "Inside Port");
    textMap.putIfAbsent(DISIP, () => "Outside Ip");
    textMap.putIfAbsent(DISPORT, () => "Outside Port");
    textMap.putIfAbsent(TAMAM, () => "Ok");
    textMap.putIfAbsent(ANA_MENU, () => "Main Menu");
    textMap.putIfAbsent(SIPARIS_ISLEMLERI, () => "Order Processing");
    textMap.putIfAbsent(STOK_ISLEMLERI, () => "Stock transactions");
    textMap.putIfAbsent(MUSTERI_SIPARISI, () => "Customer Order");
    textMap.putIfAbsent(MAL_ALIM, () => "Purchase of Material");
    textMap.putIfAbsent(TOPTAN_SATIS, () => "Whole Sale");
    textMap.putIfAbsent(PERAKENDE_SATIS, () => "Retail Sale");
    textMap.putIfAbsent(URETIM, () => "Production");
    textMap.putIfAbsent(BASLIK, () => "Head");
    textMap.putIfAbsent(DETAY, () => "Detail");
    textMap.putIfAbsent(OZET, () => "Summary");
    textMap.putIfAbsent(EVET, () => "Yes");
    textMap.putIfAbsent(HAYIR, () => "No");
    textMap.putIfAbsent(SIL, () => "Delete");
    textMap.putIfAbsent(DUZENLE, () => "Edit");
    textMap.putIfAbsent(KAYDET, () => "Save");

      textMap.putIfAbsent(SIPARIS_TARIHI, () => "Order Date");
    textMap.putIfAbsent(TERMIN_TARIHI, () => "Deadline Date");
    textMap.putIfAbsent(CARI_KODU, () => "Customer Code");
    textMap.putIfAbsent(CARI_ADI, () => "Customer Name");
    textMap.putIfAbsent(SEVK_CARI_KODU, () => "Referral Client Code");
    textMap.putIfAbsent(SEVK_CARI_ADI, () => "Referral Client Name");
    textMap.putIfAbsent(DEPO_KODU, () => "Warehouse Code");
    textMap.putIfAbsent(DEPO_ADI, () => "Warehouse Name");
    textMap.putIfAbsent(MUSTERI_SIPARIS_NO, () => "Customer Order No");
    textMap.putIfAbsent(ACIKLAMA, () => "Explanation");
    textMap.putIfAbsent(BARKOD, () => "Barcode");
    textMap.putIfAbsent(STOK_KODU, () => "Stock Code");
    textMap.putIfAbsent(STOK_ADI, () => "Stock Name");
    textMap.putIfAbsent(RENK, () => "Color");
    textMap.putIfAbsent(BEDEN, () => "Body Size");
    textMap.putIfAbsent(ADET, () => "Piece");
    textMap.putIfAbsent(TARIH, () => "Date");
    textMap.putIfAbsent(SEVK_TARIHI, () => "Referral Date");
    textMap.putIfAbsent(GIRIS_DEPO_KODU, () => "Entering Repository Code");
    textMap.putIfAbsent(GIRIS_DEPO_ADI, () => "Entering Repository Name");
    textMap.putIfAbsent(CIKIS_DEPO_KODU, () => "Exiting Warehouse Code");
    textMap.putIfAbsent(CIKIS_DEPO_ADI, () => "Exiting Warehouse Name");
    textMap.putIfAbsent(PARA_BIRIMI, () => "Currency Unit");
    textMap.putIfAbsent(FIYAT, () => "Price");
    textMap.putIfAbsent(FIS_TIPI, () => "Receipt Type");
    textMap.putIfAbsent(KODU, () => "Code");
    textMap.putIfAbsent(ADI, () => "Name");
    textMap.putIfAbsent(TOPLAM_ADET, () => "Total Piece");
    textMap.putIfAbsent(MIKTAR, () => "Quantity");
    textMap.putIfAbsent(TUTAR, () => "Amount");
    textMap.putIfAbsent(LOT_ICI_ADEDI, () => "In Lot Piece");
    textMap.putIfAbsent(LOT_ADEDI, () => "Lot Piece");
  }

  static String getText(String key) {
    return textMap[key];
  }
}
