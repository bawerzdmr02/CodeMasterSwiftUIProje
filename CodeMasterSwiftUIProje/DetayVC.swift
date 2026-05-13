//
//  DetayVC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct DetayVC: View {
    
    var konuVerilerim: TopicModel
    
    var levelkonuIcerik : LevelKonuIcerik{
        
        switch konuVerilerim.gorselIsmi{
            
            //Csharp konulari
        case "girisGorselC1":
            return LevelKonuIcerik(baslik: "C# Değişkenler (Variables)",
                            aciklama: "Değişkenler, programda değer saklamak ve bu değerleri işlem yapmak için kullanılan bellek alanlarıdır. C# dilinde değişkenler belirli bir veri tipiyle tanımlanır. Değişkenin veri tipi, içinde hangi türdeki verilerin saklanabileceğini belirler. Her değişkenin bir adı vardır ve bu adla erişilebilir.",
                            gorseller: ["degiskenGorselC1","degiskenGorselC2","degiskenGorselC3","degiskenGorselC4"])
        case "girisGorselC2":
            return LevelKonuIcerik(baslik: "C# Temel Koşullu İfadeler",
                            aciklama: "if yapısı, bir koşulun doğru olup olmadığını kontrol eder ve koşul doğruysa bir işlem gerçekleştirir. Eğer koşul yanlışsa, else bloğundaki işlemi yapar. else if yapısı ise birden fazla koşulu kontrol etmek için kullanılır. Eğer ilk if koşulu yanlışsa, else if bloğu çalışır ve kendi koşulunu kontrol eder.",
                            gorseller: ["level1ifC1.1","level1ifC1.2","level1ifC1.3","level1ifC1.4"])
        case "girisGorselC3":
            return LevelKonuIcerik(baslik: "C# Döngüler -> For Döngüsü",
                            aciklama: "for döngüsü, bir kod bloğunu belirli bir sayıda tekrar etmek için kullanılır. Genellikle bir sayaç (counter) kullanılarak, başlangıç, bitiş ve artış/değişim işlemleriyle döngü kontrol edilir.",
                            gorseller: ["level1ForC1.1","level1ForC1.2","level1ForC1.3","level1ForC1.4"])
        case "girisGorselC4":
            return LevelKonuIcerik(baslik: "C# Metotlar",
                            aciklama: "Metotlar, genellikle bir programda belirli bir işlemi veya hesaplamayı gerçekleştiren, kodun tekrarlanabilirliğini sağlayan yapılardır. C# dilinde bir metot, belirli bir işlevi yerine getiren kod bloğu olarak tanımlanır.",
                            gorseller: ["level1MetotC1.1","level1MetotC1.2","level1MetotC1.3","level1MetotC1.4"])
        case "girisGorselC5":
            return LevelKonuIcerik(baslik: "C# Sınıflar (Classes)",
                            aciklama: "C# dilinde sınıflar, nesne yönelimli programlamanın (OOP) temel yapı taşlarından biridir. Sınıf, bir tür veri yapısıdır ve bir nesnenin özelliklerini (değişkenler) ve davranışlarını (metotlar) tanımlar. Sınıflar, bir nesnenin temel şablonudur ve bu şablonlardan nesneler (objeler) türetilir.",
                            gorseller: ["level1SinifC1.1","level1SinifC1.2","level1SinifC1.3","level1SinifC1.4"])
        case "girisGorselC6":
            return LevelKonuIcerik(baslik: "C# List Koleksiyonu",
                            aciklama: "C# dilinde List, veri koleksiyonlarını saklamak ve yönetmek için kullanılan dinamik bir koleksiyon sınıfıdır. List<T>, sıralı ve değiştirilebilir (mutable) bir veri yapısıdır. Listeler, aynı türdeki öğeleri saklar ve öğe sayısı arttıkça dinamik olarak büyüyebilir.",
                            gorseller: ["level1ListC1.1","level1ListC1.2","level1ListC1.3","level1ListC1.4"])
        case "girisGorselC7":
            return LevelKonuIcerik(baslik: "C# Dosya Okuma İşlemleri",
                            aciklama: "C# dilinde dosya okuma işlemleri, dosya içeriğini bir dosyadan alarak programda kullanılabilir hale getirmek için gerçekleştirilir. Bu işlem için genellikle System.IO namespace'i içinde bulunan sınıflar kullanılır. En yaygın kullanılan sınıflar StreamReader, FileStream ve File sınıflarıdır.",
                            gorseller: ["level1DosyaC1.1","level1DosyaC1.2","level1DosyaC1.3","level1DosyaC1.4"])
        case "girisGorselC8":
            return LevelKonuIcerik(baslik: "C# Hata Yönetimi",
                            aciklama: "C# dilinde hata yönetimi, programın beklenmedik durumlarla karşılaştığında düzgün bir şekilde çalışmaya devam etmesini sağlamak amacıyla kullanılır. Hata yönetimi, genellikle (istisna) adı verilen hataları ele alır. Bu hata yönetim mekanizması, yazılımın kararlı ve kullanıcı dostu olmasını sağlamak için çok önemlidir.",
                            gorseller: ["level1TryC1.1","level1TryC1.2","level1TryC1.3","level1TryC1.4"])
            
            //Python Konulari
        case "girisGorselPy1":
            return LevelKonuIcerik(baslik: "Python Değişkenler(Variables)",
                                    aciklama: "Python'da değişkenler, verileri saklamak için kullanılır ve diğer programlama dillerinden farklı olarak veri tipi belirtmek zorunda değilsin. Değişkenler, doğrudan = operatörü ile tanımlanır.",
                                    gorseller: ["level1DegiskenPy1.1","level1DegiskenPy1.2","level1DegiskenPy1.3","level1DegiskenPy1.4"])
        case "girisGorselPy2":
            return LevelKonuIcerik(baslik: "Python Koşullu İfade (if-else)",
                                    aciklama: "if yapısı, belirli bir koşulun doğru (True) olup olmadığını kontrol eder. Eğer koşul doğruysa, ilgili kod bloğu çalışır. Koşul yanlış (False) ise else bloğundaki kod çalışır.",
                                    gorseller: ["level1IfPy1.1","level1IfPy1.2","level1IfPy1.3","level1IfPy1.4"])
        case "girisGorselPy3":
            return LevelKonuIcerik(baslik: "Python For Döngüsü",
                                    aciklama: "for döngüsü, bir koleksiyonun (liste, dize, sözlük vb.) elemanları üzerinde sırayla işlem yapmak için kullanılır. Belirli sayıda tekrar yapılması gerektiğinde idealdir.",
                                    gorseller: ["level1ForPy1.1","level1ForPy1.2","level1ForPy1.3","level1ForPy1.4"])
        case "girisGorselPy4":
            return LevelKonuIcerik(baslik: "Python Fonksiyonlar",
                                    aciklama: "Fonksiyon, belirli bir görevi yerine getirmek için yazılmış, tekrar kullanılabilir kod bloklarıdır. def anahtar kelimesiyle tanımlanır. Fonksiyonlar kodun düzenli, okunabilir ve modüler olmasını sağlar.",
                                    gorseller: ["level1FuncPy1.1","level1FuncPy1.2","level1FuncPy1.3","level1FuncPy1.4"])
        case "girisGorselPy5":
            return LevelKonuIcerik(baslik: "Python Listeler (Lists)",
                                    aciklama: "Listeler, birden fazla veriyi sıralı ve değiştirilebilir (mutable) şekilde tutan veri yapılarıdır. Köşeli parantez [] ile tanımlanır. İçinde farklı veri tipleri bulunabilir (int, str, float, vs.).",
                                    gorseller: ["level1ListePy1.1","level1ListePy1.2","level1ListePy1.3","level1ListePy1.4"])
        case "girisGorselPy6":
            return LevelKonuIcerik(baslik: "Python Sözlük Yapısı",
                                    aciklama: "Sözlükler, verileri tanımlamak ve erişmek için anahtar kullanır. Her anahtar bir değer ile eşleştirilir. Listelerden farklı olarak sıralı değildir.",
                                    gorseller: ["level1SozlukPy1.1","level1SozlukPy1.2","level1SozlukPy1.3","level1SozlukPy1.4"])
        case "girisGorselPy7":
            return LevelKonuIcerik(baslik: "Python Dosya Okuma",
                                    aciklama: "Dosya okuma işlemleri, bir .txt veya başka formatta dosyayı açarak içerisindeki verileri programımıza almamızı sağlar. Python'da bunun için en yaygın yöntem open() fonksiyonudur.",
                                    gorseller: ["level1DosyaPy1.1","level1DosyaPy1.2","level1DosyaPy1.3","level1DosyaPy1.4"])
        case "girisGorselPy8":
            return LevelKonuIcerik(baslik: "Python Try-Except Yapısı",
                                    aciklama: "Python'da bir kod bloğunda hata oluşması muhtemelse, bu bloğu try içine yazarız. Eğer hata oluşursa program durmaz, except bloğuna geçer ve orada tanımlanan alternatif işlemi yapar.",
                                    gorseller: ["level1TryPy1.1","level1TryPy1.2","level1TryPy1.3","level1TryPy1.4"])
            
            //JavaScript Konulari
        case "girisGorselJs1":
            return LevelKonuIcerik(baslik: "JS var, let ve const",
                                    aciklama: "JavaScript'te değişkenler var, let ve const anahtar kelimeleriyle tanımlanır. Aralarındaki farklar, kapsam (scope), yeniden tanımlanabilirlik ve değer atama zorunluluğudur.",
                                    gorseller: ["level1DegiskenJs1.1","level1DegiskenJs1.2","level1DegiskenJs1.3","level1DegiskenJs1.4"])
        case "girisGorselJs2":
            return LevelKonuIcerik(baslik: "JS if-else Koşul Yapısı",
                                    aciklama: "if-else yapısı, bir koşulun doğru (true) olup olmadığına göre farklı kod bloklarının çalışmasını sağlar. Gerekirse birden fazla durumu kontrol etmek için else if de kullanılabilir.",
                                    gorseller: ["level1ifJs1.1","level1ifJs1.2","level1ifJs1.3","level1ifJs1.4"])
        case "girisGorselJs3":
            return LevelKonuIcerik(baslik: "JS for Döngüsü",
                                    aciklama: "for döngüsü, belirli bir başlangıç değeri ile başlar, bir koşul doğrulandıktan sonra devam eder ve her döngüde bir adım ilerler. Genellikle belirli sayıda tekrarlanan işlemler için kullanılır.",
                                    gorseller: ["level1ForJs1.1","level1ForJs1.2","level1ForJs1.3","level1ForJs1.4"])
        case "girisGorselJs4":
            return LevelKonuIcerik(baslik: "JS Fonksiyonlar",
                                    aciklama: "Geleneksel fonksiyonlar, JavaScript'te en eski ve yaygın fonksiyon tanımlama yöntemidir. function anahtar kelimesi ile tanımlanır ve genellikle daha uzun fonksiyon yapılarında kullanılır.",
                                    gorseller: ["level1FuncJs1.1","level1FuncJs1.2","level1FuncJs1.3","level1FuncJs1.4"])
        case "girisGorselJs5":
            return LevelKonuIcerik(baslik: "JS DOM Öğelerine Erişim",
                                    aciklama: "DOM öğelerine erişmek, JavaScript'in en temel ve en önemli özelliklerinden biridir. JavaScript ile HTML elemanlarına, ID, sınıf (class), etiket (tag) gibi farklı yollarla erişilebilir ve bunlar üzerinde değişiklik yapılabilir.",
                                    gorseller: ["level1DomJs1.1","level1DomJs1.2","level1DomJs1.3","level1DomJs1.4"])
        case "girisGorselJs6":
            return LevelKonuIcerik(baslik: "JS Event Listener Eklemek",
                                    aciklama: "Event Listener, bir olay gerçekleştiğinde bir fonksiyonu tetiklemek için kullanılır. JavaScript'te bu, genellikle bir öğeye (element) belirli bir olay türü (click, mouseover, vb.) eklendiğinde yapılır.",
                                    gorseller: ["level1EventJs1.1","level1EventJs1.2","level1EventJs1.3","level1EventJs1.4"])
        case "girisGorselJs7":
            return LevelKonuIcerik(baslik: "JS Fetch API",
                                    aciklama: "Fetch API, JavaScript'te asenkron HTTP istekleri yapmak için kullanılan yerleşik bir fonksiyondur. fetch() sunucudan veri almak ve veri göndermek için kullanılır. Asenkron çalışır, böylece sayfa bloklanmaz.",
                                    gorseller: ["level1FetchJs1.1","level1FetchJs1.2","level1FetchJs1.3","level1FetchJs1.4"])
        case "girisGorselJs8":
            return LevelKonuIcerik(baslik: "JS try-catch Yapısı",
                                    aciklama: "JavaScript'te hata yönetimi, try-catch yapısı ile yapılır. try bloğu, hata oluşabilecek kodu içerir. Eğer try bloğunda bir hata meydana gelirse, program yürütmesi durmaz. Bunun yerine hata catch bloğuna yönlendirilir.",
                                    gorseller: ["level1TryJs1.1","level1TryJs1.2","level1TryJs1.3","level1TryJs1.4"])
            
        default:
            return LevelKonuIcerik(baslik: "", aciklama: "", gorseller: [""])
        }
        
    }
    
    @State var isActiveLevel1 = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 1. ARKA PLAN - Sabit ve taşmayan
                Image("arkaPlan")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay(.ultraThinMaterial)
                
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                // 2. KAYDIRILABİLİR ANA İÇERİK
                ScrollView(showsIndicators: false) {
                    
                    // TÜM İÇERİĞİ KORUYAN VSTACK - Padding'ler buraya kilitlendi, asla taşmaz!
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // KAHRAMAN GÖRSEL (Hero Image)
                        // scaledToFit kullandık ki görsel orantısızca büyüyüp ekranı patlatmasın
                        Image(konuVerilerim.gorselIsmi)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity) // İçinde bulunduğu Vstack'in genişliğine yayılır, dışarı taşmaz
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                            .padding(.top, 10)
                        
                        // İÇERİK KARTI (Glassmorphism olmadan, sade ve şık)
                        VStack(alignment: .leading, spacing: 16) {
                            
                            // Başlık (Kesinlikle taşmaz)
                            Text(konuVerilerim.baslik)
                                .font(.system(size: 28, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            // Ayırıcı Renkli Çizgi
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [.blue, .purple, .clear]), startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(height: 3)
                                .cornerRadius(1.5)
                                .padding(.bottom, 4)
                            
                            // Açıklama (Satır arası boşluklu, okuması kolay)
                            Text(konuVerilerim.aciklama)
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                                .lineSpacing(8)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            // Motivasyon Rozeti
                            HStack(spacing: 8) {
                                Image(systemName: "sparkles")
                                    .foregroundColor(.yellow)
                                Text("Öğrenmeye Hazır mısın?")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                            .padding(.top, 10)
                        }
                        
                        // Butonun arkasında yazı kalmaması için koruyucu boşluk
                        Spacer().frame(height: 120)
                    }
                    .padding(.horizontal, 24) // İŞTE KİLİT NOKTA: Bu padding hiçbir öğenin sağdan/soldan taşmasına izin vermez
                }
                
                // 3. HAVADA SÜZÜLEN (FLOATING) BUTON
                VStack {
                    Spacer()
                    
                    Button(action: {
                        isActiveLevel1 = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 22, weight: .bold))
                            
                            Text("Hadi Başla!")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
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
                    // Butonun arkasındaki yazılar okunabilsin diye hafif bir karartma gradienti
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .ignoresSafeArea(edges: .bottom)
                
                // Navigasyon
                NavigationLink(destination: Level1VC(level1konuIcerik: self.levelkonuIcerik).navigationBarBackButtonHidden(true), isActive: $isActiveLevel1) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    DetayVC(konuVerilerim: TopicModel(baslik: "C# Değişkenler (Variables)", aciklama: "Değişkenler, programda değer saklamak ve bu değerleri işlem yapmak için kullanılan bellek alanlarıdır. C# dilinde değişkenler belirli bir veri tipiyle tanımlanır. Değişkenin veri tipi, içinde hangi türdeki verilerin saklanabileceğini belirler. Her değişkenin bir adı vardır ve bu adla erişilebilir.", gorselIsmi: "girisGorselC1"))
}
