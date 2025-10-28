//
//  AllDone2.swift
//  Finallplants
//
//  Created by raghad alenezi on 06/05/1447 AH.
//
//
//  AllDone2.swift
//  Plants Raghad
//
//  Created by raghad alenezi on 05/05/1447 AH.
//
import SwiftUI

struct AllDone2: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var showAddPlant = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("My Plants 🌱")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 413, height: 1)
                
                Image("plantdone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280)
                
                Text("All Done! 🎉")
                    .font(.system(size: 27, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                Text("All reminders Completed")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Button(action: {
                    showAddPlant.toggle()
                }) {
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
                .sheet(isPresented: $showAddPlant) {
                    SetReminderCompactView(viewModel: viewModel)
                        .environmentObject(viewModel)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing, 40)
                .padding(.bottom, 25)
                Spacer()
            } // VStack
        } // ZStack
    } // body
}

#Preview {
    AllDone2()
        .environmentObject(PlantViewModel())
}

