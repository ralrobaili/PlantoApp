//
//  ContentView.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
//
//  ContentView.swift
//  Plants Raghad
//
//  Created by raghad alenezi on 05/05/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var showingSetReminder = false
    @State private var goToTodayReminder = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    Text("My Plants 🌱")
                        .font(.system(size: 47, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 413, height: 1)
                    
                    Image("plant")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280)
                    
                    Text("Start your plant journey!")
                        .font(.system(size: 27, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Now all your plants will be in one place and\nwe will help you take care of them :)🪴.")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    Button(action: {
                        showingSetReminder = true
                    }) {
                        Text("Set Plant Reminder")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 210 , height: 44)
                            .cornerRadius(25)
                            .padding(.horizontal, 50)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color(red: 0.3, green: 0.9, blue: 0.6))
                    .padding(.top, 100)
                    .sheet(isPresented: $showingSetReminder) {
                        // Pass the existing environment object to the ObservedObject initializer
                        SetReminderCompactView(viewModel: viewModel)
                    }
                    
                    Spacer()
                } // VStack
                .navigationDestination(isPresented: $goToTodayReminder) {
                    TodayReminderView()
                        .environmentObject(viewModel)
                }
            } // ZStack
        } // NavigationStack
    } // body
}

#Preview {
    ContentView()
        .environmentObject(PlantViewModel())
}

