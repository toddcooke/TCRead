//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

import SwiftUI
import Alamofire

struct BookDetailView: View {
    var book: Book
    @State private var bookDownloaded: Data? = nil
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://www.gutenberg.org/cache/epub/\(book.textNum)/pg\(book.textNum).cover.medium.jpg"))
            Text(book.title).fontWeight(.heavy)
            Divider()

//            Text("Send to \(S.ereader)")//todo: add button to send to kindle

            Button("Send to \(S.ereader)") {
                downloadEbook(url: URL(string: "https://www.gutenberg.org/ebooks/11.epub3.images")!)
            }
            if bookDownloaded != nil {
                ShareLink(item: "", subject: Text("subject text")) {
                    Label("Learn Swift here", systemImage: "book")
                }
//                ShareLink(items: bookDownloaded!,subject: Text("subject text")) {
//                    Label("Learn Swift here", systemImage: "book")
//                }
            }
        }
    }

    func downloadEbook(url: URL) {
        AF.download(url)
                .downloadProgress { progress in
                    print("Download Progress: \(progress.fractionCompleted)")
                }
                .responseData { response in
                    if let data = response.value {
                        bookDownloaded = data
                    } else {
                        print("Response error:" + response.description)
                    }
                }
    }
}

//func sendEmail(to recipients: [String], subject: String, body: String) {
//    let service = NSSharingService(named: .composeEmail)!
//    service.recipients = recipients
//    service.subject = subject
//    service.perform(withItems: [body])
//}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book.exampleBook())
                .environmentObject(ModelData())
    }
}
