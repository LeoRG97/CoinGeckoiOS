//
//  Foundation+Extensions.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

extension Result {
    
    // se extiende la clase Result para determinar si contiene algún error
    var failureValue: Error? {
        switch self {
        case .failure(let error):
            return error
        case .success:
            return nil
        }
    }
    
}


extension Double {
    
    /*
     En esta clase añadimos una función de extensión a la clase Double, para poder convertir el valor
     de los números de tipo double al formato que necesitamos en la aplicación
     */
    func toCurrency() -> Double? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    
        guard let formattedString = formatter.string(from: self as NSNumber),
              let formattedDouble = Double(formattedString) else {
            return nil
        }
        
        return formattedDouble
    }
    
}
