//
//  EmailPromptView.swift
//  TCRead
//
//  Created by Todd Cooke on 1/4/23.
//

import Foundation
import SwiftUI

struct EmailPromptView: View {
    @Environment(\.dismiss) var dismiss
    @State var kindleEmailInput: String = ""
    @EnvironmentObject var modelData: ModelData
    var containerWidth: CGFloat = UIScreen.main.bounds.width - 32.0

    var body: some View {
        VStack {
            Form{
                HStack{
                    Text("What's your kindle email?")
                    Spacer()
                    Link("More info", destination: URL(
                                                    string: "https://www.amazon.com/sendtokindle/email#s2k-email-step-by-step")!)
                }
                TextField(
                    "Kindle email",
                    text: $kindleEmailInput
                )
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .onSubmit(onSubmitEmail)
                .alert(isPresented: $modelData.showErrorMessage) {
                    Alert(
                        title: Text("Invalid email"),
                        message: Text("Please use an email like this: alice@kindle.com")
                    )
                }
                HStack {
                    Button("Submit", action: onSubmitEmail)
                }
                 
            }

        }
        .padding()
        .navigationTitle("Update kindle email")
        .frame(width: 400)
    }

    func onSubmitEmail() {
        guard isValidEmail(kindleEmailInput) else {
            modelData.showErrorMessage.toggle()
            return
        }
        modelData.setKindleEmail(kindleEmailInput)
        dismiss()
    }

    struct EmailPromptView_Previews: PreviewProvider {
        static var previews: some View {
            EmailPromptView()
                .environmentObject(ModelData())
        }
    }
}
