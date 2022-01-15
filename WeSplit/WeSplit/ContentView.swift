//
//  ContentView.swift
//  WeSplit
//
//  Created by Kuba Suder on 03/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountHasFocus

    let tipPercentages = [0, 5, 10, 15, 20]

    var amountPerPerson: Double {
        let total = checkAmount * (1 + Double(tipPercentage) / 100)
        return total / Double(numberOfPeople)
    }

    var currencyCode: String {
        return Locale.current.currencyCode ?? "USD"
    }

    var body: some View {
        NavigationView {
            Form {
                Section {}

                Section {
                    TextField(
                        "Check amount",
                        value: $checkAmount,
                        format: .currency(code: currencyCode)
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountHasFocus)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<99, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip:")
                }
                
                Section {
                    Text(amountPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("Amount per person:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountHasFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // hax for xcode bug: https://stackoverflow.com/a/70434772
            ZStack {
                ContentView()
                .environment(\.locale, Locale(identifier: "pl"))
            }
        }
    }
}
