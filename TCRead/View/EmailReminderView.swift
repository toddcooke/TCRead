//
//  EmailReminderSheet.swift
//  TCRead
//
//  Created by Todd Cooke on 1/15/23.
//

import Foundation
import SwiftUI

struct EmailReminderView:View{
    @EnvironmentObject var modelData: ModelData

    var body : some View{
        VStack{
            Text(verbatim: "Book sent! Please check your inbox for an email from do-not-reply@amazon.com and click 'Verify Request'")
            HStack{
                Button("Don't show this again"){
                    modelData.showEmailModal = false
                    modelData.dontShowEmailTooltip()
                }.buttonStyle(.borderedProminent)
                
                Button("Done"){
                    modelData.showEmailModal = false
                }.buttonStyle(.bordered)
            }
        }
    }
}

struct EmailReminderView_Previews: PreviewProvider {
    static var previews: some View {
        EmailReminderView()
        .environmentObject(ModelData())
    }
}
