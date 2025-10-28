//
//  TodayReminderView2.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
import SwiftUI

struct TodayReminderView2: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var showAddPlant = false
    @State private var goToAllDone = false
    @State private var showEditPlant = false
    @State private var selectedPlant: Plant?
    @State private var showDeleteAlert = false
    @State private var confirmDeletePlant: Plant?
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                mainContent
                    .background(Color.black.ignoresSafeArea())
                
                addButton
            }
            .navigationDestination(isPresented: $goToAllDone) {
                AllDone().environmentObject(viewModel)
            }
            .navigationDestination(isPresented: $showEditPlant) {
                if let selectedPlant = selectedPlant {
                    EditPlant(viewModel: viewModel, plant: selectedPlant)
                        .environmentObject(viewModel)
                }
            }
            .sheet(isPresented: $showAddPlant) {
                SetReminderCompactView(viewModel: viewModel)
                    .environmentObject(viewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private extension TodayReminderView2 {
    var mainContent: some View {
        VStack(spacing: 20) {
            header
            statusSection
            progressBar
            plantList
            Spacer()
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("My Plants 🌱")
                .font(.system(size: 47, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 20)
            
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(height: 0.5)
                .padding(.vertical, 8)
        }
        .padding(.horizontal)
    }
    
    var statusSection: some View {
        Text(viewModel.statusText)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
            .padding(.top, 10)
    }
    
    var progressBar: some View {
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
    }
    
    var plantList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.plants) { plant in
                    plantRow(for: plant)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func plantRow(for plant: Plant) -> some View {
        HStack(alignment: .top, spacing: 12) {
            checkButton(for: plant)
            plantInfo(for: plant)
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
    
    func checkButton(for plant: Plant) -> some View {
        Button {
            viewModel.toggleCheck(for: plant)
            if viewModel.plants.allSatisfy({ $0.isChecked }) && !viewModel.plants.isEmpty {
                goToAllDone = true
            }
        } label: {
            Image(systemName: plant.isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(plant.isChecked ? Color("Colorsu") : .gray)
                .font(.system(size: 26))
        }
    }
    
    func plantInfo(for plant: Plant) -> some View {
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
                infoBadge(icon: "sun.max.fill", color: .yellow, text: plant.light)
                infoBadge(icon: "drop.fill", color: .blue, text: plant.waterAmount)
            }
        }
    }
    
    func infoBadge(icon: String, color: Color, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 15))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.25))
        .cornerRadius(8)
    }
    
    var addButton: some View {
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
    }
}

#Preview {
    TodayReminderView2()
        .environmentObject(PlantViewModel())
}

