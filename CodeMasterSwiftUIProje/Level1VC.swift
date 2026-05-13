//
//  Level1VC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct Level1VC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var ilerlemeDurumu = 0.125
    
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]

    @State var isActiveLevel1Quiz = false
    
    var level1konuIcerik : LevelKonuIcerik
    
    var levelQuizIcerik : [Soru] {
        
        switch level1konuIcerik.baslik{
            
        case "C# Değişkenler (Variables)":
            
            return [Soru(baslik: "Uygulama 1", icerik: "C# dilinde geçerli bir değişken tanımı aşağıdakilerden hangisidir?", cevaplar: [
                "int sayi = 5;",
                "sayi = int 5;",
                "int = 5 sayi;",
                "integer sayi 5 =;"
            ] , gorsel: "" , cevapIndex: 0),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdakilerden hangisi C# dilinde console ekranına değer yazmak için kullanılır?", cevaplar: [
                        "Console.ReadKey()",
                        "Console.Read()",
                        "Console.ReadLine()",
                        "Console.WriteLine()"
                        
                       ], gorsel: "" , cevapIndex: 3),
                       Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki kodda, a ve b değişkenlerini kullanarak toplama işlemi yapmanız gerekiyor. Eksik kısma gelmesi gerek kod satırı nedir?", cevaplar: [
                        
                        "a + b = sonuc",
                        "sonuc = a + b;",
                        "int sonuc = a + b",
                        "sonuc a = b"
                        
                       ] , gorsel: "level1C1" , cevapIndex: 1)
            ]
            
        case "C# Temel Koşullu İfadeler":
            
            return [Soru(baslik: "Uygulama 1", icerik: "if-else if yapısı hangi durumda kullanılır?", cevaplar: [
                "Sadece bir koşulu kontrol etmek için",
                "Döngü oluşturmak için",
                "Birden fazla koşulu sırayla kontrol etmek için",
                "Her zaman true olan ifadeleri çalıştırmak için"
            ] , gorsel: "" , cevapIndex: 2),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdakilerden hangisi bir if-else yapısını doğru şekilde göstermektedir?", cevaplar: [
                        "if x = 5 then { ... } else { ... }",
                        "if(x == 5) { ... } else { ... }",
                        "if x == 5: doThis(); else doThat();",
                        "if (x = 5) { ... } else { ... }"
                        
                       ], gorsel: "" , cevapIndex: 1),
                       Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki kod parçasında Console.WriteLine('Büyük'); satırı ne zaman çalışır?", cevaplar: [
                        
                        "sayi 5 olduğunda",
                        "sayi 10 olduğunda",
                        "sayi 25 olduğunda",
                        "sayi 0 olduğunda"
                        
                       ] , gorsel: "level1C2" , cevapIndex: 2)
            ]
            
            
        case "C# Döngüler -> For Döngüsü":
                        
            return [Soru(baslik: "Uygulama 1" ,icerik: "C# dilinde for döngüsü hangi amaçla kullanılır?" ,cevaplar: [
                
                "Sonsuz döngü oluşturmak için",
                "Belirsiz sayıda tekrar yapmak için",
                "Belirli sayıda tekrar yapmak için",
                "Şart kontrolü olmadan kod çalıştırmak için"
                
            ] , gorsel: "" , cevapIndex: 2),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki for döngüsü kaç kez çalışır?", cevaplar: [
                        "4 kez",
                        "5 kez",
                        "6 kez",
                        "Hiç çalışmaz"
                                    
                        ], gorsel: "level1C3" , cevapIndex: 1),
                                Soru(baslik: "Uygulama 3", icerik: "Aşağıdakilerden hangisi C# dilinde geçerli bir for döngüsü tanımıdır?", cevaplar: [
                                    
                                    "for i = 0 to 10",
                                    "for(int i = 0; i < 10; i++)",
                                    "loop(int i = 0; i < 10; i++)",
                                    "for(int i < 10; i++; i = 0)"
                                    
                                ] , gorsel: "" , cevapIndex: 0 )
            ]
            
        case "C# Metotlar":
                        
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdakilerden hangisi C# dilinde bir metot tanımıdır?" ,cevaplar: [
                
                "Console.WriteLine(\"Merhaba\");",
                "void Yazdir() { Console.WriteLine(\"Merhaba\"); } ",
                "Yazdir = \"Merhaba\";",
                "metot Yazdir(\"Merhaba\");"
                
            ] , gorsel: "" , cevapIndex: 1),
                       Soru(baslik: "Uygulama 2", icerik: "Metotlar programlama içinde neden kullanılır?", cevaplar: [
                        
                        "Kodları daha yavaş çalıştırmak için",
                        "Kodun sadece bir kez çalışmasını sağlamak için",
                        "Kod tekrarını azaltmak ve işlemleri gruplamak için",
                        "Hataları gizlemek için"
                                    
                        ], gorsel: "" , cevapIndex: 2),
                                Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki örnekte Topla() metodunun görevi nedir?",cevaplar: [
                                    "a ve b’yi ekrana yazdırmak",
                                    "a ve b’yi çarpmak",
                                    "a ve b’yi toplamak ve sonucu döndürmek",
                                    "Sabit bir sayı döndürmek"
                                    
                                ] , gorsel: "level1C4" , cevapIndex: 2 )
            ]
            
        case "C# Sınıflar (Classes)":
                        
            return [Soru(baslik: "Uygulama 1" ,icerik: "C# dilinde sınıf nedir?" ,cevaplar: [
                
                "Bir nesnenin değişkenlerini ve davranışlarını tanımlar",
                "Yalnızca değişkenleri tanımlar",
                "Yalnızca metodları tanımlar",
                "Bir yazılımın çalışmasını engeller"
                
            ] , gorsel: "" , cevapIndex: 0),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki sınıf tanımında eksik olan kısım nedir?", cevaplar: [
                        
                        "Sınıfın yapıcı fonksiyonu (constructor) eksik",
                        "ArabaBilgisi fonksiyonunun tipi eksik",
                        "Değişkenler public olmalı",
                        "ArabaBilgisi fonksiyonu doğru, eksik bir şey yok"
                                    
                        ], gorsel: "level1C5.1" , cevapIndex: 1),
                                Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki Araba sınıfı kullanılarak bir Araba nesnesi oluşturmak için doğru kod nedir?",cevaplar: [
                                    
                                    "Araba a = new Araba();",
                                    "Araba a = new Araba(\"BMW\", 2020);",
                                    "Araba a = new Araba(); a.ArabaBilgisi();",
                                    "Araba a = Araba(\"BMW\", 2020);"
                                    
                                ] , gorsel: "level1C5.2" , cevapIndex: 1 )
            ]
            
            
        case "C# List Koleksiyonu":
                        
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki seçeneklerden hangisi C# List sınıfının temel özelliklerinden biridir?" ,cevaplar: [
                
                "Listeler sadece tek türdeki öğeleri saklar",
                "Listeler sadece int türündeki öğeleri saklar",
                "Listeler sabit boyutludur",
                "Listeler yalnızca bir kez veri saklayabilir"
                
            ] , gorsel: "" , cevapIndex: 0),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki C# List kodu hangi işlemle ilgilidir?", cevaplar: [
                        
                        "Listeyi sıralamak",
                        "Listeyi tersine çevirmek",
                        "Listeyi silmek",
                        "Listeye öğe eklemek"
                                    
                        ], gorsel: "level1C6" , cevapIndex: 3),
                                Soru(baslik: "Uygulama 3", icerik: "C# Listesi ile ilgili aşağıdaki ifadelerden hangisi doğrudur?",cevaplar: [
                                    
                                    "List<T>’in boyutu sabittir, yeni öğe eklenemez.",
                                    "List<T>’in elemanları sabittir, değiştirilemez.",
                                    "List<T> dinamik olarak büyüyebilir ve öğe sayısı arttıkça kendini günceller",
                                    "List<T> yalnızca bir öğe türünü tutabilir, öğeler karışık olamaz."
                                    
                                ] , gorsel: "" , cevapIndex: 2 )
            ]
            
        case "C# Dosya Okuma İşlemleri":
                        
            return [Soru(baslik: "Uygulama 1" ,icerik: "C# dilinde dosya okuma işlemi yapmak için hangi namespace kullanılır?" ,cevaplar: [
                
                "System.Collections",
                "System.IO",
                "System.Net",
                "System.Text"
                
            ] , gorsel: "" , cevapIndex: 1),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kod parçası hangi dosya okuma sınıfını kullanır?", cevaplar: [
                        
                        "StreamWriter",
                        "FileStream",
                        "StreamReader",
                        "FileReader"
                                    
                        ], gorsel: "level1C7.1" , cevapIndex: 2),
                                Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki C# kodu ile dosyadan hangi işlemi yapıyoruz?",cevaplar: [
                                    
                                    "Dosyaya yazma işlemi",
                                    "Dosyayı okuma işlemi",
                                    "Dosyayı silme işlemi",
                                    "Dosyaya satır ekleme işlemi"
                                    
                                ] , gorsel: "level1C7.2" , cevapIndex: 1 )
            ]
            
            
        case "C# Hata Yönetimi":
                        
            return [Soru(baslik: "Uygulama 1" ,icerik: "C# dilinde hata yönetimi yapmak için hangi anahtar kelimeler kullanılır?" ,cevaplar: [
                
                "throw-catch",
                "try-catch-finally",
                "error-except",
                "catch-finally"
                
            ] , gorsel: "" , cevapIndex: 1),
                       Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki C# try-catch bloğu hangi hatayı yakalar?", cevaplar: [
                        
                        "DivideByZeroException",
                        "NullReferenceException",
                        "FormatException",
                        "IndexOutOfRangeException"
                                    
                        ], gorsel: "level1C8.1" , cevapIndex: 2),
                                Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki C# kodu hangi durumda hata yönetimi sağlar?",cevaplar: [
                                    
                                    "try bloğunda herhangi bir hata yok",
                                    "catch bloğu yalnızca hatalı işlemleri yakalar",
                                    "finally bloğu yalnızca hata olduğunda çalışır",
                                    "catch bloğu hiçbir durumda çalışmaz"
                                    
                                ] , gorsel: "level1C8.2" , cevapIndex: 1 )
            ]
            
            
            
            //Python Level1Quiz soruları
            case "Python Değişkenler(Variables)":
                            
                return [Soru(baslik: "Uygulama 1" ,icerik: "x = 10 Python kodunda hangi veri türü otomatik olarak atanır?" ,cevaplar: [
                    
                    "int",
                    "float",
                    "string",
                    "double"
                    
                ] , gorsel: "" , cevapIndex: 0),
                           Soru(baslik: "Uygulama 2", icerik: "Python’da aşağıdaki değişken tanımlamalarından hangisi geçerlidir?", cevaplar: [
                            
                            "int x = 10",
                            "float y = 3.14",
                            "x = 10",
                            "str x = \"Hello\""
                                        
                            ], gorsel: "" , cevapIndex: 2),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki Python kodu çalıştırıldığında ekrana ne yazdırılır?",cevaplar: [
                                        
                                        "10",
                                        "15",
                                        "105",
                                        "0"
                                        
                                    ] , gorsel: "level1Py1" , cevapIndex: 1 )
                ]
                
                
            case "Python Koşullu İfade (if-else)":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki Python kodunda, if bloğu ne zaman çalışır?" ,cevaplar: [
                    
                    "x 3’ten küçük olduğunda",
                    "x 3’e eşit olduğunda",
                    "x 3’ten büyük olduğunda",
                    "Kod hiç çalışmaz"
                    
                ] , gorsel: "level1Py2.1" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kod parçasında else bloğu ne zaman çalışır?", cevaplar: [
                            
                            "y 5’ten küçükse",
                            "Kod hiç çalışmaz",
                            "y 5’e eşitse",
                            "y 5’ten büyükse"
                                        
                            ], gorsel: "level1Py2.2" , cevapIndex: 3),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki Python kodu ile hangi çıktı elde edilir?",cevaplar: [
                                        
                                        "Eşit",
                                        "Farklı",
                                        "Hiçbir şey yazdırılmaz",
                                        "Hata verir"
                                        
                                    ] , gorsel: "level1Py2.3" , cevapIndex: 1 )
                ]
                
            case "Python For Döngüsü":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Python’da bir liste üzerinde for döngüsüyle dönmek için aşağıdakilerden hangisi doğrudur?" ,cevaplar: [
                    
                    "for i from list:",
                    "foreach(i in list):",
                    "for i in list:",
                    "for(list in i):"
                    
                ] , gorsel: "" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki Python kodu ne yazdırır?", cevaplar: [
                            
                            "1 2 3",
                            "0 1 2",
                            "0 1 2 3",
                            "1 2"
                                        
                            ], gorsel: "level1Py3.1" , cevapIndex: 1),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki kod ne zaman çalışmaz?",cevaplar: [
                                        
                                        "numbers listesi boşsa",
                                        "num değişkeni tanımlanmadıysa",
                                        "print fonksiyonu hatalıysa",
                                        "for yalnızca sözlüklerde kullanılırsa"
                                        
                                    ] , gorsel: "level1Py3.2" , cevapIndex: 0 )
                ]
                
                
                
            case "Python Fonksiyonlar":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Python’da bir fonksiyon tanımlamak için hangi anahtar kelime kullanılır?" ,cevaplar: [
                    
                    "function",
                    "define",
                    "def",
                    "func"
                    
                ] , gorsel: "" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki Python kodu çalıştırıldığında hangi çıktı elde edilir?", cevaplar: [
                            
                            "selamla",
                            "print",
                            "Merhaba!",
                            "Hata verir"
                                        
                            ], gorsel: "level1Py4.1" , cevapIndex: 2),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki Python kodu hangi işlevi yerine getirir?",cevaplar: [
                                        
                                        "İki sayıyı çarpar",
                                        "İki sayıyı toplar ve sonucu döndürür",
                                        "Sayıları yazdırır ama döndürmez",
                                        "Hata verir çünkü return kullanılamaz"
                                        
                                    ] , gorsel: "level1Py4.2" , cevapIndex: 1 )
                ]
                
                
                
            case "Python Listeler (Lists)":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Python’da liste elemanlarına hangi parantez türü ile erişilir?" ,cevaplar: [
                    
                    "{}",
                    "()",
                    "[]",
                    "<>"
                    
                ] , gorsel: "" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki Python ifadesi ile ne oluşturulur?", cevaplar: [
                            
                            "Sadece sayılardan oluşan dizi",
                            "Karışık veri tiplerinden oluşan liste",
                            "Sözlük",
                            "Değiştirilemez tuple"
                                        
                            ], gorsel: "level1Py5.1" , cevapIndex: 1),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki kod parçası ne yapar?",cevaplar: [
                                        
                                        "\"Armut\" silinir",
                                        "\"armut\" yerine \"çilek\" gelir",
                                        "Liste değiştirilemez, hata verir",
                                        "İlk eleman \"çilek\" olur"
                                        
                                    ] , gorsel: "level1Py5.2" , cevapIndex: 1 )
                ]
                
                
            case "Python Sözlük Yapısı":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Sözlüklerin listelerden en temel farkı nedir?" ,cevaplar: [
                    
                    "Değiştirilemez olmaları",
                    "Sadece sayı tutmaları",
                    "Anahtar (key) ile erişim sağlamaları",
                    "Sabit uzunlukta olmaları"
                    
                ] , gorsel: "" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki Python yapısı nedir?", cevaplar: [
                            
                            "Liste",
                            "Tuple",
                            "Set",
                            "Sözlük"
                                        
                            ], gorsel: "level1Py6.1" , cevapIndex: 3),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki kod hangi değeri verir?",cevaplar: [
                                        
                                        "\"Renkler\"",
                                        "\"0000FF\"",
                                        "\"mavi\"",
                                        "\"FF0000\""
                                        
                                    ] , gorsel: "level1Py6.2" , cevapIndex: 1 )
                ]
                
                
                
                
                
            case "Python Dosya Okuma":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Python’da bir dosyayı okuma (read) modu ile açmak için kullanılan kod hangisidir?" ,cevaplar: [
                    
                    "open(\"dosya.txt\", \"w\")",
                    "open(\"dosya.txt\", \"a\")",
                    "open(\"dosya.txt\", \"r\")",
                    "open(\"dosya.txt\")"
                    
                ] , gorsel: "" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kod ne yapar?", cevaplar: [
                            
                            "Dosyayı siler",
                            "Dosyanın içeriğini ekrana yazdırır",
                            "Dosyaya veri ekler",
                            "Dosyayı yedekler"
                                        
                            ], gorsel: "level1Py7" , cevapIndex: 1),
                                    Soru(baslik: "Uygulama 3", icerik: "Dosya okuma işlemi sonrası hangi fonksiyonla dosya kapatılmalıdır?",cevaplar: [
                                        
                                        "end()",
                                        "close()",
                                        "stop()",
                                        "exit()"
                                        
                                    ] , gorsel: "" , cevapIndex: 1 )
                ]
                
                
                
            case "Python Try-Except Yapısı":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Python’da hata oluşabilecek bir kodu yazarken hangi yapı kullanılır?" ,cevaplar: [
                    
                    "try-catch",
                    "try-except",
                    "if-else",
                    "do-while"
                    
                ] , gorsel: "" , cevapIndex: 1),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kod ne işe yarar?", cevaplar: [
                            
                            "Hata verir ve program durur",
                            "“Bir hata oluştu” yazdırır, program çalışmaya devam eder",
                            "Hiçbir şey yazmaz",
                            "10 / 0 sonucu ekrana yazdırılır"
                                        
                            ], gorsel: "level1Py8.1" , cevapIndex: 1),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki try-except yapısında hangi satırda hata oluşur?",cevaplar: [
                                        
                                        "print() satırı",
                                        "except: satırı",
                                        "sayi = int(\"abc\") satırı",
                                        "Hata oluşmaz"
                                        
                                    ] , gorsel: "level1Py8.2" , cevapIndex: 2 )
                ]
                
                
            
            //JavaScript Sorulari
            case "JS var, let ve const":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunda hangi değişkenin kapsamı en geniştir?" ,cevaplar: [
                    
                    "a (var ile tanımlanmış)",
                    "b (let ile tanımlanmış)",
                    "c (const ile tanımlanmış)",
                    "Hepsi eşittir"
                    
                ] , gorsel: "level1Js1.1" , cevapIndex: 0),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda const ile tanımlanan bir değişkenin değeri neden değiştirilmez?", cevaplar: [
                            
                            "const ile tanımlanan değişkenler sadece fonksiyon içinde değiştirilebilir",
                            "const ile tanımlanan değişkenler yalnızca bir kez atanabilir ve sonrasında değiştirilmesi yasaktır",
                            "const ile tanımlanan değişkenler sadece sayıları saklayabilir",
                            "const sadece sayılar için geçerlidir"
                                        
                            ], gorsel: "level1Js1.2" , cevapIndex: 1),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodunda let ile tanımlanan bir değişkenin değeri değiştirilirse ne olur?",cevaplar: [
                                        
                                        "x değişkeni yalnızca bir kez atanabilir, 30 yazdırılamaz",
                                        "x değişkeninin değeri değiştirilemez, hata verir",
                                        "x değişkeninin değeri değişir ve 30 yazdırılır",
                                        "Kod hata verir çünkü let yeniden atanamaz"
                                        
                                    ] , gorsel: "level1Js1.3" , cevapIndex: 0 )
                ]
                
                
            case "JS if-else Koşul Yapısı":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunun çıktısı ne olacaktır?" ,cevaplar: [
                    
                    "Küçük",
                    "Büyük",
                    "Hata verir",
                    "Hiçbir şey yazdırılmaz"
                    
                ] , gorsel: "level1Js2.1" , cevapIndex: 1),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda, else if yapısı neden kullanılmıştır?", cevaplar: [
                            
                            "Sadece bir koşulu kontrol etmek için",
                            "Bir koşul yanlışsa direkt sonuca ulaşmak için",
                            "Kodun düzenli olmasını sağlamak için",
                            "Birden fazla koşulu sırayla kontrol etmek için"
                                        
                            ], gorsel: "level1Js2.2" , cevapIndex: 3),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu çalıştırıldığında hangi çıktı alınır?",cevaplar: [
                                        
                                        "Büyük",
                                        "Küçük",
                                        "Tam on beş",
                                        "Hiçbir şey yazdırılmaz"
                                        
                                    ] , gorsel: "level1Js2.3" , cevapIndex: 2 )
                ]
                
                
                
                
            case "JS for Döngüsü":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodu çalıştırıldığında kaç kez “Merhaba!” yazdırılır?" ,cevaplar: [
                    
                    "1 kez",
                    "2 kez",
                    "3 kez",
                    "4 kez"
                    
                ] , gorsel: "level1Js3.1" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki JavaScript kodu çalıştırıldığında hangi sayılar ekrana yazdırılır?", cevaplar: [
                            
                            "1 2 3 4 5",
                            "2 4 6",
                            "1 3 5",
                            "2 3 4 5 6"
                                        
                            ], gorsel: "level1Js3.2" , cevapIndex: 1),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu ile 0 ile 5 arasındaki sayılara nasıl ulaşılır?",cevaplar: [
                                        
                                        "0 1 2 3 4 5 ",
                                        "1 2 3 4 5",
                                        "1 2 3 4 5 6",
                                        "0 1 2 3 4"
                                        
                                    ] , gorsel: "level1Js3.3" , cevapIndex: 0 )
                ]
                
                
                
            case "JS Fonksiyonlar":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunda hangi fonksiyon tanımlama yöntemi kullanılmıştır?" ,cevaplar: [
                    
                    "Arrow function",
                    "Geleneksel fonksiyon",
                    "Lambda fonksiyonu",
                    "Constructor fonksiyonu"
                    
                ] , gorsel: "level1Js4.1" , cevapIndex: 1),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki JavaScript kodunda topla fonksiyonu nasıl çalışır?", cevaplar: [
                            
                            "Fonksiyon sadece bir sayı döndürür",
                            "topla fonksiyonu hiçbir şey döndürmez",
                            "topla fonksiyonu yalnızca bir sayı alabilir",
                            "topla fonksiyonu iki sayıyı toplar ve sonucu döndürür"
                                        
                            ], gorsel: "level1Js4.2" , cevapIndex: 3),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu ne yapar?",cevaplar: [
                                        
                                        "selamla fonksiyonu “Merhaba, Ahmet!” mesajını ekrana yazdırır",
                                        "selamla fonksiyonu hata verir",
                                        "selamla fonksiyonu yalnızca sayılarla çalışabilir",
                                        "selamla fonksiyonu hiçbir şey yazdırmaz"
                                        
                                    ] , gorsel: "level1Js4.3" , cevapIndex: 0 )
                ]
                
                
                
            case "JS DOM Öğelerine Erişim":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunda hangi DOM öğesine erişilmeye çalışılmaktadır?" ,cevaplar: [
                    
                    "Sınıf adıyla tanımlanmış öğe",
                    "Etiket adıyla tanımlanmış öğe",
                    "ID ile tanımlanmış öğe",
                    "Stil özelliği ile tanımlanmış öğe"
                    
                ] , gorsel: "level1Js5.1" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki JavaScript kodu ile hangi DOM öğesinin içeriği değiştirilmektedir?", cevaplar: [
                            
                            "info sınıfına sahip ilk paragraf öğesinin içeriği değiştirilir",
                            "info sınıfına sahip tüm öğelerin içeriği değiştirilir",
                            "innerHTML yerine textContent kullanılamaz",
                            "Kod çalışmaz çünkü getElementsByClassName fonksiyonu doğru kullanılmıştır"
                                        
                            ], gorsel: "level1Js5.2" , cevapIndex: 0),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu çalıştırıldığında ne olur?",cevaplar: [
                                        
                                        "İlk <div> öğesinin arka plan rengi kırmızıya döner",
                                        "İlk <div> öğesinin arka plan rengi maviye döner",
                                        "Kod çalışmaz çünkü style özelliği yanlış kullanılmıştır",
                                        "Sayfadaki tüm <div> öğelerinin arka planı maviye döner"
                                        
                                    ] , gorsel: "level1Js5.3" , cevapIndex: 1 )
                ]
                
                
                
            case "JS Event Listener Eklemek":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunda hangi olay türü ile event listener eklenmiştir?" ,cevaplar: [
                    
                    "keydown",
                    "click",
                    "mouseover",
                    "keypress"
                    
                ] , gorsel: "level1Js6.1" , cevapIndex: 1),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki JavaScript kodu ne işe yarar?", cevaplar: [
                            
                            "myDiv öğesine tıklanıldığında arka plan rengi sarıya döner",
                            "myDiv öğesinin üzerine gelindiğinde arka plan rengi kırmızıya döner",
                            "myDiv öğesine tıklandığında bir fonksiyon çalıştırılır",
                            "myDiv öğesinin üzerine gelindiğinde arka plan rengi sarıya döner"
                                        
                            ], gorsel: "level1Js6.2" , cevapIndex: 3),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu ne yapar?",cevaplar: [
                                        
                                        "Butona tıklanıldığında bir alert mesajı gösterir",
                                        "Butona tıklanıldığında konsola \"Butona tıklandı!\" mesajını yazdırır",
                                        "Butona tıklanıldığında sayfa yeniden yüklenir",
                                        "Butona tıklanıldığında console.log fonksiyonu çalışmaz"
                                        
                                    ] , gorsel: "level1Js6.3" , cevapIndex: 1 )
                ]
                
                
                
            case "JS Fetch API":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunda hangi işlem yapılmaktadır?" ,cevaplar: [
                    
                    "Sunucudan veri gönderiliyor",
                    "Sunucudan veri alınıyor ve JSON formatında işleniyor",
                    "Veri sadece konsola yazdırılıyor",
                    "Sunucudan veri alındığında hata oluşur"
                    
                ] , gorsel: "level1Js7.1" , cevapIndex: 1),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki fetch() kodu ile hangi işlem yapılır?", cevaplar: [
                            
                            "Sunucuya JSON verisi gönderilir",
                            "Sunucudan veri alınır",
                            "Hata oluşursa işlem yapılmaz",
                            "GET isteği yapılır"
                                        
                            ], gorsel: "level1Js7.2" , cevapIndex: 0),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu ile hangi durum gerçekleşir?",cevaplar: [
                                        
                                        "Kod çalışır ancak veri alınmaz",
                                        "fetch() hata vermez",
                                        "Hata oluşursa işlem devam eder",
                                        "Sunucudan veri alınamazsa hata mesajı yazdırılır"
                                        
                                    ] , gorsel: "level1Js7.3" , cevapIndex: 3 )
                ]
                
                
                
            case "JS try-catch Yapısı":
                            
            return [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodu çalıştırıldığında ne olur?" ,cevaplar: [
                    
                    "Kod çalışmaz ve program durur",
                    "y tanımlı olduğu için sonuç yazdırılır",
                    "Hata oluşur ve “Hata yakalandı!” yazdırılır",
                    "catch bloğu çalışmaz çünkü hata yoktur"
                    
                ] , gorsel: "level1Js8.1" , cevapIndex: 2),
                           Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki kodda catch bloğunun görevi nedir?", cevaplar: [
                            
                            "JSON verisini düzeltmek",
                            "Hatalı JSON’u otomatik onarmak",
                            "JSON verisi doğruysa yazdırmak",
                            "Hata oluşursa kullanıcıyı bilgilendirmek"
                                        
                            ], gorsel: "level1Js8.2" , cevapIndex: 3),
                                    Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki kod parçası ne işe yarar?",cevaplar: [
                                        
                                        "catch bloğu her zaman çalışır",
                                        "try içinde hata olmadığı için catch çalışmaz",
                                        "10 / 0 hata olduğu için catch çalışır",
                                        "console.log çalışmaz"
                                        
                                    ] , gorsel: "level1Js8.3" , cevapIndex: 1 )
                ]
            
        default:
            return [Soru(baslik: "", icerik: "", cevaplar: [""], gorsel: "", cevapIndex: 0)]
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
                            Text(level1konuIcerik.baslik)
                                .font(.system(size: 26, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple, .clear]), startPoint: .leading, endPoint: .trailing))
                                .frame(height: 3)
                                .cornerRadius(1.5)
                                .padding(.bottom, 4)
                            
                            Text(level1konuIcerik.aciklama)
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
                        if !level1konuIcerik.gorseller.isEmpty {
                            Text("Ders Görselleri")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.top, 10)
                                .padding(.leading, 8)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(level1konuIcerik.gorseller, id: \.self) { detay in
                                    NavigationLink(destination: GorselView(gorselIsmi: detay)) {
                                        
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
                        isActiveLevel1Quiz = true
                        
                        let csharpTopics: [String] = [
                            "C# Değişkenler (Variables)",
                            "C# Temel Koşullu İfadeler",
                            "C# Döngüler -> For Döngüsü",
                            "C# Metotlar",
                            "C# Sınıflar (Classes)",
                            "C# List Koleksiyonu",
                            "C# Dosya Okuma İşlemleri",
                            "C# Hata Yönetimi Temel Kavramlar ve Kullanım"
                        ]

                        let pythonTopics: [String] = [
                            "Python Değişkenler(Variables)",
                            "Python Temel Koşullu İfade: if, else Kullanımı",
                            "Python For Döngüsü – Listeleme ve Tekrarlama",
                            "Python Fonksiyon Tanımlama ve Çağırma",
                            "Python Listeler (Lists)",
                            "Python Sözlük Yapısı ve Temel Kullanım",
                            "Python Dosya Okuma (File Reading)",
                            "Python Try-Except Yapısı (Temel Hata Yakalama)"
                        ]

                        let javascriptTopics: [String] = [
                            "JS var, let ve const ile Değişken Tanımlama",
                            "JS if-else Koşul Yapısı",
                            "JS for Döngüsü",
                            "JS Geleneksel Fonksiyon (Function)",
                            "JS DOM Öğelerine Erişim ve Seçme",
                            "JS Event Listener Eklemek",
                            "JS Fetch API: Temel Kullanım ve Özellikler",
                            "JS try-catch Yapısı"
                        ]

                        let topic = level1konuIcerik.baslik

                        if csharpTopics.contains(topic) {
                            guncelleCSharpIlerleme(level: 1, topic: topic)
                        } else if pythonTopics.contains(topic) {
                            guncellePythonIlerleme(level: 1, topic: topic)
                        } else if javascriptTopics.contains(topic) {
                            guncelleJavaIlerleme(level: 1, topic: topic)
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
                NavigationLink(destination: Level1QuizVC(levelQuizIcerik: self.levelQuizIcerik , level1KonuIcerik: self.level1konuIcerik).navigationBarBackButtonHidden(true), isActive: $isActiveLevel1Quiz) {
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
                }
            } catch {
                print("Hata: \(error.localizedDescription)")
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
                }
            } catch {
                print("Hata: \(error.localizedDescription)")
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
                }
            } catch {
                print("Hata: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    Level1VC(level1konuIcerik: LevelKonuIcerik( baslik: "C# Değişkenler (Variables)",
                                               aciklama: "Değişkenler, programda değer saklamak ve bu değerleri işlem yapmak için kullanılan bellek alanlarıdır. C# dilinde değişkenler belirli bir veri tipiyle tanımlanır. Değişkenin veri tipi, içinde hangi türdeki verilerin saklanabileceğini belirler. Her değişkenin bir adı vardır ve bu adla erişilebilir.",
                                               gorseller: ["degiskenGorselC1","degiskenGorselC2","degiskenGorselC3","degiskenGorselC4"]))
}
