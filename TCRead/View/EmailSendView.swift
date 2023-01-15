import SwiftUI
import MessageUI

// https://github.com/egesucu/SendMailApp
struct MailBookView: UIViewControllerRepresentable {

    var to: String
    var bookTitle: String
    var attachment: Data
//    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var modelData: ModelData

    typealias UIViewControllerType = MFMailComposeViewController

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {

    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail() {
            let view = MFMailComposeViewController()
            view.mailComposeDelegate = context.coordinator
            view.setToRecipients([to])
            view.setSubject(bookTitle)
            view.addAttachmentData(attachment, mimeType: "epub+zip", fileName: "\(bookTitle).epub")
            return view
        } else {
            return MFMailComposeViewController()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self,modelData)
    }


    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        var parent: MailBookView
        var modelData: ModelData

        init(_ parent: MailBookView,_ modelData:ModelData) {
            self.parent = parent
            self.modelData = modelData
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            switch result {
            case .sent:
                modelData.setBookEmailSent()
            default:
                print("book not sent: " + result.rawValue.description)
            }

            controller.dismiss(animated: true)
        }
    }
}
