//
//  ContentView.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData
import CryptoKit

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var eMail = ""
    @State var password = ""
    @State var kayitOl = false
    @State var girisYap = false
    @State var hataMesaji = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Arka Plan Görseli (Klavye açılınca zıplamaması için .all eklendi)
                Image("arkaPlan")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                // Arka plan karartması
                Color.black.opacity(0.6)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Logo ve Başlık Kısmı
                    VStack(spacing: 12) {
                        Image(systemName: "terminal.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                            .shadow(color: .yellow.opacity(0.6), radius: 10, x: 0, y: 5)
                        
                        Text("CodeMaster")
                            .font(.system(size: 42, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                        
                        Text("Tekrar Hoş Geldin!")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.bottom, 30)
                    
                    // GİRİŞ KARTI (Genişliği kilitlendi)
                    VStack(spacing: 20) {
                        
                        // Email TextField
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white.opacity(0.7))
                            TextField("E-posta adresiniz", text: $eMail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .foregroundColor(.white)
                                .colorScheme(.dark)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Şifre SecureField
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white.opacity(0.7))
                            SecureField("Şifreniz", text: $password)
                                .foregroundColor(.white)
                                .colorScheme(.dark)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        
                        // Hata Mesajı
                        if !hataMesaji.isEmpty {
                            Text(hataMesaji)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding(.top, 5)
                        }
                        
                        // Giriş Yap Butonu
                        Button(action: {
                            kullaniciKontrol()
                        }) {
                            Text("Giriş Yap")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(15)
                                .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        .padding(.top, 5)
                        
                    }
                    .padding(25)
                    // İŞTE SİHİRLİ KOD BURASI: Kartın maksimum genişliğini klavye açıkkenki boyutuna kilitliyoruz.
                    // Böylece klavye kapansa bile yanlara doğru ASLA uzayamayacak.
                    .frame(maxWidth: 340)
                    .background(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white.opacity(0.15), lineWidth: 1)
                    )
                    
                    Spacer()
                    
                    // Alt Kısım - Kayıt Ol Linki
                    HStack(spacing: 8) {
                        Text("Hesabınız yok mu?")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Button(action: {
                            self.kayitOl = true
                            print("Kayıt ol tıklandı")
                        }) {
                            Text("Kayıt Ol")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // Görünmez NavigationLink'ler
                    Group {
                        NavigationLink(destination: HomeVC().navigationBarBackButtonHidden(true), isActive: $girisYap) {
                            EmptyView()
                        }
                        NavigationLink(destination: KayitOlVC(), isActive: $kayitOl) {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
    
    private func hashPassword(password: String) -> String {
        let passwordData = Data(password.utf8)
        let hashed = SHA256.hash(data: passwordData)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
    
    private func kullaniciKontrol() {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        let hashedPassword = hashPassword(password: password)
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", eMail, hashedPassword)
        
        do {
            let kullanicilar = try viewContext.fetch(fetchRequest)
            
            if let kullanici = kullanicilar.first {
                print("Giriş başarılı!")
                hataMesaji = ""
                girisYap = true
                
                UserDefaults.standard.set(kullanici.email, forKey: "girisYapanKullanici")
                UserDefaults.standard.set(kullanici.pythonProgressLevel, forKey: "pythonProgressLevel")
                UserDefaults.standard.set(kullanici.pythonCurrentTopic, forKey: "pythonCurrentTopic")
                UserDefaults.standard.set(kullanici.csharpProgressLevel, forKey: "csharpProgressLevel")
                UserDefaults.standard.set(kullanici.csharpCurrentTopic, forKey: "csharpCurrentTopic")
                UserDefaults.standard.set(kullanici.javaProgressLevel, forKey: "javaProgressLevel")
                UserDefaults.standard.set(kullanici.javaCurrentTopic, forKey: "javaCurrentTopic")
                
            } else {
                hataMesaji = "Hatalı e-posta veya şifre."
            }
        } catch {
            hataMesaji = "Giriş sırasında hata oluştu."
        }
    }
}

#Preview {
    ContentView()
}
