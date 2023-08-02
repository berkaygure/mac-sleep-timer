//
//  ContentView.swift
//  SleepTimer
//
//  Created by Berkay Güre on 1.08.2023.
//

import SwiftUI

enum PowerOptions: String, CaseIterable, Identifiable {
    case shutdown = "Shutdown"
    case sleep = "Sleep"
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    @State private var runAt = Date()
    @State private var runAfter = Calendar.current.startOfDay(for: Date())
    @State private var selectedOption = PowerOptions.shutdown
    @State private var isShowingAlert = false

    var body: some View {
        VStack {
            HStack {
                Text("Sleep Timer")
                    .font(.title)
            }.padding()
            
            HStack {
                Text("Run At:")
                Spacer()
                DatePicker("", selection: $runAt, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.automatic)
                    .labelsHidden()
                    .onChange(of: runAt) {
                        calculateRunAfter()
                    }
            }.padding(.horizontal)

            HStack {
                Text("Run After:")
                Spacer()
                DatePicker("", selection: $runAfter, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.automatic)
                    .labelsHidden()
                    .onChange(of: runAfter) {
                        calculateRunAt()
                    }
            }.padding(.horizontal)

            VStack(alignment: .leading) {
                Text("Behaviour:")
                Picker("Power Option", selection: $selectedOption) {
                    ForEach(PowerOptions.allCases) { option in
                        Text(option.rawValue)
                            .tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .labelsHidden()
            }.padding(.horizontal)

            HStack {
                Button("Set Timer") {
                    setTimer()
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                Button("Quit") {
                    isShowingAlert = true
                }
                .alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("Confirm"),
                        message: Text("Are you sure you want to quit the app?"),
                        primaryButton: .default(Text("Cancel")),
                        secondaryButton: .destructive(Text("Quit"), action: {
                            NSApplication.shared.terminate(nil)
                        })
                    )
                }
            }.padding(.vertical)
        }
        .frame(width: 300)
    }
    
    func calculateRunAfter() {
        let currentDate = Date()
        let timeIntervalInSeconds = currentDate.timeIntervalSince(runAt)
        let timeInMinutes = Int(ceil((timeIntervalInSeconds / 60.0) * -1.0))
        
        let zero = Calendar.current.startOfDay(for: Date())
        runAfter = Calendar.current.date(byAdding: .minute, value: timeInMinutes, to: zero) ?? runAt
    }
    
    func calculateRunAt() {
        let currentDate = Calendar.current.startOfDay(for: Date())
        let timeIntervalInSeconds = currentDate.timeIntervalSince(runAfter)
        let timeInMinutes = (timeIntervalInSeconds / 60.0) * -1.0

        runAt = Calendar.current.date(byAdding: .minute, value: Int(timeInMinutes), to: Date()) ?? runAfter
    }
    
    func setTimer() {
        // Implement your logic for setting the timer here
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

