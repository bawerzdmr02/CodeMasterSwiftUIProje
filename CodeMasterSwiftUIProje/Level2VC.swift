//
//  Level2VC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct Level2VC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var ilerlemeDurumu = 0.625
    
    @State var isActiveLevel2Quiz = false
    
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var level2KonuIcerik : Level2KonuIcerik
    
    var level2QuizIcerik : [Soru2] {
        
        switch level2KonuIcerik.baslik{
            
            //C# Level2Quiz soruları
            case "Veri Tipleri ve Tür Dönüşümleri":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Asagidaki kodun çıktısı nedir?", cevaplar: [
                    "Derleme hatası verir.",
                    "42.0 ",
                    "42",
                    "Hata: int, double’a atanamaz"
                ] , gorsel: "level2QuizDegisenC1.1" , cevapIndex: 1),//gorsel
                           Soru2(baslik: "Uygulama 2", icerik: "Asagidaki kod çalıştırıldığında ekrana ne yazdırır?", cevaplar: [
                            "3",
                            "3.14",
                            "Hata verir",
                            "0"
                            
                           ], gorsel: "level2QuizDegisenC1.2" , cevapIndex: 0),//gorsel
                           Soru2(baslik: "Uygulama 3", icerik: "Bu kod çalıştırıldığında hangi veri tipi kullanılmış olur?", cevaplar: [
                            
                            "System.Int32",
                            "System.Object",
                            "System.Boolean",
                            "System.String"
                            
                           ] , gorsel: "level2QuizDegisenC1.3" , cevapIndex: 3)//gorsel
                ]
                
                
            case "Switch-case Kullanımı ve Ternary Operatör":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Bu kodun çıktısı nedir?", cevaplar: [
                    "Pazartesi",
                    "Salı",
                    "Çarşamba",
                    "Bilinmeyen gün"
                ] , gorsel: "level2QuizIfC1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Asagidaki kodda secim değişkeni hangi sonucu üretir?", cevaplar: [
                            "1 seçildi",
                            "2 seçildi",
                            "Geçersiz seçim",
                            "Hata verir"
                            
                           ], gorsel: "level2QuizIfC1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Bu kod çalıştırıldığında ne yazdırır?", cevaplar: [
                            
                            "Reşitsiniz",
                            "Reşit değilsiniz",
                            "Hata verir",
                            "True"
                            
                           ] , gorsel: "level2QuizIfC1.3" , cevapIndex: 0)
                ]
                
                
            case "while, do-while ve break/continue":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Kod çalıştırıldığında çıktı ne olur?", cevaplar: [
                    "0 1 2",
                    "1 2 3",
                    "0 1 2 3",
                    "Sonsuz döngü"
                ] , gorsel: "level2QuizWhileC1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Bu kodun çıktısı ne olur?", cevaplar: [
                            "Hiçbir şey yazdırmaz",
                            "Sonsuz döngü",
                            "Çalıştı",
                            "Hata verir"
                            
                           ], gorsel: "level2QuizWhileC1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: " Kod çalıştırıldığında hangi sayılar yazdırılır?", cevaplar: [
                            
                            "0 1 2 3",
                            "0 1 3",
                            "0 1 2 3 4",
                            "0 1"
                            
                           ] , gorsel: "level2QuizWhileC1.3" , cevapIndex: 1)
                ]
                
            case "Metotlar: Parametre, Return ve Overloading":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Konsol çıktısı ne olur?", cevaplar: [
                    "23",
                    "5",
                    "a + b",
                    "Hata verir"
                ] , gorsel: "level2QuizMetotC1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Ekrana ne yazdırılır?", cevaplar: [
                            "MerhabaAhmet",
                            "Ahmet Merhaba",
                            "Hata verir",
                            "Merhaba Ahmet"
                            
                           ], gorsel: "level2QuizMetotC1.2" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 3", icerik: "Konsola hangi çıktılar yazılır?", cevaplar: [
                            
                            "6 ve 10",
                            "6 ve 10.0",
                            "Hata verir",
                            "2 ve 2.5"
                            
                           ] , gorsel: "level2QuizMetotC1.3" , cevapIndex: 1)
                ]
                
            case "Nesne Yönelimli Programlama (OOP) Prensipleri":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Kapsülleme kavramı bu örnekte nasıl uygulanmıştır?", cevaplar: [
                    "Değişkenler public tanımlanmıştır",
                    "Veriye doğrudan erişim sağlanmıştır",
                    "Değişkene sadece metodlarla erişilmektedir",
                    "Get ve Set metodları yoktur"
                ] , gorsel: "level2QuizSinifC1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Konsol çıktısı ne olur?", cevaplar: [
                            "Hata verir",
                            "Kedi sınıfı çalışmaz",
                            "Ses çıkarıyor…",
                            "Hayvan sınıfı çağrılmaz"
                            
                           ], gorsel: "level2QuizSinifC1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Bu kod çalıştırıldığında ne olur?", cevaplar: [
                            
                            "Şekil çiziliyor…",
                            "Daire çiziliyor…",
                            "Hata verir",
                            "Kod çalışmaz"
                            
                           ] , gorsel: "level2QuizSinifC1.3" , cevapIndex: 1)
                ]
                
                
            case "C# Dictionary Koleksiyonu":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Ali’nin notu kaçtır?", cevaplar: [
                    "85",
                    "78",
                    "90",
                    "Hata verir"
                ] , gorsel: "level2QuizKoleksiyonC1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Konsol çıktısı ne olur?", cevaplar: [
                            "10",
                            "20",
                            "30",
                            "Hata verir"
                            
                           ], gorsel: "level2QuizKoleksiyonC1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Kod çalıştığında hangi ifade doğru olur?", cevaplar: [
                            
                            "Anahtar ve şehirler yazdırılır",
                            "Sadece şehir isimleri yazdırılır",
                            "Hata verir",
                            "Liste boş olduğu için döngü çalışmaz"
                            
                           ] , gorsel: "level2QuizKoleksiyonC1.3" , cevapIndex: 0)
                ]
                
            case "C# Dosya Yazma İşlemleri":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kod parçasının çıktısı ne olur?", cevaplar: [
                    "test.txt dosyasına “CodeMaster” yazılır ve “Yazma işlemi tamamlandı.” mesajı konsola yazılır",
                    "test.txt dosyasına veri yazılmaz çünkü dosya oluşturulamaz",
                    "“Yazma işlemi tamamlandı.” mesajı konsola yazılır ama dosya oluşmaz",
                    "Konsola hiçbir şey yazılmaz"
                    
                ] , gorsel: "level2QuizDosyaC1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kod parçasının çıktısı ne olur?", cevaplar: [
                            "test.txt dosyasına hiçbir şey eklenmez",
                            "“Yeni satır yazıldı.” mesajı konsola yazılır ama dosya oluşmaz",
                            "Dosya silinir",
                            "test.txt dosyasına yeni satır eklenir ve “Yeni satır yazıldı.” mesajı konsola yazılır "
                            
                           ], gorsel: "level2QuizDosyaC1.2" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kod parçasının çıktısı ne olur?", cevaplar: [
                            
                            "“Yazma işlemi tamamlandı.” mesajı konsola yazılır",
                            "“Hata oluştu: …” mesajı konsola yazılır",
                            "Program çökmeden devam eder",
                            "Dosya silinir"
                            
                           ] , gorsel: "level2QuizDosyaC1.3" , cevapIndex: 1)
                ]
                
                
            case "C# Hata Yönetimi ve İstisna Sınıfları":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kod parçasının çıktısı ne olur?", cevaplar: [
                    "Hata: İndeks aralığı dışında Finally bloğu her durumda çalışır.",
                    "Hata: Dizinin boyutu fazla Finally bloğu her durumda çalışır.",
                    "Hata: Array index out of bounds Finally bloğu her durumda çalışır.",
                    "Hata: Indeks hatası Finally bloğu çalışmaz."
                ] , gorsel: "level2QuizHataC1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kod parçasının çıktısı ne olur?", cevaplar: [
                            "Hata: Giriş formatı geçersiz Finally bloğu çalıştı.",
                            "Hata: Format hatası Finally bloğu çalıştı.",
                            "Hata: Veritipinde uyumsuzluk Finally bloğu çalıştı.",
                            "Hata: String değeri int’e dönüştürülemez Finally bloğu çalışmaz."
                            
                           ], gorsel: "level2QuizHataC1.2" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kod parçasının çıktısı ne olur?", cevaplar: [
                            
                            "Hata oluştu: Geçersiz işlem. Finally bloğu çalıştı.",
                            "Genel hata: Geçersiz işlem. Finally bloğu çalıştı.",
                            "Hata oluştu: Geçersiz işlem. Hata oluştu: Geçersiz işlem.",
                            "Genel hata: Geçersiz işlem. Hata oluştu: Geçersiz işlem."
                            
                           ] , gorsel: "level2QuizHataC1.3" , cevapIndex: 0)
                ]
                
                
            //Python Level2Quiz soruları
            case "Python Veri Tipleri (Data Types)":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kodun çıktısı ne olacaktır?", cevaplar: [
                    "<class 'str'>",
                    "<class 'int'>",
                    "<class 'list'>",
                    "<class 'float'>"
                ] , gorsel: "level2QuizVeriPy1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodun çıktısı aşağıdaki seçeneklerden hangisiyle eşleşir?", cevaplar: [
                            "<class 'list'> <class 'str'> <class 'int'> <class 'bool'>",
                            "<class 'int'> <class 'float'> <class 'str'> <class 'bool'>",
                            "<class 'int'> <class 'str'> <class 'float'> <class 'bool'>",
                            "<class 'int'> <class 'str'> <class 'float'> <class 'list'>"
                            
                           ], gorsel: "level2QuizVeriPy1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kodun çıktısı ne olacaktır?", cevaplar: [
                            
                            "<class 'str'> <class 'bool'>",
                            "<class 'str'> <class 'int'>",
                            "<class 'int'> <class 'str'>",
                            "<class 'bool'> <class 'int'>"
                            
                           ] , gorsel: "level2QuizVeriPy1.3" , cevapIndex: 1)
                ]
                
                
            case "Birden Fazla Koşul – elif Kullanımı":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Yukarıdaki kodda, kullanıcının yaşı 25 olduğunda hangi mesaj yazdırılır?", cevaplar: [
                    "“Çocuk”",
                    "“Genç”",
                    "“Yetişkin”",
                    "“Yaşlı”"
                ] , gorsel: "level2QuizKosulPy1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Yukarıdaki kodda, sıcaklık 10 olduğunda hangi mesaj yazdırılır?", cevaplar: [
                            "“Dışarıda çok soğuk, kış kıyafeti giyin.”",
                            "“Dışarıda serin, mont giymelisiniz.”",
                            "“Hava güzel, rahat giyinin.”",
                            "“Çok sıcak, şort giyin.”"
                            
                           ], gorsel: "level2QuizKosulPy1.2" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 3", icerik: "Yukarıdaki kodda, kullanıcı notunu 85 olarak girdiğinde hangi harf notu yazdırılır?", cevaplar: [
                            
                            "“A”",
                            "“B”",
                            "“C”",
                            "“D”"
                            
                           ] , gorsel: "level2QuizKosulPy1.3" , cevapIndex: 1)
                ]
                
            case "while Döngüsü – Koşul Sağlandığı Sürece":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kodda, kullanıcı 3 girerse, hangi sayılar yazdırılır?", cevaplar: [
                    "1, 2, 3",
                    "0, 1, 2",
                    "1, 2",
                    "3, 4"
                ] , gorsel: "level2QuizWhilePy1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda, kullanıcı ilk olarak -5 girerse, program kullanıcıyı ne zaman doğru yaşa yönlendirir?", cevaplar: [
                            "Program hemen doğru yaşı alır.",
                            "Program hata mesajı gösterir ve kullanıcıdan tekrar veri ister",
                            "Program hata mesajı gösterir ama döngüye girmeden hemen doğru yaşı alır.",
                            "Program sürekli -5 yaşını kabul eder."
                            
                           ], gorsel: "level2QuizWhilePy1.2" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 3", icerik: "Yukarıdaki kodda, kullanıcı ilk olarak “0000” girerse, sistem ne zaman doğru şifreyi kabul eder?", cevaplar: [
                            
                            "Hemen giriş yapar.",
                            "“0000” girişiyle sisteme girilir.",
                            "Kullanıcı doğru şifreyi girene kadar döngü devam eder",
                            "Şifreyi doğru girmese bile hemen giriş yapılır."
                            
                           ] , gorsel: "level2QuizWhilePy1.3" , cevapIndex: 2)
                ]
                
            case "Parametreli ve Geri Değer Döndüren Fonksiyonlar":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kodda, kullanıcı 3 ve 5 girerse, ekranda hangi sonuç görünecektir?", cevaplar: [
                    "5",
                    "8",
                    "3",
                    "15"
                ] , gorsel: "level2QuizFuncPy1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda, kullanıcı 5 girerse, ekranda hangi sonuç görünecektir?", cevaplar: [
                            "5",
                            "120",
                            "25",
                            "15"
                            
                           ], gorsel: "level2QuizFuncPy1.2" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kodda, kullanıcı -3 girerse, ekranda hangi mesaj görünecektir?", cevaplar: [
                            
                            "Pozitif sayı!",
                            "Hata mesajı",
                            "Sıfır!",
                            "Negatif sayı!"
                            
                           ] , gorsel: "level2QuizFuncPy1.3" , cevapIndex: 3)
                ]
                
            case "Diziler (Arrays) - NumPy ile":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kodda, NumPy kütüphanesi ile bir dizi oluşturulmuştur. Bu dizinin elemanları ekrana yazdırılacaktır. Çıktısı ne olur?", cevaplar: [
                    "[1, 2, 3, 4, 5]",
                    "(1, 2, 3, 4, 5)",
                    "[1 2 3 4 5]",
                    "[1,2,3,4,5]"
                ] , gorsel: "level2QuizDiziPy1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda, NumPy dizileri ile matematiksel işlemler yapılmaktadır. Bu örnekte, her eleman 10 ile çarpılacaktır. Çıktı nedir?", cevaplar: [
                            "[1, 2, 3, 4, 5]",
                            "[10, 10, 10, 10, 10]",
                            "[100, 200, 300, 400, 500]",
                            "[10, 20, 30, 40, 50]"
                            
                           ], gorsel: "level2QuizDiziPy1.2" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kodda, NumPy dizisinin belirli bir elemanına nasıl erişileceği gösterilmektedir. Kod çalıştırıldığında hangi eleman yazdırılır?", cevaplar: [
                            
                            "10",
                            "20",
                            "30",
                            "40"
                            
                           ] , gorsel: "level2QuizDiziPy1.3" , cevapIndex: 2)
                ]
                
            case "Sözlük İşlemleri ve Metotları":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki Python kodu bir sözlük oluşturur ve yeni bir anahtar-değer çifti ekler. Çıktı ne olur?", cevaplar: [
                    "{\"isim\": \"Ahmet\", \"yas\": 25, \"sehir\": \"İstanbul\"}",
                    "{\"isim\": \"Ahmet\", \"yas\": 25 }",
                    "{\"isim\": \"Ahmet\", \"sehir\": \"İstanbul\"}",
                    "{\"yas\": 25, \"sehir\": \"İstanbul\"}"
                ] , gorsel: "level2QuizSozlukPy1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda, sözlükteki bir anahtarın değeri güncellenmektedir. Hangi anahtarın değeri değiştirilmiştir?", cevaplar: [
                            "yas",
                            "sehir",
                            "isim",
                            "yas ve isim"
                            
                           ], gorsel: "level2QuizSozlukPy1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki Python kodu, bir sözlükten anahtar-değer çiftini siler. Hangi anahtar silinmiştir?", cevaplar: [
                            
                            "isim",
                            "yas",
                            "sehir",
                            "yas ve isim"
                            
                           ] , gorsel: "level2QuizSozlukPy1.3" , cevapIndex: 1)
                ]
                
            case "Dosya Yazma (File Writing)" :
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kod çalıştırıldığında notlar.txt dosyasının içeriği ne olur?", cevaplar: [
                    "notlar.txt silinir",
                    "notlar.txt içine hiçbir şey yazılmaz",
                    "notlar.txt içinde Python çalışıyorum! yazar",
                    "notlar.txt sadece oluşturulur, boş kalır"
                ] , gorsel: "level2QuizDosyaPy1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kod satırı ne işe yarar?", cevaplar: [
                            "Yeni bir dosya oluşturur, eskiyi siler",
                            "Dosya oluşturmaz çünkü sadece okuma modudur",
                            "Dosyanın tüm içeriğini siler",
                            "Dosya varsa sonuna ekleme yapar, yoksa oluşturur"
                            
                           ], gorsel: "level2QuizDosyaPy1.2" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 3", icerik: "Bu kod bloğu çalıştırıldığında hangi satır eksik kalmış olabilir?", cevaplar: [
                            
                            "dosya.open()",
                            "dosya.append()",
                            "osya.close()",
                            "dosya.read()"
                            
                           ] , gorsel: "level2QuizDosyaPy1.3" , cevapIndex: 2)
                ]
                
            case "Try-Except-Else-Finally Blokları (İleri Seviye Hata Yönetimi)":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kod çalıştırıldığında hangi blok(lar) kesinlikle çalışır?", cevaplar: [
                    "Sadece try",
                    "except ve finally ",
                    "try ve else",
                    "Sadece finally"
                ] , gorsel: "level2QuizTryPy1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodun çıktısı ne olur?", cevaplar: [
                            "Hata var",
                            "Dönüştürme başarılı",
                            "Dönüştürme başarılı Bitti ",
                            "Bitti"
                            
                           ], gorsel: "level2QuizTryPy1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: " Aşağıdaki kod parçasında hangi satır eksik bırakılmıştır?", cevaplar: [
                            
                            "dosya.write()",
                            "dosya.read()",
                            "exit()",
                            "dosya.close()"
                            
                           ] , gorsel: "level2QuizTryPy1.3" , cevapIndex: 3)
                ]
                
            //JavaScript Sorulari
            case "Scope (Kapsam) ve Hoisting (Yukarı Taşınma)":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Bu kod çalıştırıldığında ne olur?", cevaplar: [
                    "5 yazdırır",
                    "undefined yazdırır",
                    "Hata verir (ReferenceError)",
                    "Kod çalışmaz, syntax hatası oluşur"
                ] , gorsel: "level2QuizVeriJs1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Bu kodun çıktısı nedir?", cevaplar: [
                            "undefined",
                            "10",
                            "Hata verir",
                            "null"
                            
                           ], gorsel: "level2QuizVeriJs1.2" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 3", icerik: "Bu kod çalıştırıldığında ne olur?", cevaplar: [
                            
                            "20 yazdırır",
                            "undefined yazdırır",
                            "null yazdırır",
                            "Hata verir (ReferenceError: Cannot access ‘b’ before initialization)"
                            
                           ] , gorsel: "level2QuizVeriJs1.3" , cevapIndex: 0)
                ]
                
            case "switch-case Yapısı":
                
                return [Soru2(baslik: "Uygulama 1", icerik: " Bu kod çalıştırıldığında ekrana ne yazdırılır?", cevaplar: [
                    "Muz seçildi",
                    "Elma seçildi",
                    "Çilek seçildi",
                    "Bilinmeyen meyve"
                ] , gorsel: "level2QuizSwitchJs1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Bu kodun çıktısı ne olur?", cevaplar: [
                            "Puan: A",
                            "Puan: B",
                            "Puan: C",
                            "Puan: D"
                            
                           ], gorsel: "level2QuizSwitchJs1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Kod çalıştırıldığında ne olur?", cevaplar: [
                            
                            "kırmızı yazdırılır",
                            "sarı yazdırılır",
                            "Renk bulunamadı",
                            "Hiçbir şey yazdırılmaz"
                            
                           ] , gorsel: "level2QuizSwitchJs1.3" , cevapIndex: 2)
                ]
                
            case "while Döngüsü" :
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Bu kod çalıştırıldığında ekrana ne yazdırılır?", cevaplar: [
                    "1 2 3",
                    "0 1 2",
                    "0 1 2 3",
                    "1 2"
                ] , gorsel: "level2QuizWhileJs1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Bu kodun çıktısı nedir?", cevaplar: [
                            "1",
                            "3",
                            "5",
                            "0"
                            
                           ], gorsel: "level2QuizWhileJs1.2" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 3", icerik: "Konsola hangi sayılar yazdırılır?", cevaplar: [
                            
                            "1 2 3 4",
                            "1 3",
                            "1 2 3",
                            "2 4"
                            
                           ] , gorsel: "level2QuizWhileJs1.3" , cevapIndex: 1)
                ]
                
            case "Arrow Functions (Ok Fonksiyonları) ile Kısa Fonksiyonlar" :
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Bu kodun çıktısı nedir?", cevaplar: [
                    "“a + b”",
                    "undefined",
                    "8",
                    "NaN"
                ] , gorsel: "level2QuizFuncJs1.1" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 2", icerik: "Konsola ne yazdırılır?", cevaplar: [
                            "Merhaba",
                            "isim",
                            "Merhaba Bawer",
                            "undefined"
                            
                           ], gorsel: "level2QuizFuncJs1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Bu fonksiyonun çıktısı nedir?", cevaplar: [
                            
                            "8",
                            "16",
                            "4",
                            "Error"
                            
                           ] , gorsel: "level2QuizFuncJs1.3" , cevapIndex: 1)
                ]
                
            case "DOM Öğeleri Üzerinde Değişiklik Yapma":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Bu kod ne işe yarar?", cevaplar: [
                    "Sayfanın başlığını siler",
                    "id=\"baslik\" olan öğenin metnini değiştirir",
                    "Konsola yazı yazar",
                    "Yeni bir element oluşturur"
                ] , gorsel: "level2QuizDomJs1.1" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kodun etkisi nedir?", cevaplar: [
                            ".kutu sınıfına yeni bir class ekler",
                            "Sayfadaki tüm yazıları yeşil yapar",
                            ".kutu sınıfına sahip öğenin arka plan rengini yeşil yapar",
                            ".kutu sınıfına sahip öğeyi siler"
                            
                           ], gorsel: "level2QuizDomJs1.2" , cevapIndex: 2),
                           Soru2(baslik: "Uygulama 3", icerik: "Bu kod ne yapar?", cevaplar: [
                            
                            ".kart öğesini gizler",
                            "aktif sınıfını tüm öğelere ekler",
                            "Tüm sınıfları siler",
                            ".kart öğesinden aktif sınıfını kaldırır"
                            
                           ] , gorsel: "level2QuizDomJs1.3" , cevapIndex: 3)
                ]
                
            case "Gelişmiş Event Listener Kullanımı":
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kodda, hangi metot button öğesine tıklandığında alert fonksiyonunu çağırır?", cevaplar: [
                    ".addEventListener()",
                    ".removeEventListener()",
                    ".e.preventDefault()",
                    ".setAttribute()"
                ] , gorsel: "level2QuizEventJs1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kod parçası ne işe yarar?", cevaplar: [
                            "click olayına bağlı başka fonksiyon çalıştırılamaz.",
                            "Olay gerçekleştiğinde alert() fonksiyonu çağrılır ve event.preventDefault() hiçbir işlev görmez.",
                            "click olayı tamamen engellenir.",
                            "Olay gerçekleştiğinde alert() fonksiyonu çağrılır ve form gönderimi durdurulur."
                            
                           ], gorsel: "level2QuizEventJs1.2" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kodda hangi olay kaldırılır?", cevaplar: [
                            
                            "mouseover olayı",
                            "click olayı",
                            "focus olayı",
                            "keydown olayı"
                            
                           ] , gorsel: "level2QuizEventJs1.3" , cevapIndex: 1)
                ]
                
            case "Axios ile API’den Veri Çekme" :
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki kodda, Axios kütüphanesi ile veri çekme işleminde doğru kullanım nedir?", cevaplar: [
                    ".get() metodu ile veri alındıktan sonra .then() fonksiyonu çalışır ve veriyi alır.",
                    ".get() metodu ile veri alındıktan sonra .catch() fonksiyonu çalışır ve hata yakalanır.",
                    ".then() ve .catch() fonksiyonları sırasıyla hata oluşması durumunda çalışır.",
                    ".get() fonksiyonu kullanılmaz, doğrudan .catch() kullanılır."
                ] , gorsel: "level2QuizApiJs1.1" , cevapIndex: 0),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kod parçası hangi tür HTTP isteği yapmak için kullanılır?", cevaplar: [
                            "GET isteği",
                            "POST isteği",
                            "PUT isteği",
                            "DELETE isteği"
                            
                           ], gorsel: "level2QuizApiJs1.2" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kodda, API’den veri çekerken hata durumunda hangi kod çalışacaktır?", cevaplar: [
                            
                            ".then() her durumda çalışır, hata ise .catch() ile yakalanmaz.",
                            ".catch() yalnızca veri çekilirken sorun olursa çalışır.",
                            "Eğer API’den veri alınırsa .then() çalışır, hata olursa .catch() çalışır.",
                            "Hata yakalanmaz, işlem durur."
                            
                           ] , gorsel: "level2QuizApiJs1.3" , cevapIndex: 2)
                ]
                
            case "try-catch-finally Yapısında finally Kullanımı" :
                
                return [Soru2(baslik: "Uygulama 1", icerik: "Aşağıdaki JavaScript kodu çalıştırıldığında console’a hangi çıktı yazılır?", cevaplar: [
                    "İşlem başlatılıyor…",
                    "Hata yakalandı: Bir hata oluştu!",
                    "Temizlik işlemleri tamamlandı.",
                    "Hepsi"
                ] , gorsel: "level2QuizTryJs1.1" , cevapIndex: 3),
                           Soru2(baslik: "Uygulama 2", icerik: "Aşağıdaki kod bloğunda finally bloğu hangi durumda çalışmaz?", cevaplar: [
                            "Kod düzgün çalışırsa",
                            "Tarayıcı kapanmadan önce kod durdurulmazsa",
                            "Kod hata verirse",
                            "Hata vermez ama try bloğu içindeki kod tamamlanmazsa"
                            
                           ], gorsel: "level2QuizTryJs1.2" , cevapIndex: 1),
                           Soru2(baslik: "Uygulama 3", icerik: "Aşağıdaki kodda finally bloğunun amacı nedir?", cevaplar: [
                            
                            "Hata oluşursa catch çalışmaz",
                            "finally bloğu yalnızca hata olursa çalışır",
                            "Dosyanın her durumda kapatılmasını sağlamak",
                            "Dosya işleme işlemleri yapılır"
                            
                           ] , gorsel: "level2QuizTryJs1.3" , cevapIndex: 2)]
                
        default:
            return  [Soru2(baslik: "Uygulama 1", icerik: "Asagidaki kodun çıktısı nedir?", cevaplar: [
                "Derleme hatası verir.",
                "42.0 ",
                "42",
                "Hata: int, double’a atanamaz"
            ] , gorsel: "level2QuizDegisenC1.1" , cevapIndex: 1),//gorsel
                       Soru2(baslik: "Uygulama 2", icerik: "Asagidaki kod çalıştırıldığında ekrana ne yazdırır?", cevaplar: [
                        "3",
                        "3.14",
                        "Hata verir",
                        "0"
                        
                       ], gorsel: "level2QuizDegisenC1.2" , cevapIndex: 0),//gorsel
                       Soru2(baslik: "Uygulama 3", icerik: "Bu kod çalıştırıldığında hangi veri tipi kullanılmış olur?", cevaplar: [
                        
                        "System.Int32",
                        "System.Object",
                        "System.Boolean",
                        "System.String"
                        
                       ] , gorsel: "level2QuizDegisenC1.3" , cevapIndex: 3)//gorsel
            ]
        }
        
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // 1. ARKA PLAN (Glassmorphism ve taşma korumalı)
                Image("arkaPlan")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay(.ultraThinMaterial)
                
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                // 2. KAYDIRILABİLİR İÇERİK
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // İLERLEME ÇUBUĞU BÖLÜMÜ (Şık kart görünümü)
                        VStack(spacing: 12) {
                            Text("Öğrenme İlerlemesi")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.white.opacity(0.8))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 15) {
                                // Özel Progress Bar
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Capsule()
                                            .fill(Color.white.opacity(0.15))
                                            .frame(height: 12)
                                        
                                        Capsule()
                                            .fill(
                                                LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .leading, endPoint: .trailing)
                                            )
                                            .frame(width: geometry.size.width * CGFloat(ilerlemeDurumu), height: 12)
                                            .shadow(color: .orange.opacity(0.5), radius: 5, x: 0, y: 0)
                                    }
                                }
                                .frame(height: 12)
                                
                                Text("\(Int(ilerlemeDurumu * 100))%")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                        .padding(.top, 15)
                        
                        // KONU BİLGİ KARTI (Yazıların kesilmediği güvenli alan)
                        VStack(alignment: .leading, spacing: 16) {
                            Text(level2KonuIcerik.baslik)
                                .font(.system(size: 26, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple, .clear]), startPoint: .leading, endPoint: .trailing))
                                .frame(height: 3)
                                .cornerRadius(1.5)
                                .padding(.bottom, 4)
                            
                            Text(level2KonuIcerik.aciklama)
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                                .lineSpacing(8)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                        
                        // DERS GÖRSELLERİ (GRID YAPISI)
                        if !level2KonuIcerik.gorseller.isEmpty {
                            Text("Ders Görselleri")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.top, 10)
                                .padding(.leading, 8)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(self.level2KonuIcerik.gorseller, id: \.self) { detay in
                                    NavigationLink(destination: GorselView(gorselIsmi: detay)) {
                                        
                                        // HİZALAMA HATASININ ÇÖZÜMÜ: minWidth ve maxWidth eklendi!
                                        Image(detay)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120, maxHeight: 120) // Hücreye zorla oturtur
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                            )
                                            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 5)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        
                        // Yüzen butonun arkasında kalmaması için boşluk
                        Spacer().frame(height: 120)
                        
                    }
                    .padding(.horizontal, 24) // Sağdan soldan taşmayı kesin engeller
                }
                
                // 3. YÜZEN BUTON (FLOATING ACTION BUTTON) - Quiz'e geçiş
                VStack {
                    Spacer()
                    
                    Button(action: {
                        isActiveLevel2Quiz = true
                        
                        let csharpTopics: [String] = [
                            "Veri Tipleri ve Tür Dönüşümleri",
                            "Switch-case Kullanımı ve Ternary Operatör",
                            "while, do-while ve break/continue",
                            "Metotlar: Parametre, Return ve Overloading",
                            "Nesne Yönelimli Programlama (OOP) Prensipleri",
                            "C# Dictionary Koleksiyonu",
                            "C# Dosya Yazma İşlemleri",
                            "C# Hata Yönetimi ve İstisna Sınıfları"
                        ]

                        let pythonTopics: [String] = [
                            "Python Veri Tipleri (Data Types)",
                            "Birden Fazla Koşul – elif Kullanımı",
                            "while Döngüsü – Koşul Sağlandığı Sürece",
                            "Parametreli ve Geri Değer Döndüren Fonksiyonlar",
                            "Diziler (Arrays) - NumPy ile",
                            "Sözlük İşlemleri ve Metotları",
                            "Dosya Yazma (File Writing)",
                            "Try-Except-Else-Finally Blokları (İleri Seviye Hata Yönetimi)"
                        ]

                        let javascriptTopics: [String] = [
                            "Scope (Kapsam) ve Hoisting (Yukarı Taşınma)",
                            "switch-case Yapısı",
                            "while Döngüsü",
                            "Arrow Functions (Ok Fonksiyonları) ile Kısa Fonksiyonlar",
                            "DOM Öğeleri Üzerinde Değişiklik Yapma",
                            "Gelişmiş Event Listener Kullanımı",
                            "Axios ile API’den Veri Çekme",
                            "try-catch-finally Yapısında finally Kullanımı"
                        ]

                        let topic = level2KonuIcerik.baslik

                        if csharpTopics.contains(topic) {
                            guncelleCSharpIlerleme(level: 2, topic: topic)
                        } else if pythonTopics.contains(topic) {
                            guncellePythonIlerleme(level: 2, topic: topic)
                        } else if javascriptTopics.contains(topic) {
                            guncelleJavaIlerleme(level: 2, topic: topic)
                        }
                        
                    }) {
                        HStack(spacing: 12) {
                            Text("Quiz'e Geç")
                                .font(.system(size: 19, weight: .bold, design: .rounded))
                            
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 22, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(16)
                        .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .ignoresSafeArea(edges: .bottom)
                
                // Görünmeyen NavigationLink
                NavigationLink(destination: Level2QuizVC(level2KonuIcerik: self.level2KonuIcerik , level2QuizIcerik: self.level2QuizIcerik).navigationBarBackButtonHidden(true), isActive: $isActiveLevel2Quiz) {
                    EmptyView()
                }
            }
        }
    }
    
    // Python için ilerleme kaydetme
    func guncellePythonIlerleme(level: Int, topic: String) {
        if let email = UserDefaults.standard.string(forKey: "girisYapanKullanici") {
            let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                if let user = try viewContext.fetch(fetchRequest).first {
                    user.pythonProgressLevel = Int16(level)
                    user.pythonCurrentTopic = topic
                    try viewContext.save()
                    print("Python ilerlemesi güncellendi.")
                }
            } catch {
                print("Python ilerlemesi güncellenirken hata oluştu: \(error.localizedDescription)")
            }
        }
    }

    // C# için ilerleme kaydetme
    func guncelleCSharpIlerleme(level: Int, topic: String) {
        if let email = UserDefaults.standard.string(forKey: "girisYapanKullanici") {
            let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                if let user = try viewContext.fetch(fetchRequest).first {
                    user.csharpProgressLevel = Int16(level)
                    user.csharpCurrentTopic = topic
                    try viewContext.save()
                    print("C# ilerlemesi güncellendi.")
                }
            } catch {
                print("C# ilerlemesi güncellenirken hata oluştu: \(error.localizedDescription)")
            }
        }
    }

    // Java için ilerleme kaydetme
    func guncelleJavaIlerleme(level: Int, topic: String) {
        if let email = UserDefaults.standard.string(forKey: "girisYapanKullanici") {
            let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                if let user = try viewContext.fetch(fetchRequest).first {
                    user.javaProgressLevel = Int16(level)
                    user.javaCurrentTopic = topic
                    try viewContext.save()
                    print("Java ilerlemesi güncellendi.")
                }
            } catch {
                print("Java ilerlemesi güncellenirken hata oluştu: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    Level2VC(ilerlemeDurumu: 0.00, level2KonuIcerik: Level2KonuIcerik(baslik: "Veri Tipleri ve Tür Dönüşümleri",
                                                                      aciklama: "C# dilinde veri tipleri, değişkenlerin bellekte nasıl tutulacağını belirler. Değer tipleri (int, double, bool vs.) ve referans tipleri (string, object, array vs.) şeklinde iki ana gruba ayrılır. Farklı veri türleri arasında geçiş yapmak için tür dönüşümleri kullanılır. Bu dönüşümler açık (explicit) veya kapalı (implicit) olabilir. Ayrıca var, dynamic gibi esnek türler, yazımı kolaylaştırmak için kullanılabilir.",
                                                                      gorseller: ["level2VeriC1.1","level2VeriC1.2","level2VeriC1.3","level2VeriC1.4"]))
}
