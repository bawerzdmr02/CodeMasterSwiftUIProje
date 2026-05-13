//
//  Level2QuizIcerik.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 2.05.2025.
//

import Foundation


struct Soru2: Identifiable {
    
    var id = UUID()
    
    var baslik: String
    var icerik: String
    
    var cevaplar : [String]
    
    var gorsel : String
    
    var cevapIndex : Int
    
    
}
