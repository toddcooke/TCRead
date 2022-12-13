//
// Created by Todd Cooke on 12/11/22.
//

import Foundation
import SQLite

import SwiftCSV

class BookRepository {
    static let DIR_TASK_DB = "BookDB"
    static let STORE_NAME = "book.sqlite3"
    static let shared = BookRepository()

    private let booksTable = Table("books")
    private let textNum = Expression<Int>("textNum")
    private let type = Expression<String>("type")
    private let issued = Expression<Date>("issued")
    private let title = Expression<String>("title")
    private let language = Expression<String>("language")
    private let authors = Expression<String>("authors")
    private let subjects = Expression<String>("subjects")
    private let locc = Expression<String>("locc")
    private let bookshelves = Expression<String>("bookshelves")

    private var db: Connection? = nil

    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)
            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }

    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(booksTable.create { table in
                table.column(textNum, primaryKey: .default)
                table.column(type)
                table.column(issued)
                table.column(title)
                table.column(language)
                table.column(authors)
                table.column(subjects)
                table.column(locc)
                table.column(bookshelves)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }

    func insert(books: [Book]) -> Int64? {
        guard let database = db else {
            return nil
        }
        do {
            for book in books {
                let insert = booksTable.insert(
                        self.textNum <- book.textNum,
                        self.type <- book.type,
                        self.issued <- book.issued,
                        self.title <- book.title,
                        self.language <- book.language,
                        self.authors <- book.authors,
                        self.subjects <- book.subjects,
                        self.locc <- book.locc,
                        self.bookshelves <- book.bookshelves
                )
                let _ = try database.run(insert)
            }
            return 0
        } catch {
            print(error)
            return nil
        }
    }

    func getBooksByTitle(_ t: String) -> [Book] {
        var books: [Book] = []
        guard let database = db else {
            return []
        }
        do {
            let filter = booksTable.filter(title.like("\(t)%")).limit(50)
            for row in try database.prepare(filter) {
                books.append(toBook(row: row))
            }
        } catch {
            print(error)
        }
        return books
    }

    func toBook(row: Row) -> Book {
        Book(
                textNum: row[textNum],
                type: row[type],
                issued: row[issued],
                title: row[title],
                language: row[language],
                authors: row[authors],
                subjects: row[subjects],
                locc: row[locc],
                bookshelves: row[bookshelves]
        )
    }

    func getBooksById(_ tNums: Array<Int> = []) -> [Book] {
        guard let database = db else {
            return []
        }
        let filter = booksTable.filter(tNums.contains(textNum))
        var books = [Book]()
        do {
            for row in try database.prepare(filter) {
                books.append(toBook(row: row))
            }
        } catch {
            print(error)
            return []
        }
        return books
    }

    func catalogStringsToBooks(strings: EnumeratedCSV?) -> [Book] {
        var books: [Book] = []
        if strings == nil {
            return []
        }
        for row in strings!.rows {
            books.append(Book(
                    textNum: Int(row[0])!,
                    type: row[1],
                    issued: ContentView.bookDateFormatter.date(from: row[2])!,
                    title: row[3],
                    language: row[4],
                    authors: row[5],
                    subjects: row[6],
                    locc: row[7],
                    bookshelves: row[8])
            )
        }
        return books
    }

    func getCatalogCsv() -> EnumeratedCSV? {
        if let filepath = Bundle.main.path(forResource: "pg_catalog", ofType: "csv") {
            do {
                let lines = try String(contentsOfFile: filepath)
                let csv = try EnumeratedCSV(string: lines)
                return csv
            } catch {
                print("error reading csv")
                return nil
            }
        } else {
            print("pg_catalog.csv file not found")
            return nil
        }
    }
}
