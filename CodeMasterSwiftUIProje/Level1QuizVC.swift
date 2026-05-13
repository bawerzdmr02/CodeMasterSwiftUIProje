//
//  Level1QuizVC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct Level1QuizVC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var ilerlemeDurumu = 0.25
    @State var dogruSayisi = 0
    @State var yanlisSayisi = 0
    @State var isActiveLevel1VC = false
    @State var isActiveLevel2VC = false
    @State var soruIndex = 0
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var gorselVC = false
    
    var levelQuizIcerik : [Soru] = []
    var level1KonuIcerik : LevelKonuIcerik
    
    var level2KonuIcerik : Level2KonuIcerik {
        switch level1KonuIcerik.baslik{
            
            //Csharp Konu Icerikleri
        case "C# Değişkenler (Variables)":
            return Level2KonuIcerik(baslik: "Veri Tipleri ve Tür Dönüşümleri",
                                   aciklama: "C# dilinde veri tipleri, değişkenlerin bellekte nasıl tutulacağını belirler. Değer tipleri (int, double, bool vs.) ve referans tipleri (string, object, array vs.) şeklinde iki ana gruba ayrılır. Farklı veri türleri arasında geçiş yapmak için tür dönüşümleri kullanılır. Bu dönüşümler açık (explicit) veya kapalı (implicit) olabilir. Ayrıca var, dynamic gibi esnek türler, yazımı kolaylaştırmak için kullanılabilir.",
                                   gorseller: ["level2VeriC1.1","level2VeriC1.2","level2VeriC1.3","level2VeriC1.4"])
            
        case "C# Temel Koşullu İfadeler":
            return Level2KonuIcerik(baslik: "Switch-case Kullanımı ve Ternary Operatör",
                                   aciklama: "C# dilinde switch-case yapısı, bir değişkenin alabileceği birçok değere göre farklı işlemler yapmak için kullanılır. Bu yapı, çoklu if-else bloklarına göre daha okunabilir ve düzenlidir. Ayrıca kısa koşul yazımı için kullanılan ternary operator (?:) yapısı sayesinde tek satırda koşul kontrolü yapılabilir.",
                                   gorseller: ["level2SwitchC1.1","level2SwitchC1.2","level2SwitchC1.3","level2SwitchC1.4"])
            
        case "C# Döngüler -> For Döngüsü":
            return Level2KonuIcerik(baslik: "while, do-while ve break/continue",
                                   aciklama: "while ve do-while döngüleri, belirli bir koşul sağlandığı sürece kodun tekrar çalışmasını sağlar. while döngüsü koşulu başta kontrol ederken, do-while döngüsü en az bir kez çalışır. break komutu döngüyü durdurmak için, continue ise döngüdeki bir turu atlayarak bir sonraki tura geçmek için kullanılır.",
                                   gorseller: ["level2WhileC1.1","level2WhileC1.2","level2WhileC1.3","level2WhileC1.4"])
            
        case "C# Metotlar":
            return Level2KonuIcerik(baslik: "Metotlar: Parametre, Return ve Overloading",
                                   aciklama: "Metotlar, belirli bir işlemi veya hesaplamayı gerçekleştiren, tekrar kullanılabilir kod bloklarıdır. Parametreler, metotlara dışarıdan veri gönderir. return komutu ile metotlardan sonuç döndürülebilir. Ayrıca, metot aşırı yüklenmesi (overloading) ile aynı isimle farklı parametreler alan metotlar tanımlanabilir.",
                                   gorseller: ["level2MetotC1.1","level2MetotC1.2","level2MetotC1.3","level2MetotC1.4"])
            
        case "C# Sınıflar (Classes)":
            return Level2KonuIcerik(baslik: "Nesne Yönelimli Programlama (OOP) Prensipleri",
                                   aciklama: "Nesne Yönelimli Programlama (OOP), yazılım geliştirmede nesneler ve sınıflar kullanarak verileri ve davranışları birleştiren bir yaklaşımdır. OOP’nin dört temel prensibi vardır: Kapsülleme (Encapsulation), Kalıtım (Inheritance), Polimorfizm (Polymorphism) ve Soyutlama (Abstraction). Bu prensipler yazılımı daha modüler, yeniden kullanılabilir ve yönetilebilir hale getirir.",
                                   gorseller: ["level2SinifC1.1","level2SinifC1.2","level2SinifC1.3","level2SinifC1.4"])
            
        case "C# List Koleksiyonu":
            return Level2KonuIcerik(baslik: "C# Dictionary Koleksiyonu",
                                   aciklama: "C# dilindeki Dictionary<TKey, TValue> koleksiyonu, anahtar-değer çiftlerinden oluşan bir yapıdır. Her bir anahtar, eşsizdir ve ona karşılık gelen bir değerle ilişkilendirilir. Dictionary koleksiyonu, veriye hızlı bir şekilde erişimi sağlar ve özellikle büyük veri kümeleriyle çalışırken verimli bir seçimdir.",
                                   gorseller: ["level2DictionaryC1.1","level2DictionaryC1.2","level2DictionaryC1.3","level2DictionaryC1.4"])
            
        case "C# Dosya Okuma İşlemleri":
            return Level2KonuIcerik(baslik: "C# Dosya Yazma İşlemleri",
                                   aciklama: "C# dilinde dosya yazma işlemi, verilerin bir dosyaya kaydedilmesini sağlar. System.IO namespace’inde bulunan sınıflar ile dosya işlemleri yapılır. Dosya yazarken mevcut dosyanın üzerine yazma ya da dosya yoksa yeni bir dosya oluşturma seçenekleri bulunur. En yaygın kullanılan sınıflar StreamWriter, FileStream ve File sınıflarıdır.",
                                   gorseller: ["level2DosyaC1.1","level2DosyaC1.2","level2DosyaC1.3","level2DosyaC1.4"])
            
        case "C# Hata Yönetimi":
            return Level2KonuIcerik(baslik: "C# Hata Yönetimi ve İstisna Sınıfları",
                                   aciklama: "C# dilinde hata yönetimi, programın beklenmedik durumlarla karşılaştığında düzgün bir şekilde çalışmaya devam etmesini sağlamak amacıyla kullanılır. C#’ta hatalar (istisnalar) try-catch yapısıyla yakalanır. try bloğu hata oluşması muhtemel kodu içerir, eğer hata meydana gelirse catch bloğu devreye girer. C# ayrıca özel istisnalar yaratmamızı sağlar, bu da hataların daha özelleştirilmiş bir şekilde ele alınmasını sağlar.",
                                   gorseller: ["level2HataC1.1","level2HataC1.2","level2HataC1.3","level2HataC1.4"])
            
            
            //Python Konu Icerikleri
        case "Python Değişkenler(Variables)":
            return Level2KonuIcerik(baslik: "Python Veri Tipleri (Data Types)",
                                   aciklama: "Python’da her veri bir veri tipine sahiptir. Sayılar, metinler, listeler, sözlükler gibi farklı veri türleri farklı veri tiplerine aittir. Python’da veri tipi belirtmek zorunlu değildir çünkü Python otomatik olarak veri tipini algılar. Örneğin bir sayı yazarsan int, bir tırnaklı değer yazarsan str olarak algılar. Level 1’de bu temele giriş yaptık, şimdi farklı veri tiplerini daha detaylı görelim.",
                                   gorseller: ["level2DegiskenPy1.1","level2DegiskenPy1.2","level2DegiskenPy1.3","level2DegiskenPy1.4"])
            
        case "Python Koşullu İfade (if-else)":
            return Level2KonuIcerik(baslik: "Birden Fazla Koşul – elif Kullanımı",
                                   aciklama: "Python’da if ile bir koşulu kontrol edebilirsin, ama birden fazla ihtimali kontrol etmek istiyorsan elif (else if) kullanılır. Her elif, farklı bir durumu kontrol eder. Eğer hiçbir koşul sağlanmazsa, en sonda else devreye girer. Kullanıcıdan giriş alırken veya birden fazla alternatif durumu karşılaştırırken çok işe yarar.",
                                   gorseller: ["level2IfPy1.1","level2IfPy1.2","level2IfPy1.3","level2IfPy1.4"])
            
        case "Python For Döngüsü":
            return Level2KonuIcerik(baslik: "while Döngüsü – Koşul Sağlandığı Sürece",
                                   aciklama: "while döngüsü, koşul True olduğu sürece sürekli çalışır. Eğer koşul asla False olmazsa sonsuz döngüye girer. Genellikle sayaç kullanılarak veya kullanıcıdan gelen veri ile döngüden çıkılır.",
                                   gorseller: ["level2WhilePy1.1","level2While1.2","level2WhilePy1.3","level2WhilePy1.4"])
            
        case "Python Fonksiyonlar":
            return Level2KonuIcerik(baslik: "Parametreli ve Geri Değer Döndüren Fonksiyonlar",
                                   aciklama: "Fonksiyonlar, belirli görevleri yerine getiren kod bloklarıdır. Parametre alabilirler ve return ifadesi ile bir değer döndürebilirler. Kod tekrarını azaltır, düzenli ve modüler yapılar sağlar.",
                                   gorseller: ["level2FuncPy1.1","level2FuncPy1.2","level2FuncPy1.3","level2FuncPy1.4"])
            
        case "Python Listeler (Lists)":
            return Level2KonuIcerik(baslik: "Diziler (Arrays) - NumPy ile",
                                   aciklama: "Python’da yerleşik array veri tipi yoktur ama bilimsel hesaplamalar için kullanılan NumPy kütüphanesi sayesinde yüksek performanslı diziler oluşturulabilir. Bu diziler matematiksel işlemler ve veri analizi için oldukça idealdir.",
                                   gorseller: ["level2DiziPy1.1","level2DiziPy1.2","level2DiziPy1.3","level2DiziPy1.4"])
            
        case "Python Sözlük Yapısı":
            return Level2KonuIcerik(baslik: "Sözlük İşlemleri ve Metotları",
                                   aciklama: "Python’da sözlükler (dictionaries), verileri anahtar-değer (key-value) çiftleriyle saklayan yapılardır. Her anahtar bir değere karşılık gelir. Sözlüklerde veri ekleme, güncelleme, silme gibi işlemleri yapabileceğimiz birçok yerleşik metot vardır.",
                                   gorseller: ["level2SozlukPy1.1","level2SozlukPy1.2","level2SozlukPy1.3","level2SozlukPy1.4"])
            
        case "Python Dosya Okuma":
            return Level2KonuIcerik(baslik: "Dosya Yazma (File Writing)",
                                   aciklama: "Python’da dosyalara veri yazmak için open() fonksiyonu \"w\" (yeni dosya oluşturur/varsa siler) ya da \"a\" (varsa sonuna ekler) modu ile kullanılır. Yazma işlemi write() fonksiyonu ile yapılır.",
                                   gorseller: ["level2DosyaPy1.1","level2DosyaPy1.2","level2DosyaPy1.3","level2DosyaPy1.4"])
            
        case "Python Try-Except Yapısı":
            return Level2KonuIcerik(baslik: "Try-Except-Else-Finally Blokları (İleri Seviye Hata Yönetimi)",
                                   aciklama: "Python’da hataları yönetmek için kullanılan try, except, else ve finally blokları, hatasız, kontrollü ve güvenli bir şekilde kod yazmamıza olanak tanır. try bloğu, hata oluşma ihtimali olan kodları barındırır. Eğer bu blokta bir hata oluşursa, except bloğu devreye girerek hatayı yakalar ve programın çökmesini engeller. Eğer try bloğu sorunsuz çalışırsa, else bloğu çalışır ve hata olmadan devam eden işlemleri yürütür. Son olarak, finally bloğu ise hata oluşsa da oluşmasa da her durumda çalışır ve genellikle dosya kapama, bağlantı sonlandırma gibi işlemler için kullanılır.",
                                   gorseller: ["level2TryPy1.1","level2TryPy1.2","level2TryPy1.3","level2TryPy1.4"])
            
            //JavaScript Konu Icerikleri
        case "JS var, let ve const":
            return Level2KonuIcerik(baslik: "Scope (Kapsam) ve Hoisting (Yukarı Taşınma)",
                                   aciklama: "JavaScript’te scope (kapsam), değişkenlerin hangi alanlarda erişilebilir olduğunu belirler. let ve const değişkenleri blok kapsamına (block scope) sahiptir, yani yalnızca tanımlandıkları süslü parantez {} içinde geçerlidir. var ise fonksiyon kapsamına (function scope) sahiptir ve sadece tanımlandığı fonksiyon içinde geçerlidir. Hoisting (yukarı taşınma), var ile tanımlanan değişkenlerin tanımlanmadıkları halde kullanılabilmesine sebep olur, fakat değeri undefined olur. let ve const ile hoisting yapılsa da, kullanmadan önce tanımlanmış olmalıdır.",
                                   gorseller: ["level2ScopeJs1.1","level2ScopeJs1.2","level2ScopeJs1.3","level2ScopeJs1.4"])
            
        case "JS if-else Koşul Yapısı":
            return Level2KonuIcerik(baslik: "switch-case Yapısı",
                                   aciklama: "switch-case yapısı, bir değişkenin değerini çoklu koşullarla karşılaştırmak için kullanılır. Eğer belirli bir durumda bir eşleşme bulunursa, o durumla ilgili kod bloğu çalıştırılır. case ifadeleri, kontrol edilen değişkenin olası değerlerini tanımlar. Eğer hiçbir case ile eşleşmezse, default bloğu devreye girer ve hata yönetimi sağlar. Bu yapı, birden fazla if-else kullanmaktan daha okunabilir ve verimlidir.",
                                   gorseller: ["level2SwitchJs1.1","level2SwitchJs1.2","level2SwitchJs1.3","level2SwitchJs1.4"])
            
        case "JS for Döngüsü":
            return Level2KonuIcerik(baslik: "while Döngüsü",
                                   aciklama: "while döngüsü, belirli bir koşul doğru olduğu sürece tekrar eden bir yapıdır. Koşul, döngü çalışmaya başlamadan önce kontrol edilir ve koşul sağlanıyorsa döngü içindeki kodlar sürekli çalıştırılır. Eğer koşul yanlış olursa döngü sona erer. Bu döngü, koşul sağlanmaya devam ettiği sürece çalışmaya devam eder. Eğer koşulda yanlış bir durum belirtilirse, sonsuz döngüye girilebilir.",
                                   gorseller: ["level2WhileJs1.1","level2WhileJs1.2","level2WhileJs1.3","level2WhileJs1.4"])
            
        case "JS Fonksiyonlar":
            return Level2KonuIcerik(baslik: "Arrow Functions (Ok Fonksiyonları) ile Kısa Fonksiyonlar",
                                   aciklama: "ES6 ile JavaScript’e eklenen Arrow Functions, daha kısa ve okunabilir fonksiyon yazımını sağlar. Geleneksel fonksiyonlara göre daha az kod ile işlevler oluşturulabilir. Ayrıca, Arrow Functions’lar this bağlamı (context) ile ilgili özel davranışlara sahiptir. Bu fonksiyon türü genellikle basit ve kısa fonksiyonlar için tercih edilir.",
                                   gorseller: ["level2FuncJs1.1","level2FuncJs1.2","level2FuncJs1.3","level2FuncJs1.4"])
            
        case "JS DOM Öğelerine Erişim":
            return Level2KonuIcerik(baslik: "DOM Öğeleri Üzerinde Değişiklik Yapma",
                                   aciklama: "JavaScript ile DOM (Document Object Model) öğeleri üzerinde değişiklikler yapmak oldukça yaygındır. DOM öğeleri, sayfanın HTML içeriğiyle doğrudan etkileşime girmenizi sağlar. Bu sayede, öğelerin içeriği (innerText), stilleri (style) veya sınıf listeleri (classList) dinamik olarak güncellenebilir. JavaScript kullanarak sayfa üzerinde etkileşimli değişiklikler yapmak, kullanıcı deneyimini geliştirir.",
                                   gorseller: ["level2DomJs1.1","level2DomJs1.2","level2DomJs1.3","level2DomJs1.4"])
            
        case "JS Event Listener Eklemek":
            return Level2KonuIcerik(baslik: "Gelişmiş Event Listener Kullanımı",
                                   aciklama: "JavaScript’te Event Listener kullanımı, kullanıcı etkileşimlerine tepki vermek için oldukça yaygındır. addEventListener() fonksiyonu, bir öğeye belirli bir olayı dinlemesini söyleyerek, bu olay gerçekleştiğinde bir fonksiyonun çalışmasını sağlar. Daha gelişmiş kullanımlarında, anonymous (anonim) fonksiyonlar, removeEventListener ile olayları kaldırma ve e.preventDefault() gibi metotlarla daha fazla kontrol sağlanabilir. Bu teknikler, özellikle kullanıcı etkileşimlerini daha detaylı yönetmek için kullanılır.",
                                   gorseller: ["level2EventJs1.1","level2EventJs1.2","level2EventJs1.3","level2EventJs1.4"])
            
        case "JS Fetch API":
            return Level2KonuIcerik(baslik: "Axios ile API’den Veri Çekme",
                                   aciklama: "Axios, JavaScript’te HTTP istekleri yapmak için kullanılan popüler bir kütüphanedir. Özellikle GET ve POST işlemleri için kullanılır. Axios, sunucudan veri almak (GET) veya sunucuya veri göndermek (POST) için çok kullanışlıdır. Ayrıca, Axios, veri alma ve hata yönetimi konusunda sağladığı kolaylıklarla öne çıkar. Axios, Promise tabanlıdır, bu da işlemlerin asenkron olarak gerçekleşmesini sağlar. Ayrıca, catch bloğu ile hata yönetimi yapılabilir.",
                                   gorseller: ["level2ApiJs1.1","level2ApiJs1.2","level2ApiJs1.3","level2ApiJs1.4"])
            
        case "JS try-catch Yapısı":
            return Level2KonuIcerik(baslik: "try-catch-finally Yapısında finally Kullanımı",
                                   aciklama: "JavaScript’te try-catch-finally yapısı, hataları yakalamak ve yönetmek için kullanılan temel yapıdır. Hata oluşan kodları try bloğuna yazarsınız ve eğer bir hata meydana gelirse, bu hata catch bloğunda yakalanır. Ancak, bazı işlemlerin her durumda çalışması gerektiğinde finally bloğu kullanılır. finally bloğu, hata oluşup oluşmadığına bakılmaksızın her zaman çalışır.Finally bloğu, genellikle dosya kapama, bağlantı sonlandırma, temizlik işlemleri gibi kaynak yönetimi yapmak için kullanılır. Bu, uygulamanın düzgün bir şekilde çalışmasını sağlamak için oldukça önemlidir.",
                                   gorseller: ["level2TryJs1.1","level2TryJs1.2","level2TryJs1.3","level2TryJs1.4"])
            
        default:
            return Level2KonuIcerik(baslik: "Hata!", aciklama: "Hata!", gorseller: ["","","",""])
        }
    }
    
    @State var secilenCevapIndex: Int? = nil
    @State var cevapDogruMu: Bool? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 1. ARKA PLAN
                Image("arkaPlan")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay(.ultraThinMaterial)
                
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                // ANA YAPI (Scrollable Alan)
                VStack(spacing: 0) {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            
                            // ÜST BÖLÜM: İlerleme Durumu
                            VStack(spacing: 12) {
                                Text("Quiz İlerlemesi")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack(spacing: 15) {
                                    GeometryReader { geometry in
                                        ZStack(alignment: .leading) {
                                            Capsule()
                                                .fill(Color.white.opacity(0.15))
                                                .frame(height: 12)
                                            
                                            Capsule()
                                                .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .leading, endPoint: .trailing))
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
                            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 1))
                            .padding(.horizontal, 24)
                            .padding(.top, 15)
                            
                            
                            // SORULAR DEVAM EDİYORSA
                            if soruIndex < levelQuizIcerik.count {
                                let aktifSoru = levelQuizIcerik[soruIndex]
                                
                                // SORU KARTI
                                VStack(spacing: 20) {
                                    Text(aktifSoru.baslik)
                                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                                        .foregroundColor(.yellow)
                                    
                                    Text(aktifSoru.icerik)
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .lineSpacing(6)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    // Görsel varsa göster
                                    if !aktifSoru.gorsel.isEmpty {
                                        Button(action: {
                                            gorselVC = true
                                        }) {
                                            Image(aktifSoru.gorsel)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: 180)
                                                .cornerRadius(12)
                                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.2), lineWidth: 1))
                                                .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
                                        }
                                    }
                                }
                                .padding(24)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                                .environment(\.colorScheme, .dark)
                                .cornerRadius(30)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white.opacity(0.15), lineWidth: 1))
                                .padding(.horizontal, 24)
                                
                                // GİZLİ GÖRSEL LİNKİ
                                NavigationLink(destination: GorselView(gorselIsmi: aktifSoru.gorsel), isActive: $gorselVC) { EmptyView() }
                                
                                // ŞIKLAR (CEVAPLAR)
                                VStack(spacing: 16) {
                                    ForEach(0..<aktifSoru.cevaplar.count, id: \.self) { index in
                                        Button(action: {
                                            // HATA ÇÖZÜMÜ 1: Sadece doğru cevabı bulana kadar tıklamaya izin ver.
                                            // Doğru bulunduktan sonra diğer şıklara tıklanmaz.
                                            if cevapDogruMu != true {
                                                secilenCevapIndex = index
                                                if index == aktifSoru.cevapIndex {
                                                    cevapDogruMu = true
                                                    dogruSayisi += 1
                                                } else {
                                                    cevapDogruMu = false
                                                    yanlisSayisi += 1
                                                    if yanlisSayisi >= 3 {
                                                        // 3 yanlıştan sonra geriye (Level1VC'ye) atar
                                                        isActiveLevel1VC = true
                                                    }
                                                }
                                            }
                                        }) {
                                            HStack {
                                                Text(aktifSoru.cevaplar[index])
                                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                                    .foregroundColor(.white)
                                                    .multilineTextAlignment(.leading)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Spacer()
                                                
                                                // Seçildiğinde Doğru/Yanlış ikonu çıkartır
                                                if secilenCevapIndex == index {
                                                    Image(systemName: cevapDogruMu == true ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                        .foregroundColor(.white)
                                                        .font(.title2)
                                                }
                                            }
                                            .padding(.vertical, 16)
                                            .padding(.horizontal, 20)
                                            .background(
                                                // Arka Plan Renk Mantığı
                                                Group {
                                                    if secilenCevapIndex == index {
                                                        if cevapDogruMu == true {
                                                            LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .leading, endPoint: .trailing)
                                                        } else {
                                                            LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing)
                                                        }
                                                    } else {
                                                        Color.white.opacity(0.1) // Seçilmemiş şıklar
                                                    }
                                                }
                                            )
                                            .cornerRadius(16)
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.2), lineWidth: 1))
                                        }
                                        // Doğru cevap bulunduğunda butonları devre dışı bırak
                                        .disabled(cevapDogruMu == true)
                                    }
                                }
                                .padding(.horizontal, 24)
                                
                            }
                            // EĞER SORULAR BİTTİYSE (TEBRİKLER EKRANI)
                            else {
                                VStack(spacing: 20) {
                                    Image(systemName: "trophy.fill")
                                        .font(.system(size: 70))
                                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom))
                                        .shadow(color: .yellow.opacity(0.5), radius: 10, x: 0, y: 5)
                                    
                                    Text("Tebrikler!")
                                        .font(.system(size: 32, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("Bu bölümdeki tüm soruları başarıyla tamamladın. Harika bir iş çıkardın!")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                        .lineSpacing(6)
                                }
                                .padding(30)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                                .environment(\.colorScheme, .dark)
                                .cornerRadius(30)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white.opacity(0.15), lineWidth: 1))
                                .padding(.horizontal, 24)
                                .padding(.top, 40)
                            }
                            
                            // Yüzen butonun arkasında kalmaması için boşluk
                            Spacer().frame(height: 120)
                        }
                    }
                }
                
                // HATA ÇÖZÜMÜ 2: Gölgeyi sadece bu küçük Vstack içine aldık, böylece tüm ekranı karartmıyor.
                // FLOATING ACTION BUTTON (Sadece DOĞRU cevap seçildiğinde veya test bittiğinde görünür)
                if cevapDogruMu == true || soruIndex >= levelQuizIcerik.count {
                    VStack {
                        Spacer() // Butonu en alta iter
                        
                        VStack {
                            Button(action: {
                                // Eğer test bittiyse Level 2'ye geçer
                                if soruIndex >= levelQuizIcerik.count - 1 && cevapDogruMu == true || soruIndex >= levelQuizIcerik.count {
                                    
                                    // BÜTÜN İŞ MANTIĞI VE KAYDETME BURADA KORUNDU
                                    isActiveLevel2VC = true
                                    let csharpTopics: [String] = ["C# Değişkenler (Variables)", "C# Temel Koşullu İfadeler", "C# Döngüler -> For Döngüsü", "C# Metotlar", "C# Sınıflar (Classes)", "C# List Koleksiyonu", "C# Dosya Okuma İşlemleri", "C# Hata Yönetimi Temel Kavramlar ve Kullanım"]
                                    let pythonTopics: [String] = ["Python Değişkenler(Variables)", "Python Temel Koşullu İfade: if, else Kullanımı", "Python For Döngüsü – Listeleme ve Tekrarlama", "Python Fonksiyon Tanımlama ve Çağırma", "Python Listeler (Lists)", "Python Sözlük Yapısı ve Temel Kullanım", "Python Dosya Okuma (File Reading)", "Python Try-Except Yapısı (Temel Hata Yakalama)"]
                                    let javascriptTopics: [String] = ["JS var, let ve const ile Değişken Tanımlama", "JS if-else Koşul Yapısı", "JS for Döngüsü", "JS Geleneksel Fonksiyon (Function)", "JS DOM Öğelerine Erişim ve Seçme", "JS Event Listener Eklemek", "JS Fetch API: Temel Kullanım ve Özellikler", "JS try-catch Yapısı"]

                                    let topic = level1KonuIcerik.baslik

                                    if csharpTopics.contains(topic) {
                                        guncelleCSharpIlerleme(level: 1, topic:  level1KonuIcerik.baslik.prefix(12) + " " + levelQuizIcerik[soruIndex == levelQuizIcerik.count ? soruIndex - 1 : soruIndex ].baslik)
                                    } else if pythonTopics.contains(topic) {
                                        guncellePythonIlerleme(level: 1, topic: level1KonuIcerik.baslik.prefix(12) + " " + levelQuizIcerik[soruIndex == levelQuizIcerik.count ? soruIndex - 1 : soruIndex ].baslik)
                                    } else if javascriptTopics.contains(topic) {
                                        guncelleJavaIlerleme(level: 1, topic: level1KonuIcerik.baslik.prefix(12) + " " + levelQuizIcerik[soruIndex == levelQuizIcerik.count ? soruIndex - 1 : soruIndex ].baslik)
                                    }
                                }
                                // Test bitmediyse sonraki soruya geçirir
                                else {
                                    ilerlemeDurumu += 0.125
                                    soruIndex += 1
                                    secilenCevapIndex = nil
                                    cevapDogruMu = nil
                                }
                            }) {
                                HStack(spacing: 12) {
                                    Text(soruIndex >= levelQuizIcerik.count - 1 && cevapDogruMu == true || soruIndex >= levelQuizIcerik.count ? "Sonraki Seviyeye Geç" : "Devam Et")
                                        .font(.system(size: 19, weight: .bold, design: .rounded))
                                    
                                    Image(systemName: "arrow.right.circle.fill")
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
                            .padding(.top, 40) // Gradient gölgenin yumuşak yayılması için üstten boşluk
                        }
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.85), .black]), startPoint: .top, endPoint: .bottom)
                        )
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                
                // GİZLİ NAVİGASYON LİNKLERİ (İŞ MANTIĞI KORUNDU)
                VStack {
                    NavigationLink(destination: Level2VC(level2KonuIcerik: self.level2KonuIcerik).navigationBarBackButtonHidden(true), isActive: $isActiveLevel2VC) { EmptyView() }
                    NavigationLink(destination: Level1VC(level1konuIcerik: self.level1KonuIcerik).navigationBarBackButtonHidden(true), isActive: $isActiveLevel1VC) { EmptyView() }
                }
            }
            .onAppear {
                if soruIndex < levelQuizIcerik.count {
                    secilenCevapIndex = nil
                    cevapDogruMu = nil
                }
            }
        }
    }
    
    // CoreData Fonksiyonları (EKSİKSİZ KORUNDU)
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
            } catch { print("Hata: \(error.localizedDescription)") }
        }
    }

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
            } catch { print("Hata: \(error.localizedDescription)") }
        }
    }

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
            } catch { print("Hata: \(error.localizedDescription)") }
        }
    }
}

#Preview {
    Level1QuizVC(ilerlemeDurumu: 0, soruIndex: 0,levelQuizIcerik: [Soru(baslik: "Uygulama 1" ,icerik: "Aşağıdaki JavaScript kodunda hangi işlem yapılmaktadır?" ,cevaplar: [
        
        "Sunucudan veri gönderiliyor",
        "Sunucudan veri alınıyor ve JSON formatında işleniyor",
        "Veri sadece konsola yazdırılıyor",
        "Sunucudan veri alındığında hata oluşur"
        
    ] , gorsel: "level1Js7.1" , cevapIndex: 1),//gorsel gelecek
               Soru(baslik: "Uygulama 2", icerik: "Aşağıdaki fetch() kodu ile hangi işlem yapılır?", cevaplar: [
                
                "Sunucuya JSON verisi gönderilir",
                "Sunucudan veri alınır",
                "Hata oluşursa işlem yapılmaz",
                "GET isteği yapılır"
                            
                ], gorsel: "level1Js7.2" , cevapIndex: 0),//gorsel gelecek
                        Soru(baslik: "Uygulama 3", icerik: "Aşağıdaki JavaScript kodu ile hangi durum gerçekleşir?",cevaplar: [
                            
                            "Kod çalışır ancak veri alınmaz",
                            "fetch() hata vermez",
                            "Hata oluşursa işlem devam eder",
                            "Sunucudan veri alınamazsa hata mesajı yazdırılır"
                            
                        ] , gorsel: "level1Js7.3" , cevapIndex: 3 )//gorsel gelecek
    ],level1KonuIcerik: LevelKonuIcerik(baslik: "", aciklama: "", gorseller: [""]))
}
