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
            RadialGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    Gradient.Stop.init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),

                ]),
                center: .top,
                 startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 30) {
                    VStack(spacing: 5) {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)

                        Text(countries[correctAnswer]).font(.title.weight(.semibold))
                    }

                    VStack(spacing: 20) {
                        ForEach(0...2, id: \.self) { i in
                            Button {
                                flagTapped(index: i)
                            } label: {
                                Image(countries[i])
                                    .clipShape(Capsule())
                                    .shadow(radius: 8)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: ???")
                    .foregroundColor(Color(red: 0.75, green: 0.75, blue: 1.0))
                    .font(.callout)
            }
            .padding()
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
