//
//  ListView.swift
//  Converter
//
//  Created by Kuba Suder on 16/01/2022.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {}

                ConversionLink(
                    title: "Length",
                    type: LengthUnit.self,
                    initialSource: .miles,
                    initialTarget: .kilometers
                )

                ConversionLink(
                    title: "Temperature",
                    type: TemperatureUnit.self,
                    initialSource: .fahrenheit,
                    initialTarget: .celsius
                )

                ConversionLink(
                    title: "Weight",
                    type: WeightUnit.self,
                    initialSource: .pounds,
                    initialTarget: .kilograms
                )
            }
            .navigationTitle("Choose conversion")
        }
    }
}

struct ConversionLink<UnitType: ConvertingUnit>: View
        where UnitType.RawValue == String {

    let title: String
    let type: UnitType.Type
    let initialSource: UnitType
    let initialTarget: UnitType

    var body: some View {
        NavigationLink(title) {
            ConverterView(
                title: title,
                initialSource: initialSource,
                initialTarget: initialTarget
            )
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
