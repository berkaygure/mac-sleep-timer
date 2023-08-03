//
//  CircularProgressView.swift
//  SleepTimer
//
//  Created by Berkay Güre on 1.08.2023.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: CGFloat
    let size: CGFloat
    let text: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.gray)
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeInOut)
                .frame(width: size, height: size)
            
            Text(text)
                .font(.title2)
                .foregroundColor(.black)
                .bold()
                .frame(width: size, height: size)
        }
    }
}
