import MessageUI
import SwiftUI

// https://github.com/egesucu/SendMailApp
struct MailBookView: UIViewControllerRepresentable {
    var to: String
    var book: Book
    var attachment: Data
    //    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var modelData: ModelData

    typealias UIViewControllerType = MFMailComposeViewController

    func updateUIViewController(_: MFMailComposeViewController, context _: Context) {}

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail() {
            let view = MFMailComposeViewController()
            view.mailComposeDelegate = context.coordinator
            view.setToRecipients([to])
            view.setSubject(book.title)
            view.addAttachmentData(attachment, mimeType: "epub+zip", fileName: "\(book.title).epub")
            return view
        } else {
            return MFMailComposeViewController()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, modelData, book)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailBookView
        var modelData: ModelData
        var book: Book

        init(_ parent: MailBookView, _ modelData: ModelData, _ book: Book) {
            self.parent = parent
            self.modelData = modelData
            self.book = book
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,
            error _: Error?
        ) {
            switch result {
            case .sent:
                modelData.booksSent.append(book)
            default:
                print("book not sent: " + result.rawValue.description)
            }

            controller.dismiss(animated: true)
        }
    }
}
