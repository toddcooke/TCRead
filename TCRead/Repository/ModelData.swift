//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published private(set) var kindleEmail: String? = nil
    @Published var showErrorMessage = false
    @Published private(set) var bookEmailSent = false
    @Published var showEmailModal = false

    func setKindleEmail(_ email: String) {
        print("setting email to: " + email)
        UserDefaults.standard.set(email, forKey: "kindleEmail")
        kindleEmail = email
    }

    func setBookEmailSent() {
        bookEmailSent = true
        var show = true
        if let showEmailModal = UserDefaults.standard.object(forKey: "showEmailModal") as? Bool? {
            if showEmailModal != nil {
                show = false
            }
        }
        showEmailModal = show
    }

    func dontShowEmailTooltip() {
        UserDefaults.standard.set(false, forKey: "showEmailModal")
        showEmailModal = false
    }

    init() {
        if let email = UserDefaults.standard.object(forKey: "kindleEmail") as? String? {
            kindleEmail = email
        }
    }
}
