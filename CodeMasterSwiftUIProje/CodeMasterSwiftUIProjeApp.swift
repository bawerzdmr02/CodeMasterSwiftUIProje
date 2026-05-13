//
//  CodeMasterSwiftUIProjeApp.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 28.04.2025.
//

import SwiftUI

@main
struct CodeMasterSwiftUIProjeApp: App {
    let persistenceController = PersistenceController.shared
    
    // Giriş yapılmış mı kontrol et
    @AppStorage("girisYapanKullanici") var girisYapanKullanici: String = ""

    var body: some Scene {
        WindowGroup {
            
            if girisYapanKullanici.isEmpty {
                ContentView() // Giriş ekranı
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                HomeVC() // Ana ekran
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
        }
    }
}
