//
//  Register.swift
//  CaptureOfRebels
//
//  Created by Javier Sánchez Daza on 18/10/2018.
//  Copyright © 2018 Javier Sánchez Daza. All rights reserved.
//

import Foundation

protocol Visitor {
    var name: String {get}
    var planet: String {get}
}

struct Rebel: Visitor {
    let name: String
    let planet: String
    let dateTime: Date
    
    init(name: String, planet: String, time: Date) {
        self.name = name
        self.planet = planet
        self.dateTime = time
    }
}

protocol Register {
    func reg(_ entry: Visitor)-> String
}

final class PrepareRegister: Register {
    // Return a String with a info of the rebel
    func reg(_ entry: Visitor) -> String {
        return "rebel \(entry.name) on planet \(entry.planet) at \(Date())"
    }
}

final class PersistRebel {
    let nameList = "regList"
    let defaults = UserDefaults.standard

    // Check entry in User Defaults that is not null
    func isEmptyList(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // Persist a rebel in User Defaults
    func save(rebel: Visitor) {
        
        // Execute in multithread
        DispatchQueue.main.async {
            let prepare = PrepareRegister()
            let result = prepare.reg(rebel)
            
            var regList: [String] = []
            
            // If the key is already created, the array is recovered and a new register is added
            if (self.isEmptyList(key: self.nameList)) {
                if let arrayList = UserDefaults.standard.array(forKey: self.nameList) as? [String] {
                    regList = arrayList
                    regList.append(result)
                    print(regList)
                    self.defaults.set(regList, forKey: self.nameList)
                }
                // If the key does not exist yet, the array is added
            } else {
                regList.append(result)
                self.defaults.set(regList, forKey: self.nameList)
            }
        }
       
    }
    
}


    
    







