//
//  CoraShimmer.swift
//  CoreKit
//
//  Created by Erik Santos on 16/03/24.
//

import SwiftUI

public struct CoraShimmer: View {
    @State private var offsetX: CGFloat = -300

    
    public var body: some View {
        ZStack {
            Rectangle() // Retângulo como base
                .fill(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.2), .gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing)) // Gradiente de cinzas claros
                .frame(width: .infinity, height: .infinity) // Tamanho do retângulo
            
            Rectangle() // Outro retângulo para mascarar o gradiente
                .fill(Color.white) // Cor branca
                .frame(width: .infinity, height: .infinity) // Tamanho igual ao primeiro retângulo
                .mask(
                    Rectangle() // Retângulo mascarado
                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, .white, .clear]), startPoint: .leading, endPoint: .trailing)) // Gradiente transparente-branco-transparente
                        .frame(width: .infinity, height: .infinity) // Tamanho igual aos outros retângulos
                        .offset(x: offsetX) // Aplica o deslocamento horizontal
                )
        }
        .cornerRadius(5)
        .onAppear {
            withAnimation(Animation.linear(duration: 0.3).repeatForever()) { // Animação que repete infinitamente
                self.offsetX = 600 // Mudamos o valor do deslocamento para a direita, movendo o shimmer
            }
        }
    }
    
    public init() {}
}

#Preview {
    CoraShimmer()
        .padding()
}
