//
// Created by Todd Cooke on 12/11/22.
//

import Foundation
import SQLite


struct Task {
    let id: Int64
    var name: String
    var date: Date
    var status: Bool
}

struct Book: Encodable {
    var textNum: String
    var type: String
    var issued: String
    var title: String
    var language: String
    var authors: String
    var subjects: String
    var locc: String
    var bookshelves: String
}

class Repository {

    static let DIR_TASK_DB = "BookDB"
    static let STORE_NAME = "book.sqlite3"

    private let booksTable = Table("books")

    private let textNum = Expression<Int64>("textNum")
    private let type = Expression<String>("type")
    private let issued = Expression<Date>("issued")
    private let title = Expression<String>("title")
    private let language = Expression<String>("language")
    private let authors = Expression<String>("authors")
    private let subjects = Expression<String>("subjects")
    private let locc = Expression<String>("locc")
    private let bookshelves = Expression<String>("bookshelves")

    static let shared = Repository()

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
            /**
private let textNum = Expression<Int64>("textNum")
private let type = Expression<String>("type")
private let issued = Expression<Date>("issued")
private let title = Expression<String>("title")
private let language = Expression<String>("language")
private let authors = Expression<String>("authors")
private let subjects = Expression<String>("subjects")
private let locc = Expression<String>("locc")
private let bookshelves = Expression<String>("bookshelves")
             */
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

//        let insert = booksTable.insert(self.type <- name,
//                self.issued <- date,
//                self.title <- false
//        )

        do {
            let insert = try booksTable.insertMany(books)
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }

//    func getAllTasks() -> [Task] {
//        var tasks: [Task] = []
//        guard let database = db else {
//            return []
//        }
//
//        do {
//            for task in try database.prepare(self.booksTable) {
//                tasks.append(Task(id: task[textNum], name: task[type], date: task[issued], status: task[title]))
//            }
//        } catch {
//            print(error)
//        }
//        return tasks
//    }


//    func findTask(taskId: Int64) -> Task? {
//        var task: Task = Task(id: taskId, name: "", date: Date(), status: false)
//        guard let database = db else {
//            return nil
//        }
//
//        let filter = self.booksTable.filter(textNum == taskId)
//        do {
//            for t in try database.prepare(filter) {
//                task.name = t[type]
//                task.date = t[issued]
//                task.status = t[title]
//            }
//        } catch {
//            print(error)
//        }
//        return task
//    }

//    func update(id: Int64, name: String, date: Date = Date(), status: Bool = false) -> Bool {
//        guard let database = db else {
//            return false
//        }
//
//        let task = booksTable.filter(self.textNum == id)
//        do {
//            let update = task.update([
//                type <- name,
//                self.issued <- date,
//                self.title <- status
//            ])
//            if try database.run(update) > 0 {
//                return true
//            }
//        } catch {
//            print(error)
//        }
//        return false
//    }

    func delete(id: Int64) -> Bool {
        guard let database = db else {
            return false
        }
        do {
            let filter = booksTable.filter(self.textNum == id)
            try database.run(filter.delete())
            return true
        } catch {
            print(error)
            return false
        }
    }
}
