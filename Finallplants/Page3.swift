//
//  Page3.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
// miss Raghoudh did this

import Combine
import SwiftUI

//  Today Reminder View
// miss Raghoudh did this

struct TodayReminderView: View {
    @StateObject private var viewModel = PlantViewModel()
    @State private var showAddPlant = false
    @State private var goToAllDone = false
    @State private var showEditPlant = false
    @State private var selectedPlant: Plant?
    @State private var showDeleteAlert = false
    @State private var confirmDeletePlant: Plant?
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Plants 🌱")
                            .font(.system(size: 47, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 1)
                        Rectangle()
                            .fill(Color.gray.opacity(0.4))
                            .frame(height: 0.5)
                            .padding(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Text(viewModel.statusText)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color("Colorsu"))
                                .frame(width: geometry.size.width * viewModel.progress, height: 6)
                                .animation(.easeInOut, value: viewModel.progress)
                        }
                    }
                    .frame(height: 6)
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.plants) { plant in
                                HStack(alignment: .top, spacing: 12) {
                                    Button(action: {
                                        viewModel.toggleCheck(for: plant)
                                        if viewModel.plants.allSatisfy({ $0.isChecked }) && !viewModel.plants.isEmpty {
                                            goToAllDone = true
                                        }
                                    }) {
                                        Image(systemName: plant.isChecked ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(plant.isChecked ? Color("Colorsu") : .gray)
                                            .font(.system(size: 26))
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack(spacing: 4) {
                                            Image(systemName: "location.fill")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 12))
                                            Text("in \(plant.room)")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13))
                                        }
                                        
                                        Text(plant.name)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24, weight: .semibold))
                                        
                                        HStack(spacing: 10) {
                                            HStack(spacing: 6) {
                                                Image(systemName: "sun.max.fill")
                                                    .foregroundColor(.yellow)
                                                Text(plant.light)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15))
                                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(Color.gray.opacity(0.25))
                                            .cornerRadius(8)
                                            
                                            HStack(spacing: 6) {
                                                Image(systemName: "drop.fill")
                                                    .foregroundColor(.blue)
                                                Text(plant.waterAmount)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15))
                                            }
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(Color.gray.opacity(0.25))
                                            .cornerRadius(8)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.black.opacity(0.2))
                                .cornerRadius(12)
                                .onTapGesture(count: 2) {
                                    selectedPlant = plant
                                    showEditPlant = true
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        confirmDeletePlant = plant
                                        showDeleteAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                            .alert("Delete Plant", isPresented: $showDeleteAlert) {
                                Button("Delete", role: .destructive) {
                                    if let plantToDelete = confirmDeletePlant {
                                        viewModel.deletePlant(plantToDelete)
                                    }
                                }
                                Button("Cancel", role: .cancel) {}
                            } message: {
                                Text("Are you sure you want to delete this plant?")
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .background(Color.black.ignoresSafeArea())
                
                .navigationDestination(isPresented: $goToAllDone) {
                    AllDone()
                }
                .navigationDestination(isPresented: $showEditPlant) {
                    if let selectedPlant = selectedPlant {
                        EditPlant(viewModel: viewModel, plant: selectedPlant)
                    }
                }
                
                Button(action: { showAddPlant.toggle() }) {
                    ZStack {
                        Circle()
                            .fill(Color("Colorsu").opacity(0.85))
                            .frame(width: 55, height: 55)
                            .shadow(color: Color("Colorsu").opacity(0.3), radius: 6, x: 0, y: 3)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                }
                .padding(.trailing, 25)
                .padding(.bottom, 35)
                .sheet(isPresented: $showAddPlant) {
                    SetReminderCompactView(viewModel: viewModel)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TodayReminderView()
}

