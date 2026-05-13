//
//  HomeVC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData

struct HomeVC: View {
    
    @State private var secilenIndex = 0
    @State private var kullaniciEmail: String = ""

    // Konuların verileri dil bazlı
    var konuVerileri : [TopicModel] {
        switch secilenIndex {
        case 0:
            return [
                    TopicModel(baslik: "Değişkenler ve Veri Tipleri", aciklama: "C# diline giriş yapıyor, temel veri tiplerini ve değişken tanımlama kurallarını öğreniyoruz.", gorselIsmi: "girisGorselC1"),
                    TopicModel(baslik: "Koşullu İfadeler", aciklama: "Program akışını yönlendiren if-else ve switch-case yapılarıyla karar mekanizmalarını kuruyoruz.", gorselIsmi: "girisGorselC2"),
                    TopicModel(baslik: "Döngüler", aciklama: "Tekrar eden işlemleri for ve while döngüleri kullanarak nasıl optimize edeceğimizi inceliyoruz.", gorselIsmi: "girisGorselC3"),
                    TopicModel(baslik: "Metotlar ve Fonksiyonlar", aciklama: "Kod tekrarlarını azaltmak ve modüler bir yapı kurmak için metotların kullanımını öğreniyoruz.", gorselIsmi: "girisGorselC4"),
                    TopicModel(baslik: "Sınıflar ve Nesne Tabanlı", aciklama: "C#'ta sınıflar, nesneler ve kalıtım gibi Nesne Yönelimli Programlama (OOP) temellerini atıyoruz.", gorselIsmi: "girisGorselC5"),
                    TopicModel(baslik: "Koleksiyonlar", aciklama: "C#'ta koleksiyonlar ve listeler kullanarak birden fazla veriyi nasıl dinamik olarak yöneteceğimizi görüyoruz.", gorselIsmi: "girisGorselC6"),
                    TopicModel(baslik: "Dosya İşlemleri", aciklama: "C# ile dosya okuma, yazma ve sistem üzerinde veri saklama işlemlerini uygulamalı olarak öğreniyoruz.", gorselIsmi: "girisGorselC7"),
                    TopicModel(baslik: "Hata Yakalama", aciklama: "Try-catch yapıları ile program sırasındaki hataları yakalayarak uygulamanın çökmesini engelliyoruz.", gorselIsmi: "girisGorselC8")
            ]
        case 1:
            return [
                    TopicModel(baslik: "Değişkenler ve Veri Tipleri", aciklama: "Python’da değişkenlerin nasıl tanımlandığını ve dinamik veri tiplerinin sağladığı kolaylıkları öğreniyoruz.", gorselIsmi: "girisGorselPy1"),
                    TopicModel(baslik: "Koşullu İfadeler (if-else)", aciklama: "if-else yapısı ile algoritmalarımızda mantıksal sınamalar yapıyor ve programın akışını kontrol ediyoruz.", gorselIsmi: "girisGorselPy2"),
                    TopicModel(baslik: "Döngüler (for, while)", aciklama: "for ve while döngüleri ile koleksiyonlar üzerinde gezinme ve tekrarlı işlemleri yönetme yollarını keşfediyoruz.", gorselIsmi: "girisGorselPy3"),
                    TopicModel(baslik: "Fonksiyonlar", aciklama: "Fonksiyon tanımı ve parametre kullanımı ile Python'da temiz, okunabilir ve tekrar kullanılabilir kodlar yazıyoruz.", gorselIsmi: "girisGorselPy4"),
                    TopicModel(baslik: "Listeler ve Diziler", aciklama: "Listeler, diziler ve demetler (tuples) gibi veri yapılarıyla çoklu verileri nasıl işleyeceğimizi öğreniyoruz.", gorselIsmi: "girisGorselPy5"),
                    TopicModel(baslik: "Sözlükler (Dictionaries)", aciklama: "Dictionaries yani sözlük veri yapısıyla anahtar-değer (key-value) eşleşmelerini kullanarak verileri grupluyoruz.", gorselIsmi: "girisGorselPy6"),
                    TopicModel(baslik: "Dosya Okuma/Yazma", aciklama: "Python'da dosya oluşturma, okuma ve yazma işlemlerini adım adım uygulayarak veri kalıcılığını sağlıyoruz.", gorselIsmi: "girisGorselPy7"),
                    TopicModel(baslik: "Hata Yönetimi", aciklama: "Kodlama sırasında oluşabilecek istisnai durumları ve hataları try-except blokları ile güvenli bir şekilde yönetiyoruz.", gorselIsmi: "girisGorselPy8")
            ]
        case 2:
            return [
                    TopicModel(baslik: "Değişkenler (var, let, const)", aciklama: "JavaScript'te değişken tanımlarken var, let ve const kullanımları arasındaki farkları ve kapsam kurallarını öğreniyoruz.", gorselIsmi: "girisGorselJs1"),
                    TopicModel(baslik: "Koşullar (if-else, vs)", aciklama: "Programın akışını kontrol etmek için if-else ve switch-case yapılarını web tarayıcısı üzerinde test ediyoruz.", gorselIsmi: "girisGorselJs2"),
                    TopicModel(baslik: "Döngüler (for, while, map)", aciklama: "Belirli işlemleri tekrar etmek için geleneksel for ve modern map/filter gibi döngü fonksiyonlarını inceliyoruz.", gorselIsmi: "girisGorselJs3"),
                    TopicModel(baslik: "Fonksiyonlar", aciklama: "Function keyword'ü ile temel fonksiyonları ve modern ES6 ok (arrow) fonksiyonlarının pratik kullanımlarını keşfediyoruz.", gorselIsmi: "girisGorselJs4"),
                    TopicModel(baslik: "DOM Manipülasyonu", aciklama: "HTML'deki elemanlara JavaScript ile erişip içeriklerini, stillerini ve yapılarını dinamik olarak değiştirmeyi öğreniyoruz.", gorselIsmi: "girisGorselJs5"),
                    TopicModel(baslik: "Event Listener’lar", aciklama: "Kullanıcının tıklama, yazma veya kaydırma gibi etkileşimlerini yakalamak için Event Listener yapılarını entegre ediyoruz.", gorselIsmi: "girisGorselJs6"),
                    TopicModel(baslik: "API ile Veri Çekme", aciklama: "Gerçek dünyadan veri çekmek için Fetch API kullanarak uzak sunucularla asenkron iletişim kurmayı öğreniyoruz.", gorselIsmi: "girisGorselJs7"),
                    TopicModel(baslik: "Hata Yakalama (try-catch)", aciklama: "Kodumuzda oluşabilecek asenkron veya senkron hataları try-catch bloklarıyla yakalayıp kullanıcı deneyimini koruyoruz.", gorselIsmi: "girisGorselJs8")
            ]
        default:
            return []
        }
    }
    
    let diller = ["C#", "Python", "JavaScript"]
    
    @State var profilVC = false
    
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        NavigationStack {
            // ZStack KALDIRILDI! Ana içerik direkt VStack içinde.
            // Böylece iOS'un Güvenli Alanı (Safe Area) otomatik olarak korunacak.
            VStack(spacing: 0) {
                
                // HEADER KISMI
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("CodeMaster")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                            )
                        
                        Text("Hoş geldin, \(kullaniciEmail.components(separatedBy: "@").first ?? "Baver")")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        profilVC = true
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue.opacity(0.3)))
                            .shadow(color: .blue.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                    
                    NavigationLink(destination: ProfilVC(), isActive: $profilVC) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 15) // Saatten/Çentikten biraz daha uzaklaşması için nefes payı
                .padding(.bottom, 25)
                
                // DİL SEÇİCİ KISMI
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<diller.count, id: \.self) { index in
                            Button(action: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    secilenIndex = index
                                }
                            }) {
                                Text(diller[index])
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 24)
                                    .background(
                                        secilenIndex == index ?
                                        LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing) :
                                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                                    )
                                    .foregroundColor(secilenIndex == index ? .white : .gray)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(secilenIndex == index ? Color.clear : Color.white.opacity(0.2), lineWidth: 1)
                                    )
                                    .shadow(color: secilenIndex == index ? .purple.opacity(0.5) : .clear, radius: 10, x: 0, y: 5)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.bottom, 25)
                
                // KARTLAR KISMI
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(konuVerileri) { konu in
                            NavigationLink(destination: DetayVC(konuVerilerim : konu)) {
                                Image(konu.gorselIsmi)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                    )
                                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Sayfayı tam kaplamasını garanti altına aldık
            // Arka Planı ZStack yerine buraya ekledik. Bu sayede UI düzenini asla bozamaz!
            .background(
                ZStack {
                    Image("arkaPlan")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(.ultraThinMaterial)
                    
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                }
            )
            .onAppear {
                if let kayitliEmail = UserDefaults.standard.string(forKey: "girisYapanKullanici") {
                    kullaniciEmail = kayitliEmail
                }
            }
        }
    }
}

#Preview {
    HomeVC()
}
