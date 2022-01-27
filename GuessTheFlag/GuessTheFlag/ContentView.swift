//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kuba Suder on 19/01/2022.
//

import SwiftUI

struct FlagImage: View {
    let country: String

    var body: some View {
        Image(country)
            .shadow(radius: 8)
    }
}

struct FlagScreenBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.blue,
                Color(red: 0, green: 0, blue: 0.6)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct ContentView: View {
    let gameTurns = 10

    @State private var currentScore = 0
    @State private var turnsPlayed = 0

    @State private var showingScoreAlert = false
    @State private var scoreAlertTitle = ""
    @State private var scoreAlertMessage = ""

    @State private var showingEndAlert = false

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            FlagScreenBackground()

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
                            FlagImage(country: countries[i])
                        }
                    }
                }

                Text("Score: \(currentScore)")
                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 1.0))
                    .font(.callout)
            }
        }

        .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
            Button("Continue") {
                turnsPlayed += 1

                if turnsPlayed == gameTurns {
                    showingEndAlert = true
                } else {
                    pickAnotherFlag()
                }
            }
        } message: {
            Text(scoreAlertMessage)
        }

        .alert("Game Over", isPresented: $showingEndAlert) {
            Button("Start Again", action: resetGame)
        } message: {
            Text("Your final score is \(currentScore)/\(gameTurns).")
        }
    }

    func flagTapped(index: Int) {
        if index == correctAnswer {
            currentScore += 1
            scoreAlertTitle = "Correct!"
            scoreAlertMessage = "Your score is \(currentScore)."
        } else {
            scoreAlertTitle = "Wrong"
            scoreAlertMessage = "That's the flag of \(countries[index])."
        }

        showingScoreAlert = true
    }

    func pickAnotherFlag() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func resetGame() {
        currentScore = 0
        pickAnotherFlag()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
