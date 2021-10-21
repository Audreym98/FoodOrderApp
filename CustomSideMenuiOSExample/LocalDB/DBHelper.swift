//
//  DBHelper.swift
//  FoodPin
//
//  Created by Audrey Shingleton on 9/11/21.
//

import Foundation
import SQLite3

class DBHelper {
    
    init() {
        db = openDatabase()
    }
    
    let dbPath: String = "Restaurants.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileURL_path = "/Users/audrey/Desktop/UM/Fa-21/Swift/CustomSideMenuiOSExample-main/CustomSideMenuiOSExample/LocalDB/Restaurants.sqlite"
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL_path, &db) != SQLITE_OK {
            print("error opening DB")
            return nil
        }
        print(fileURL_path)
        return db
    }
    
    func readFromDatabase() -> [Restaurant] {
        var queryStatement: OpaquePointer? = nil
        var restaurants: [Restaurant] = []
        let queryStatementString = "SELECT * FROM restaurants;"
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW{
                // get values from row
                let row_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let row_imageString = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let row_location = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let row_type = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                restaurants.append(Restaurant(name: row_name, imageString: row_imageString, location: row_location, type: row_type))
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Select failed: \(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return restaurants
    }
}
