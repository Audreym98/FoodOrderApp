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
    
    let dbPath: String = "FoodApp.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileURL_path = "/Users/audrey/Desktop/UM/Fa-21/Swift/FoodOrderApp-main/FoodOrderApp/LocalDB/FoodApp.sqlite"
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL_path, &db) != SQLITE_OK {
            print("error opening DB")
            return nil
        }
        print(fileURL_path)
        return db
    }
    
    func readFromDatabase() -> [MenuItem] {
        var queryStatement: OpaquePointer? = nil
        var menuItems: [MenuItem] = []
        let queryStatementString = "SELECT * FROM menu;"
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW{
                // get values from row
                let row_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let row_imageString = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let row_type = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let row_price = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let row_description = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                menuItems.append(MenuItem(name: row_name, imageString: row_imageString, type: row_type, price: row_price, description: row_description))
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Select failed: \(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return menuItems
    }
}
