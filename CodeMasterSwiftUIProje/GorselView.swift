//
//  GorselView.swift
//  CodeMasterSwiftUIProje
//
//  Created by Bawer Özdemir on 3.05.2025.
//

import SwiftUI

struct GorselView: View {
    
    var gorselIsmi : String
    
    var body: some View {
        ZStack {
            // 1. ARKA PLAN
            Image("arkaPlan")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                .clipped()
                .ignoresSafeArea()
                .overlay(.ultraThinMaterial)
            
            // Görsele odaklanmayı artırmak için karanlık katmanı yoğunlaştırdık (0.9)
            Color.black.opacity(0.9)
                .ignoresSafeArea()

            // 2. YAKINLAŞTIRILABİLİR GÖRSEL VE BİLGİ
            VStack {
                Spacer()
                
                ZoomableImageView(imageName: gorselIsmi)
                
                Spacer()
                
                // Kullanıcıya şık bir ipucu
                HStack(spacing: 8) {
                    Image(systemName: "hand.draw.fill")
                    Text("Yakınlaştırmak için çift dokunun veya sürükleyin")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white.opacity(0.5))
                .padding(.bottom, 40)
            }
        }
    }
}

// PROFESYONEL ZOOM BİLEŞENİ
struct ZoomableImageView: View {
    let imageName: String
    
    // Zoom (Yakınlaştırma) Değişkenleri
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    // Pan (Kaydırma) Değişkenleri
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.8), radius: 20, x: 0, y: 10)
            .padding()
            // Resmin boyutunu ve konumunu bu değişkenler belirler
            .scaleEffect(scale)
            .offset(offset)
            
            // 1. ÇİFT TIKLAMA JESTİ (Double Tap)
            .onTapGesture(count: 2) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    if scale > 1.0 {
                        // Zaten zoom yapılmışsa orijinal hale dön
                        scale = 1.0
                        offset = .zero
                        lastOffset = .zero
                    } else {
                        // Değilse 2.5 kat yakınlaştır
                        scale = 2.5
                    }
                }
            }
            
            // 2. PARMAKLA KAYDIRMA JESTİ (Drag/Pan)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        // Sadece resim yakınlaştırılmışsa kaydırmaya izin ver
                        if scale > 1.0 {
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                    }
                    .onEnded { _ in
                        lastOffset = offset
                    }
            )
            
            // 3. İKİ PARMAKLA YAKINLAŞTIRMA JESTİ (Pinch/Magnification)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let delta = value / lastScale
                        lastScale = value
                        scale = scale * delta
                    }
                    .onEnded { _ in
                        lastScale = 1.0
                        
                        // Kullanıcı resmi çok küçültürse tatlı bir animasyonla 1.0 boyutuna geri zıplatır
                        if scale < 1.0 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                scale = 1.0
                                offset = .zero
                                lastOffset = .zero
                            }
                        }
                        // Çok büyütürse maksimum 4.0 kat ile sınırlandırır
                        else if scale > 4.0 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                scale = 4.0
                            }
                        }
                    }
            )
    }
}

#Preview {
    GorselView(gorselIsmi: "degiskenGorselC1")
}
