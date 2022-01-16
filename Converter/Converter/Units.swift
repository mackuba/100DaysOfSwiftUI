//
//  Units.swift
//  Converter
//
//  Created by Kuba Suder on 16/01/2022.
//

import Foundation

protocol ConvertingUnit: CaseIterable, RawRepresentable, Hashable {
    func convertFromBase(_ value: Double) -> Double
    func convertToBase(_ value: Double) -> Double
}

protocol SimpleConvertingUnit: ConvertingUnit {
    var conversionFactor: Double { get }
}

extension SimpleConvertingUnit {
    func convertToBase(_ value: Double) -> Double {
        return value * conversionFactor
    }

    func convertFromBase(_ value: Double) -> Double {
        return value / conversionFactor
    }
}

enum LengthUnit: String, SimpleConvertingUnit {
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

enum TemperatureUnit: String, ConvertingUnit {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"

    func convertToBase(_ value: Double) -> Double {
        switch self {
            case .kelvin: return value
            case .celsius: return value + 273.15
            case .fahrenheit: return (value + 459.67) / 1.8
        }
    }

    func convertFromBase(_ value: Double) -> Double {
        switch self {
            case .kelvin: return value
            case .celsius: return value - 273.15
            case .fahrenheit: return value * 1.8 - 459.67
        }
    }
}

enum WeightUnit: String, SimpleConvertingUnit {
    case grams
    case kilograms
    case tons
    case ounces
    case pounds

    var conversionFactor: Double {
        switch self {
            case .grams: return 1
            case .kilograms: return 1000
            case .tons: return 1_000_000
            case .ounces: return 28.349523125
            case .pounds: return 453.59237
        }
    }
}
