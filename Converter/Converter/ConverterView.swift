//
//  ContentView.swift
//  Converter
//
//  Created by Kuba Suder on 16/01/2022.
//

import SwiftUI

struct ConverterView<UnitType: ConvertingUnit>: View where UnitType.RawValue == String {
    @State private var sourceUnit: UnitType
    @State private var targetUnit: UnitType
    @State private var inputAmount: Double = 0.0
    @FocusState private var amountHasFocus: Bool

    let title: String

    var convertedAmount: Double {
        return targetUnit.convertFromBase(sourceUnit.convertToBase(inputAmount))
    }

    var allUnits: [UnitType] {
        return Array(UnitType.allCases)
    }

    init(title: String, initialSource: UnitType, initialTarget: UnitType) {
        self.title = title
        _sourceUnit = State(initialValue: initialSource)
        _targetUnit = State(initialValue: initialTarget)
    }

    var body: some View {
        Form {
            Section {
                Picker("From", selection: $sourceUnit) {
                    ForEach(allUnits, id: \.self) { unit in
                        Text("\(unit.rawValue)")
                    }
                }
                .pickerStyle(.automatic)

                Picker("To", selection: $targetUnit) {
                    ForEach(allUnits, id: \.self) { unit in
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
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
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

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConverterView(
                title: "Lengths",
                initialSource: WeightUnit.kilograms,
                initialTarget: WeightUnit.pounds
            )
        }
    }
}
