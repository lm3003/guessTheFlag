//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Luv Modi on 5/15/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var flags = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US", "Ukraine"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    @State private var answerValue = ""
    @State private var showAlert = false
    @State private var score = 0
    
    

    var body: some View {
        ZStack {
            Spacer()
            RadialGradient(stops: [
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of the country")
                            .foregroundStyle(.black)
                            .font(.subheadline.weight(.heavy))
                        Text(flags[correctAns])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            showResult(number)
                        } label: {
                            Image(flags[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                Spacer()
            }
            .padding()
            .alert(answerValue, isPresented: $showAlert) {
                Button ("Continue", action: askNextQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    
    func showResult(_ number:Int) {
        if number == correctAns {
            answerValue = "Correct"
            score += 1
        } else {
            answerValue = "Wrong"
        }
        showAlert = true
    }
    
    func askNextQuestion() {
        flags.shuffle()
        correctAns = Int.random(in: 0..<3)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
