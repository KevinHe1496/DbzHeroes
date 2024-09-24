//
//  LocalDataModel.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 23/9/24.
//

import Foundation

struct LocalDataModel {
    
    private enum Constants{
        static let valueKey = "Token"
    }
    private static let userDefaults = UserDefaults.standard
    
    static func get() -> String?{
        // Recupera el token guardado
        userDefaults.string(forKey: Constants.valueKey)
    }
    
    static func save(value: String){
        //esto es para guardar el valor
        userDefaults.setValue(value, forKey: Constants.valueKey)
    }
    
    static func delete(){
        // borrar el objeto
        userDefaults.removeObject(forKey: Constants.valueKey)
    }
}
