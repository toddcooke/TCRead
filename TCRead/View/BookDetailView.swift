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
            AsyncImage(url: URL(string: "https://www.gutenberg.org/cache/epub/\(book.textNum)/pg\(book.textNum).cover.medium.jpg")) { image in
                image.aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }.padding()
            Text(book.title).bold()
            Text(book.authors)
            if let bookData {
                Button("Send to \(S.ereader)") {
                    sendMail.toggle()
                }.padding()
                .sheet(isPresented: $sendMail){
                    MailBookView( to: "toddcookevt@gmail.com", bookTitle: book.title, attachment: bookData)
                }
            }else{
                Button("Download book"){
                    downloadEbook(url: URL(string: "https://www.gutenberg.org/ebooks/\(book.textNum).epub3.images")!)
                }.padding()
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
                .environmentObject(ModelData())
    }
}
