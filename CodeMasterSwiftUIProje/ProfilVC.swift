//
//  ProfilVC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct ProfilVC: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var kullaniciEmail = ""
    @State private var ilerlemeSeviye = 1 // Başlangıç için 1. Seviye
    @State private var pythonSeviye = 0
    @State private var csharpSeviye = 0
    @State private var javaSeviye = 0
    
    @State private var pythonKonu = "Bilinmiyor"
    @State private var csharpKonu = "Bilinmiyor"
    @State private var javaKonu = "Bilinmiyor"
    
    @State private var hataMesaji = ""
    @State var girisYap = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // 1. PREMIUM ARKA PLAN (Glassmorphism)
                Image("arkaPlan")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay(.ultraThinMaterial)
                
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                // ANA YAPI
                VStack(spacing: 0) {
                    
                    // HEADER KISMI
                    HStack {
                        Text("Profilim")
                            .font(.system(size: 34, weight: .black, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                            )
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle.badge.checkmark")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.yellow)
                            .shadow(color: .yellow.opacity(0.4), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                    
                    // KAYDIRILABİLİR İÇERİK
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            
                            // HESAP BİLGİSİ KARTI
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Hesap Bilgileri")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.6))
                                    .padding(.bottom, 4)
                                
                                InfoItem(icon: "envelope.fill", iconColor: .blue, title: "Kayıtlı E-posta", value: kullaniciEmail)
                            }
                            .padding(24)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .cornerRadius(24)
                            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 1))
                            
                            // BAŞLIK: ÖĞRENME İSTATİSTİKLERİ
                            Text("Öğrenme İstatistikleri")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 10)
                                .padding(.bottom, -5)
                            
                            // C# KARTI
                            LanguageProgressCard(
                                title: "C#",
                                icon: "curlybraces.square.fill",
                                color1: .purple, color2: .pink,
                                konu: csharpKonu,
                                seviye: csharpSeviye
                            )
                            
                            // PYTHON KARTI
                            LanguageProgressCard(
                                title: "Python",
                                icon: "terminal.fill",
                                color1: .blue, color2: .cyan,
                                konu: pythonKonu,
                                seviye: pythonSeviye
                            )
                            
                            // JAVASCRIPT KARTI
                            LanguageProgressCard(
                                title: "JavaScript",
                                icon: "applescript.fill",
                                color1: .yellow, color2: .orange,
                                konu: javaKonu,
                                seviye: javaSeviye
                            )
                            
                        }
                        .padding(.horizontal, 24)
                        // HATA ÇÖZÜMÜ: Spacer yerine doğrudan VStack'in altına kocaman bir boşluk verdik ki JS kartı asla kaybolmasın.
                        .padding(.bottom, 150)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // 3. YÜZEN ÇIKIŞ YAP BUTONU (Quiz sayfasındaki kusursuz yapıyla aynı)
                VStack {
                    Spacer() // Butonu en alta iter
                    
                    VStack {
                        Button(action: {
                            girisYap = true
                            cikisYap()
                        }) {
                            HStack(spacing: 12) {
                                Text("Çıkış Yap")
                                    .font(.system(size: 19, weight: .bold, design: .rounded))
                                
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.red.opacity(0.9), .pink.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                            .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.3), lineWidth: 1))
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 30)
                        .padding(.top, 40) // Gradientin yumuşak geçişi için
                    }
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.85), .black]), startPoint: .top, endPoint: .bottom)
                    )
                }
                .ignoresSafeArea(edges: .bottom)
                
                // GİZLİ YÖNLENDİRME LİNKİ
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $girisYap) {
                    EmptyView()
                }
            }
            .onAppear {
                kullaniciBilgileriniGetir()
            }
        }
    }
    
    // Kullanıcı Bilgilerini Getir
    private func kullaniciBilgileriniGetir() {
        if let email = UserDefaults.standard.string(forKey: "girisYapanKullanici") {
            kullaniciEmail = email
            
            let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                let kullanicilar = try viewContext.fetch(fetchRequest)
                if let kullanici = kullanicilar.first {
                    pythonSeviye = Int(kullanici.pythonProgressLevel)
                    csharpSeviye = Int(kullanici.csharpProgressLevel)
                    javaSeviye = Int(kullanici.javaProgressLevel)
                    
                    pythonKonu = kullanici.pythonCurrentTopic ?? "Bilinmiyor"
                    csharpKonu = kullanici.csharpCurrentTopic ?? "Bilinmiyor"
                    javaKonu = kullanici.javaCurrentTopic ?? "Bilinmiyor"
                }
            } catch {
                hataMesaji = "Bilgiler getirilirken hata oluştu."
            }
        }
    }
    
    // Çıkış Yap
    private func cikisYap() {
        UserDefaults.standard.removeObject(forKey: "girisYapanKullanici")
    }
}

// ---------------------------------------------------------
// YARDIMCI GÖRSEL BİLEŞENLER (Temiz kod için ayrıldı)
// ---------------------------------------------------------

// Dil Kartı Özel Tasarımı
struct LanguageProgressCard: View {
    var title: String
    var icon: String
    var color1: Color
    var color2: Color
    var konu: String
    var seviye: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Başlık ve Seviye Badge'i
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Level \(seviye)")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(color2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(color2.opacity(0.15))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(color2.opacity(0.3), lineWidth: 1))
            }
            
            // Konu Bilgisi
            VStack(alignment: .leading, spacing: 4) {
                Text("Son Çalışılan Konu")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                
                Text(konu.isEmpty || konu == "Bilinmiyor" ? "Henüz başlanmadı" : konu)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // İlerleme Çubuğu (Max Level 10 olarak hesaplandı)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 8)
                    
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: geometry.size.width * CGFloat(min(Double(seviye) / 10.0, 1.0)), height: 8)
                        .shadow(color: color2.opacity(0.5), radius: 5, x: 0, y: 0)
                }
            }
            .frame(height: 8)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(24)
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.15), lineWidth: 1))
    }
}

// Bilgi Satırı Özel Tasarımı
struct InfoItem: View {
    var icon: String
    var iconColor: Color
    var title: String
    var value: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                
                Text(value.isEmpty ? "Bilinmiyor" : value)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            Spacer()
        }
    }
}

#Preview {
    ProfilVC()
} 
