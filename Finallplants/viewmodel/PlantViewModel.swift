//
//  PlantViewModel.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
import Foundation
import Combine

@MainActor
class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = [] {
        didSet {
            savePlants()
        }
    }
    
    private let saveKey = "SavedPlants"

    init() {
        loadPlants()
    }
    
    // MARK: - computed properties
    var checkedCount: Int {
        plants.filter { $0.isChecked }.count
    }
    
    var progress: Double {
        guard !plants.isEmpty else { return 0.0 }
        return Double(checkedCount) / Double(plants.count)
    }
    
    var statusText: String {
        if plants.isEmpty {
            return "Your plants are waiting for a sip 💦"
        } else if checkedCount == 0 {
            return "Your plants are waiting for a sip 💦"
        } else if checkedCount == 1 {
            return "1 of your plants feel loved today ✨"
        } else {
            return "\(checkedCount) of your plants feel loved today ✨"
        }
    }
    
    func toggleCheck(for plant: Plant) {
        if let index = plants.firstIndex(of: plant) {
            plants[index].isChecked.toggle()
        }
    }
    
    func deleteCheckedPlants() {
        plants.removeAll { $0.isChecked }
    }
    
    func addPlant(_ plant: Plant) {
        plants.append(plant)
    }
    
    func updatePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
        }
    }
    
    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }
    
    func clearAllPlants() {
        plants.removeAll()
    }
    
 
    // MARK: - Persistence
    private func savePlants() {
        if let encoded = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadPlants() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Plant].self, from: data) {
            self.plants = decoded
        }
    }
}

