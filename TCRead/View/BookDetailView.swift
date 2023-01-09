//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

import SwiftUI
import Alamofire

struct BookDetailView: View {
    var book: Book
    @EnvironmentObject var modelData: ModelData
    @State private var bookData: Data? = nil
    @State private var sendMail: Bool = false

    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: "https://www.gutenberg.org/cache/epub/\(book.textNum)/pg\(book.textNum).cover.medium.jpg")
            ) { image in
                image.aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .shadow(color: .black, radius: 5, x: 10, y: 10)
            .padding()
            Text(book.title).bold().font(.title).padding([.leading, .trailing])
            Text(book.authors.formatAuthor()).font(.title2)

            if let bookData {
                Button("Send to \(S.ereader)") {
                    sendMail.toggle()
                }
                .buttonStyle(.bordered)
                .padding()
                .sheet(isPresented: $sendMail) {
                    // Doesn't work on ios simulator
                    MailBookView(to: modelData.kindleEmail!, bookTitle: book.title, attachment: bookData)
                }
            } else {
                Button("Download book") {
                    downloadEbook(url: URL(string: "https://www.gutenberg.org/ebooks/\(book.textNum).epub3.images")!)
                }
                .buttonStyle(.bordered)
                .padding()
            }
        }
        .padding()
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

// https://stackoverflow.com/a/25471164/3569329
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return email.hasSuffix("@kindle.com") && emailPred.evaluate(with: email)
}
