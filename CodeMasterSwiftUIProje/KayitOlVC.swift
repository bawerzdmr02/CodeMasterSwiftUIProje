//
//  KayitOlVC.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI
import CoreData
import CryptoKit

struct KayitOlVC: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss // Giriş ekranına geri dönmek için
    
    @State var eMail = ""
    @State var password1 = ""
    @State var password2 = ""
    
    @State var kayıtBasarili = false
    @State var hataMesaji = ""
    
    var body: some View {
        ZStack {
            // Arka Plan Görseli (Klavye zıplamasına karşı korumalı)
            Image("arkaPlan")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            // Arka plan karartması
            Color.black.opacity(0.6)
                .ignoresSafeArea(.all)
            
            // TÜM İÇERİĞİ TUTAN ANA VSTACK
            VStack {
                Spacer()
                
                // Logo ve Başlık Kısmı
                VStack(spacing: 12) {
                    Image(systemName: "person.badge.plus") // Kayıt olma hissiyatı için ikon değişti
                        .font(.system(size: 55))
                        .foregroundColor(.yellow)
                        .shadow(color: .yellow.opacity(0.6), radius: 10, x: 0, y: 5)
                    
                    Text("Kayıt Ol")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                    
                    Text("CodeMaster'a Katıl!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 20) // 3 tane field olacağı için boşluğu biraz kıstım
                
                // KAYIT KARTI (Genişliği kilitlendi)
                VStack(spacing: 16) {
                    
                    // E-posta TextField
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
                    
                    // Şifre 1 SecureField
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white.opacity(0.7))
                        SecureField("Şifreniz", text: $password1)
                            .foregroundColor(.white)
                            .colorScheme(.dark)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    
                    // Şifre 2 SecureField
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white.opacity(0.7))
                        SecureField("Şifrenizi tekrar girin", text: $password2)
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
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                    }
                    
                    // Başarı Mesajı
                    if kayıtBasarili {
                        Text("Kayıt Başarılı! Giriş yapabilirsiniz.")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                    }
                    
                    // Kayıt Ol Butonu
                    Button(action: {
                        kayitOl()
                    }) {
                        Text("Kayıt Ol")
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
                .frame(maxWidth: 340) // KARTIN GENİŞLİĞİ GİRİŞ EKRANIYLA AYNI KİLİTLENDİ
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
                
                Spacer()
                
                // Alt Kısım - Giriş Yapa Dön Linki
                HStack(spacing: 8) {
                    Text("Zaten hesabınız var mı?")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Button(action: {
                        dismiss() // SwiftUI'ın otomatik geri dönme metodu
                    }) {
                        Text("Giriş Yap")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 35) // BOŞLUK TÜM SAYFAYA KİLİTLENDİ
        }
        .navigationBarBackButtonHidden(true) // Kendi geri dön butonumuzu yaptığımız için çirkin durmasın diye iOS'un default geri butonunu gizledik
    }
    
    // Şifreyi SHA256 hash'le
    private func hashPassword(password: String) -> String {
        let passwordData = Data(password.utf8)
        let hashed = SHA256.hash(data: passwordData)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }

    private func kayitOl() {
        // E-posta format kontrolü
        guard isValidEmail(eMail) else {
            hataMesaji = "Geçersiz e-posta adresi."
            return
        }

        // Boş alan kontrolü
        guard !eMail.isEmpty && !password1.isEmpty && !password2.isEmpty else {
            hataMesaji = "Lütfen tüm alanları doldurun."
            return
        }

        // Şifre eşleşmesi kontrolü
        guard password1 == password2 else {
            hataMesaji = "Şifreler eşleşmiyor."
            return
        }
        
        // Şifre minimum uzunluk kontrolü
        guard password1.count >= 6 else {
            hataMesaji = "Şifre en az 6 karakter olmalıdır."
            return
        }

        let hashedPassword = hashPassword(password: password1)

        // Yeni kullanıcı oluşturma
        let yeniKullanici = AppUser(context: viewContext)
        yeniKullanici.email = eMail
        yeniKullanici.password = hashedPassword

        // Diller için başlangıç ilerleme durumu
        yeniKullanici.pythonProgressLevel = 0
        yeniKullanici.pythonCurrentTopic = nil
        yeniKullanici.csharpProgressLevel = 0
        yeniKullanici.csharpCurrentTopic = nil
        yeniKullanici.javaProgressLevel = 0
        yeniKullanici.javaCurrentTopic = nil

        do {
            try viewContext.save()
            UserDefaults.standard.set(eMail, forKey: "girisYapanKullanici")
            hataMesaji = ""
            kayıtBasarili = true
            
            // Başarılı olunca alanları temizleyebiliriz
            eMail = ""
            password1 = ""
            password2 = ""
            
        } catch {
            hataMesaji = "Kayıt sırasında hata oluştu: \(error.localizedDescription)"
        }
    }
    
    // E-posta formatını kontrol eden fonksiyon
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

#Preview {
    KayitOlVC()
}   
