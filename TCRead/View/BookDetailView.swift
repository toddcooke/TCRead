//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

import SwiftUI
import Alamofire

struct BookDetailView: View {
    var book: Book
    @State private var bookData: Data? = nil
    @State private var sendMail: Bool = false

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://www.gutenberg.org/cache/epub/\(book.textNum)/pg\(book.textNum).cover.medium.jpg"))
            Text(book.title).fontWeight(.heavy)
            Text(book.authors).fontWeight(.heavy)
            Divider()
            Button("Send to \(S.ereader)") {
                if bookData == nil {
                    downloadEbook(url: URL(string: "https://www.gutenberg.org/ebooks/\(book.textNum).epub3.images")!)
                }else{
                    sendMail = true
                }
            }.sheet(isPresented: $sendMail){
                MailView(content: "content", to: "toddcookevt@gmail.com", subject: "subject")
                    .onDisappear{
                        sendMail = false
                    }
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
                        bookData = data
                        sendMail = true
                    } else {
                        print("Response error:" + response.description)
                    }
                }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book.exampleBook())
                .environmentObject(ModelData().withExampleEreader())
    }
}
