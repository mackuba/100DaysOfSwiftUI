//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kuba Suder on 19/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()

            VStack(spacing: 50) {
                VStack(spacing: 5) {
                    Text("Tap the flag of:")
                    Text(countries[correctAnswer]).font(.title2)
                }
                .foregroundColor(.white)

                VStack(spacing: 30) {
                    ForEach(0...2, id: \.self) { i in
                        Button {
                            flagTapped(index: i)
                        } label: {
                            Image(countries[i])
                        }
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: pickAnotherFlag)
        } message: {
            Text("Your score is ???")
        }
    }

    func flagTapped(index: Int) {
        scoreTitle = (index == correctAnswer) ? "Correct!" : "Wrong"
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
