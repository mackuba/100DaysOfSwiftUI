//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kuba Suder on 19/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue,
                    Color(red: 0, green: 0, blue: 0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 50) {
                VStack(spacing: 5) {
                    Text("Tap the flag of:")
                    Text(countries[correctAnswer]).font(.title.weight(.semibold))
                }
                .foregroundColor(.white)

                VStack(spacing: 40) {
                    ForEach(0...2, id: \.self) { i in
                        Button {
                            flagTapped(index: i)
                        } label: {
                            Image(countries[i])
                                .shadow(radius: 8)
                        }
                    }
                }

                Text("Score: \(currentScore)")
                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 1.0))
                    .font(.callout)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: pickAnotherFlag)
        } message: {
            Text("Your score is \(currentScore).")
        }
    }

    func flagTapped(index: Int) {
        if index == correctAnswer {
            scoreTitle = "Correct!"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func pickAnotherFlag() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
