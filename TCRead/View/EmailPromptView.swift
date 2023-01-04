//
//  EmailPromptView.swift
//  TCRead
//
//  Created by Todd Cooke on 1/4/23.
//

import Foundation
import SwiftUI

struct EmailPromptView : View{
    @State var kindleEmailInput: String = ""
    @EnvironmentObject var modelData: ModelData

    var body : some View{
        Text("What is your kindle email?").bold()
        Text("Not sure? Start here: https://www.amazon.com/sendtokindle/email")
        TextField(
            "Kindle email",
            text: $kindleEmailInput
        ).padding()
        .onSubmit(onSubmitEmail)
        .alert(isPresented: $modelData.showErrorMessage) {
            Alert(title: Text("Invalid email"), message: Text("Please use an email like this: alice@kindle.com"))
        }
        HStack{
            Button("Submit", action: onSubmitEmail)
//            Button("Dismiss", action: { sendMail.toggle() })
        }
    }
    
    func onSubmitEmail() {
        guard isValidEmail(kindleEmailInput) else {
            modelData.showErrorMessage.toggle()
            return
        }
        modelData.setKindleEmail(kindleEmailInput)
//        sendMail.toggle()
    }
}
