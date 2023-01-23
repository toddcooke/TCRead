//
//  Book.swift
//  TCRead
//
//  Created by Todd Cooke on 12/13/22.
//

import Foundation

struct Book: Encodable, Hashable, Identifiable {
  var id: String {
    textNum
  }

  var textNum: String
  var type: String
  var issued: String
  var title: String
  var language: String
  var authors: String
  var subjects: String
  var locc: String
  var bookshelves: String

  static func exampleBook() -> Book {
    Book(
      textNum: "0", type: "book", issued: Date.now.description,
      title: "Alice in wonderland", language: "en", authors: "Lewis Carrol", subjects: "Fiction",
      locc: "PR", bookshelves: "Childrens Literature")
  }
}

extension String {
  // Melville, Herman, 1819-1891 -> Herman Melville
  func formatAuthor() -> String {
    let components = components(separatedBy: ",")
    if components.count == 3 {
      return "\(components[1]) \(components[0])"
    }
    return self
  }
}

extension String {
  func formatAuthorComplex() -> String {
    var components = components(separatedBy: ",").map {
      $0.trimmingCharacters(in: .whitespaces)
    }
    .map { s in
      // Remove non letter characters
      var result = s
      result.unicodeScalars.removeAll { element in
        !CharacterSet.letters.contains(element) && element != " "
      }
      return result
    }
    .filter { (t: String) in
      !t.isEmpty
    }
    guard components.count > 1 else {
      return self
    }

    var i = 0
    var highestSwapped: Int = -1
    while i < components.count {
      // if curr ! name: remove [i]th
      // if highestSwapped != i -1: swap curr,prev; highestSwapped = i
      // i++
      let curr = components[i]
      guard isName(curr) else {
        components.remove(at: i)
        i += 1
        continue
      }
      guard i > 0 else {
        i += 1
        continue
      }
      let prev = components[i - 1]
      if highestSwapped != i - 1 {
        components[i] = prev
        components[i - 1] = curr
        if i != components.count - 1 {
          components.insert(",", at: i + 1)
          highestSwapped = i + 1
          i += 1
        }
      }
      i += 1
    }
    var result = components.joined(separator: " ")
    result.replace(" , ", with: ", ")
    result.replace("  ", with: " ")
    return result
  }

  private func isName(_ current: String) -> Bool {
    current.unicodeScalars.allSatisfy { element in
      CharacterSet.letters.contains(element) || element == " "
    }
  }
}
