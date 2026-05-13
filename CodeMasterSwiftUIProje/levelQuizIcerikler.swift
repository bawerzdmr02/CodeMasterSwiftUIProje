//
//  levelQuizIcerikler.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 30.04.2025.
//

import Foundation

struct Soru: Identifiable {
    
    var id = UUID()
    
    var baslik: String
    var icerik: String
    
    var cevaplar : [String]
    
    var gorsel : String
    
    var cevapIndex : Int
    
    
}
