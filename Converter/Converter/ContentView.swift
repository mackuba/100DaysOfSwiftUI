//
//  ContentView.swift
//  Converter
//
//  Created by Kuba Suder on 16/01/2022.
//

import SwiftUI

enum LengthUnit: String, CaseIterable {
    case millimeters
    case centimeters
    case meters
    case kilometers
    case inches
    case feet
    case yards
    case miles

    var conversionFactor: Double {
        switch self {
            case .millimeters: return 0.001
            case .centimeters: return 0.01
            case .meters: return 1
            case .kilometers: return 1000
            case .inches: return 0.0254
            case .feet: return 0.3048
            case .yards: return 0.9144
            case .miles: return 1609.344
        }
    }

}

struct ContentView: View {
    @State private var inputUnit: LengthUnit = .kilometers
    @State private var targetUnit: LengthUnit = .miles
    @State private var inputAmount: Double = 0.0
    @FocusState private var amountHasFocus: Bool

    var convertedAmount: Double {
        return inputAmount * inputUnit.conversionFactor / targetUnit.conversionFactor
    }

    var body: some View {
        NavigationView {
            Form {
                Section {}

                Section {
                    Picker("From", selection: $inputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                    .pickerStyle(.automatic)

                    Picker("To", selection: $targetUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                    .pickerStyle(.automatic)
                }

                Section {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountHasFocus)

                    Text(convertedAmount, format: .number)
                }
            }
            .navigationTitle("Convert value")
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
        ContentView()
    }
}
