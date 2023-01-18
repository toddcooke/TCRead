//
//  EnvVarUtil.swift
//  TCRead
//
//  Created by Todd Cooke on 1/18/23.
//

import Foundation

// https://stackoverflow.com/a/39560920/3569329

func getEnvVar(_ name: String) -> String? {
    guard let rawValue = getenv(name) else { return nil }
    return String(utf8String: rawValue)
}

func setEnvVar(name: String, value: String, overwrite: Bool = true) {
    setenv(name, value, overwrite ? 1 : 0)
}
