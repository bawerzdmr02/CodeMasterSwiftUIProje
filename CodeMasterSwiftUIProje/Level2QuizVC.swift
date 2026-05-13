//
//  Level2QuizVC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct Level2QuizVC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var ilerlemeDurumu = 0.625
    @State var dogruSayisi = 0
    @State var yanlisSayisi = 0
    @State var isActiveHomeVC = false
    @State var isActiveLevel2VC = false
    @State var soruIndex = 0
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var gorselVC = false
    
    var level2KonuIcerik : Level2KonuIcerik
    var level2QuizIcerik : [Soru2]
    
    @State var secilenCevapIndex: Int? = nil
    @State var cevapDogruMu: Bool? = nil
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // 1. ARKA PLAN - Premium Glassmorphism
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
                        if soruIndex < level2QuizIcerik.count {
                            let aktifSoru = level2QuizIcerik[soruIndex]
                            
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
                                        // Sadece doğru cevabı bulana kadar tıklamaya izin ver.
                                        if cevapDogruMu != true {
                                            secilenCevapIndex = index
                                            if index == aktifSoru.cevapIndex {
                                                cevapDogruMu = true
                                                dogruSayisi += 1
                                            } else {
                                                cevapDogruMu = false
                                                yanlisSayisi += 1
                                                if yanlisSayisi >= 3 {
                                                    // 3 yanlıştan sonra geriye (Level2VC'ye) atar
                                                    isActiveLevel2VC = true
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
                                            Group {
                                                if secilenCevapIndex == index {
                                                    if cevapDogruMu == true {
                                                        LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .leading, endPoint: .trailing)
                                                    } else {
                                                        LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing)
                                                    }
                                                } else {
                                                    Color.white.opacity(0.1)
                                                }
                                            }
                                        )
                                        .cornerRadius(16)
                                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.2), lineWidth: 1))
                                    }
                                    .disabled(cevapDogruMu == true)
                                }
                            }
                            .padding(.horizontal, 24)
                            
                            // DEVAM ET BUTONU (Sadece doğru cevap bulunduğunda şıkların altında belirir)
                            if cevapDogruMu == true {
                                Button(action: {
                                    ilerlemeDurumu += 0.125
                                    soruIndex += 1
                                    secilenCevapIndex = nil
                                    cevapDogruMu = nil
                                }) {
                                    HStack(spacing: 12) {
                                        Text("Devam Et")
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
                                .padding(.top, 10)
                            }
                            
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
                            
                            // ANA SAYFAYA DÖN BUTONU
                            Button(action: {
                                isActiveHomeVC = true
                                
                                // CORE DATA İLERLEME KAYDETME MANTIĞI
                                let csharpTopics: [String] = [
                                    "Veri Tipleri ve Tür Dönüşümleri", "Switch-case Kullanımı ve Ternary Operatör", "while, do-while ve break/continue", "Metotlar: Parametre, Return ve Overloading", "Nesne Yönelimli Programlama (OOP) Prensipleri", "C# Dictionary Koleksiyonu", "C# Dosya Yazma İşlemleri", "C# Hata Yönetimi ve İstisna Sınıfları"
                                ]

                                let pythonTopics: [String] = [
                                    "Python Veri Tipleri (Data Types)", "Birden Fazla Koşul – elif Kullanımı", "while Döngüsü – Koşul Sağlandığı Sürece", "Parametreli ve Geri Değer Döndüren Fonksiyonlar", "Diziler (Arrays) - NumPy ile", "Sözlük İşlemleri ve Metotları", "Dosya Yazma (File Writing)", "Try-Except-Else-Finally Blokları (İleri Seviye Hata Yönetimi)"
                                ]

                                let javascriptTopics: [String] = [
                                    "Scope (Kapsam) ve Hoisting (Yukarı Taşınma)", "switch-case Yapısı", "while Döngüsü", "Arrow Functions (Ok Fonksiyonları) ile Kısa Fonksiyonlar", "DOM Öğeleri Üzerinde Değişiklik Yapma", "Gelişmiş Event Listener Kullanımı", "Axios ile API’den Veri Çekme", "try-catch-finally Yapısında finally Kullanımı"
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
                                    Text("Ana Sayfaya Dön")
                                        .font(.system(size: 19, weight: .bold, design: .rounded))
                                    
                                    Image(systemName: "house.fill")
                                        .font(.system(size: 22, weight: .semibold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(16)
                                .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 5)
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 20)
                        }
                        
                        Spacer().frame(height: 50) // En alta rahat bir kaydırma boşluğu
                    }
                }
                
                // GİZLİ NAVİGASYON LİNKLERİ
                VStack {
                    NavigationLink(destination: HomeVC().navigationBarBackButtonHidden(true), isActive: $isActiveHomeVC) { EmptyView() }
                    NavigationLink(destination: Level2VC(level2KonuIcerik: self.level2KonuIcerik).navigationBarBackButtonHidden(true), isActive: $isActiveLevel2VC) { EmptyView() }
                }
            }
            .onAppear {
                if soruIndex < level2QuizIcerik.count {
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
                }
            } catch { print("Hata: \(error.localizedDescription)") }
        }
    }
}

#Preview {
    Level2QuizVC(level2KonuIcerik: Level2KonuIcerik(baslik: "Veri Tipleri ve Tür Dönüşümleri",
                                                      aciklama: "C# dilinde veri tipleri, değişkenlerin bellekte nasıl tutulacağını belirler. Değer tipleri (int, double, bool vs.) ve referans tipleri (string, object, array vs.) şeklinde iki ana gruba ayrılır. Farklı veri türleri arasında geçiş yapmak için tür dönüşümleri kullanılır. Bu dönüşümler açık (explicit) veya kapalı (implicit) olabilir. Ayrıca var, dynamic gibi esnek türler, yazımı kolaylaştırmak için kullanılabilir.",
                                                      gorseller: ["level2VeriC1.1","level2VeriC1.2","level2VeriC1.3","level2VeriC1.4"])
                 , level2QuizIcerik: [Soru2(baslik: "Uygulama 1", icerik: "Asagidaki kodun çıktısı nedir?", cevaplar: [
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
                ])
}
