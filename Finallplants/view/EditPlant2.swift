//
//  EditPlant2.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//

//
//  Eidtplants2.swift
//  Plants Raghad
//
//  Created by raghad alenezi on 05/05/1447 AH.
//
import SwiftUI

struct EditPlant2: View {
    @EnvironmentObject var viewModel: PlantViewModel
    var plant: Plant
    
    @Environment(\.dismiss) var dismiss
    @State private var goToTodayReminder = false
    
    @State private var plantName: String = ""
    @State private var selectedRoom: String = ""
    @State private var selectedLight: String = ""
    @State private var selectedWateringDays: String = ""
    @State private var selectedWaterAmount: String = ""
    @State private var showDeleteAlert = false
    
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
                        
                        Text("Edit Plant")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            var updatedPlant = plant
                            updatedPlant.name = plantName
                            updatedPlant.room = selectedRoom
                            updatedPlant.light = selectedLight
                            updatedPlant.wateringDays = selectedWateringDays
                            updatedPlant.waterAmount = selectedWaterAmount
                            
                            viewModel.updatePlant(updatedPlant)
                            goToTodayReminder = true
                        }) {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 42, height: 42)
                                .background(Color("Colorsu"))
                                .clipShape(Circle())
                        }
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
                                                    .foregroundColor(.gray.opacity(0.2))
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
                    
                    // Delete Button
                    Button(action: { showDeleteAlert = true }) {
                        Text("Delete Reminder")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Color"))
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                            .padding(.top, 30)
                    }
                    .alert("Delete Plant", isPresented: $showDeleteAlert) {
                        Button("Delete", role: .destructive) {
                            viewModel.deletePlant(plant)
                            goToTodayReminder = true
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Are you sure you want to delete this plant?")
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $goToTodayReminder) {
                TodayReminderView()
                    .environmentObject(viewModel)
            }
            .onAppear {
                plantName = plant.name
                selectedRoom = plant.room
                selectedLight = plant.light
                selectedWateringDays = plant.wateringDays
                selectedWaterAmount = plant.waterAmount
            }
        }
    }
    
    func optionRow(title: String, value: Binding<String>, icon: String, options: [String]) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundColor(.white)
            
            Spacer()
            
            Picker(selection: value, label:
                Text(value.wrappedValue.isEmpty ? "Select" : value.wrappedValue)
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
    NavigationStack {
        EditPlant2(plant: Plant(name: "Pothos"))
            .environmentObject(PlantViewModel())
    }
}

