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

    var totalWithTip: Double {
        return checkAmount * Double(100 + tipPercentage) / 100
    }

    var amountPerPerson: Double {
        return totalWithTip / Double(numberOfPeople)
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

                Section("Tip:") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Total with tip:") {
                    Text(totalWithTip, format: .currency(code: currencyCode))
                }

                Section("Amount per person:") {
                    Text(amountPerPerson, format: .currency(code: currencyCode))
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
