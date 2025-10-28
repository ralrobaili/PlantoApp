//
//  Plant.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
import Foundation

struct Plant: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isChecked: Bool

    init(id: UUID = UUID(),
         name: String,
         room: String,
         light: String,
         wateringDays: String,
         waterAmount: String,
         isChecked: Bool = false) {
        self.id = id
        self.name = name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.isChecked = isChecked
    }
    
    init(name: String,
         room: String = "Bedroom",
         light: String = "Full Sun",
         wateringDays: String = "Every day",
         waterAmount: String = "20–50 ml",
         isChecked: Bool = false) {
        self.init(id: UUID(), name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount, isChecked: isChecked)
    }
}

