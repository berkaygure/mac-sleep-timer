//
//  CountdownView.swift
//  SleepTimer
//
//  Created by Berkay Güre on 2.08.2023.
//

import SwiftUI

struct CountdownView: View {
    @Binding var time: TimeInterval;
    @Binding var total: Int;
    var stopTimer: () -> Void

    // Add the content for your countdown view here
    var body: some View {
        VStack {
            HStack {
                CircularProgressView(progress: calculatePercentage(), size: 80, text: formatTime())
                VStack {
                    Text("Your MAC will be sleep in " + formatTime() + " minutes.")
                        .font(.title2)
                    Button("Cancel") {
                        stopTimer()
                    }
                }.padding()
            }
            .padding()
            
        }
    }
    
    func calculatePercentage() -> Double {
        guard time >= 0 && total > 0 else {
            return 0.0
        }
        
        let percentage = (CGFloat(time) / CGFloat(total)) * 100.0
        return (100 - max(min(percentage, 100.0), 0.0)) / 100.0
    }
    
    private func formatTime() -> String {
       let formatter = DateComponentsFormatter()
       formatter.allowedUnits = [.hour, .minute]
       formatter.unitsStyle = .positional
       formatter.zeroFormattingBehavior = .pad
       return formatter.string(from: time) ?? "00:00"
    }
}
