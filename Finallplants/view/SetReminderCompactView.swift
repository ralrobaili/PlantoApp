//
//  SetReminderCompactView.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
//
//  SetReminderCompactView.swift
//  Plants Raghad
//
//  Created by raghad alenezi on 05/05/1447 AH.
//
import SwiftUI

struct SetReminderCompactView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PlantViewModel
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full Sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20–50 ml"
    @State private var goToTodayReminder = false
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20–50 ml", "50–100 ml", "100–200 ml", "200–300 ml"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Colorgray").ignoresSafeArea()
                
                VStack(spacing: 25) {
                    
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 42, height: 42)
                                .background(Color.black.opacity(0.25))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Text("Set Reminder")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            let newPlant = Plant(
                                name: plantName,
                                room: selectedRoom,
                                light: selectedLight,
                                wateringDays: selectedWateringDays,
                                waterAmount: selectedWaterAmount
                            )
                            viewModel.addPlant(newPlant)
                            goToTodayReminder = true
                        }) {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 42, height: 42)
                                .background(plantName.isEmpty ? Color.gray.opacity(0.4) : Color("Colorsu"))
                                .clipShape(Circle())
                        }
                        .disabled(plantName.isEmpty)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Inputs
                    VStack(spacing: 45) {
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 55)
                                .overlay(
                                    HStack {
                                        Text("Plant name")
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        ZStack(alignment: .leading) {
                                            if plantName.isEmpty {
                                                Text("Pothos")
                                                    .foregroundColor(.white.opacity(0.5))
                                            }
                                            TextField("", text: $plantName)
                                                .foregroundColor(.white.opacity(0.9))
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                )
                                .padding(.horizontal)
                        }
                        
                        VStack(spacing: 0) {
                            optionRow(title: "Room", value: $selectedRoom, icon: "location.fill", options: rooms)
                            
                            Divider()
                                .background(Color.white.opacity(0.3))
                                .padding(.horizontal, 8)
                            
                            optionRow(title: "Light", value: $selectedLight, icon: "sun.max.fill", options: lights)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            optionRow(title: "Watering Days", value: $selectedWateringDays, icon: "drop", options: wateringDays)
                            
                            Divider()
                                .background(Color.white.opacity(0.3))
                                .padding(.horizontal, 8)
                            
                            optionRow(title: "Water", value: $selectedWaterAmount, icon: "drop", options: waterAmounts)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .navigationDestination(isPresented: $goToTodayReminder) {
                    TodayReminderView()
                        .environmentObject(viewModel)
                }
            }
        }
    }
    
    func optionRow(title: String, value: Binding<String>, icon: String, options: [String]) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundColor(.white)
            
            Spacer()
            
            Picker(selection: value, label:
                Text(value.wrappedValue)
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 120, alignment: .trailing)
            ) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.menu)
            .accentColor(.white)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    SetReminderCompactView(viewModel: PlantViewModel())
}


