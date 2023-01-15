//
//  EmailPromptView.swift
//  TCRead
//
//  Created by Todd Cooke on 1/4/23.
//

import Foundation
import SwiftUI

struct EmailPromptView: View {
    @State var kindleEmailInput: String = ""
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        Text("What's your kindle email?").bold()
        HStack{
            Text("Not sure?")
            Link(destination: URL(string: "https://www.amazon.com/sendtokindle/email#s2k-email-step-by-step")!){
                Text("Start here")
            }
        }
        TextField(
            "Kindle email",
            text: $kindleEmailInput
        )
        .keyboardType(.emailAddress)
        .disableAutocorrection(true)
        .textFieldStyle(.roundedBorder)
        .padding()
        .autocapitalization(.none)
        .onSubmit(onSubmitEmail)
        .alert(isPresented: $modelData.showErrorMessage) {
            Alert(title: Text("Invalid email"), message: Text("Please use an email like this: alice@kindle.com"))
        }
        HStack {
            Button("Submit", action: onSubmitEmail)
        }
    }

    func onSubmitEmail() {
        guard isValidEmail(kindleEmailInput) else {
            modelData.showErrorMessage.toggle()
            return
        }
        modelData.setKindleEmail(kindleEmailInput)
    }
    
    struct EmailPromptView_Previews: PreviewProvider {
        static var previews: some View {
            EmailPromptView()
                .environmentObject(ModelData())

        }
    }

}
