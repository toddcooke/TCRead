//
//  UserDefaultsRepo.swift
//  TCRead
//
//  Created by Todd Cooke on 1/1/23.
//

import Foundation

struct UserDefaultsRepo{
    func read(key :String)->AnyObject?{
        return UserDefaults.standard.object(forKey: key) as AnyObject?
    }
    
    func write(key:String,val:AnyObject){
        let userDefaults = UserDefaults.standard
        userDefaults.set(val, forKey: key)
    }
}
