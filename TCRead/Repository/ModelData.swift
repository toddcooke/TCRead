//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published private(set) var kindleEmail: String? = nil
    @Published var showErrorMessage = false

    func setKindleEmail(_ email: String) {
        print("setting email to: "+email)
        UserDefaults.standard.set(email, forKey: "kindleEmail")
        kindleEmail = email
    }

    init() {
        if let email = UserDefaults.standard.object(forKey: "kindleEmail") as? String? {
            kindleEmail = email
        }
    }
}
