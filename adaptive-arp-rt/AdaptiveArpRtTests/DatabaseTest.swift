/*
* =| ADAPTIVE RUNTIME PLATFORM |=======================================================================================
*
* (C) Copyright 2013-2014 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* Original author:
*
*     * Carlos Lozano Diez
*                 <http://github.com/carloslozano>
*                 <http://twitter.com/adaptivecoder>
*                 <mailto:carlos@adaptive.me>
*
* Contributors:
*
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/

import XCTest

class DatabaseTest: XCTestCase {
    
    /*var databaseImpl:DatabaseImpl!
    var iDatabaseResultCallbackImpl:IDatabaseResultCallbackImpl!
    var iTableResultCallbackImpl:ITableResultCallbackImpl!
    
    let dbName:String = "test"
    let tableName:String = "test"
    let columnName1:String = "_id"
    let columnName2:String = "column"

    override func setUp() {
        super.setUp()
        
        databaseImpl = DatabaseImpl()
        iDatabaseResultCallbackImpl = IDatabaseResultCallbackImpl()
        iTableResultCallbackImpl = ITableResultCallbackImpl()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    /// Operations to check the database manipulation
    func testDatabase() {
        
        var db:Database = Database(name: dbName)
        
        // EXISTS
        if databaseImpl.existsDatabase(db) {
            
            // DELETE
            databaseImpl.deleteDatabase(db, callback: iDatabaseResultCallbackImpl)
            XCTAssertFalse(databaseImpl.existsDatabase(db), "The database was not removed correctly")
        }
        
        // CREATE
        databaseImpl.createDatabase(db, callback: iDatabaseResultCallbackImpl)
        XCTAssertTrue(databaseImpl.existsDatabase(db), "The database was not created correctly")
    }
    
    /// Operations to check the table manipulation
    func testTable(){
        
        var db:Database = Database(name: dbName)
        var table:Table = Table(name: tableName)
        
        // Table columns
        table.setColumns([Column(name: columnName1), Column(name: columnName2)])
        
        // NOT EXISTS DATABASE
        if !databaseImpl.existsDatabase(db) {
            
            // CREATE DATABASE
            databaseImpl.createDatabase(db, callback: iDatabaseResultCallbackImpl)
            XCTAssertTrue(databaseImpl.existsDatabase(db), "The database was not created correctly")
        }
        
        // CREATE TABLE
        databaseImpl.createTable(db, table: table, callback: iTableResultCallbackImpl)
        
        // EXISTS TABLE
        XCTAssertTrue(databaseImpl.existsTable(db, table: table), "The table was not created correctly")
        
        // INSERT DATA (SQL)
        databaseImpl.executeSqlStatement(db, statement: "INSERT INTO `\(table.getName()!)` (\(columnName1), \(columnName2)) VALUES (?, ?)", replacements: ["1", "value"], callback: iTableResultCallbackImpl)
        
        // QUERY DATA (SQL)
        databaseImpl.executeSqlStatement(db, statement: "SELECT * FROM \(table.getName()!)", replacements: [], callback: iTableResultCallbackImpl)
        databaseImpl.executeSqlStatement(db, statement: "SELECT * FROM \(table.getName()!) WHERE \(columnName1) = ?", replacements: ["1"], callback: iTableResultCallbackImpl)
        databaseImpl.executeSqlStatement(db, statement: "SELECT * FROM \(table.getName()!) WHERE \(columnName1) = ?", replacements: ["0"], callback: iTableResultCallbackImpl)
        
        // DELETE DATA (SQL)
        databaseImpl.executeSqlStatement(db, statement: "DELETE FROM \(table.getName()!) WHERE \(columnName1) = ?", replacements: ["1"], callback: iTableResultCallbackImpl)
        databaseImpl.executeSqlStatement(db, statement: "DELETE FROM \(table.getName()!) WHERE \(columnName1) = ?", replacements: ["0"], callback: iTableResultCallbackImpl)
        
        // TRANSACTION (INSERT, DELETE)
        var statements = [
            "INSERT INTO \(table.getName()!) (\(columnName1), \(columnName2)) VALUES (1, 'value')",
            "DELETE FROM \(table.getName()!) WHERE \(columnName1) = 1"
        ]
        databaseImpl.executeSqlTransactions(db, statements: statements, rollbackFlag: true, callback: iTableResultCallbackImpl)
        
        
        if databaseImpl.existsTable(db, table: table) {
            
            // DELETE TABLE
            databaseImpl.deleteTable(db, table: table, callback: iTableResultCallbackImpl)
            
            XCTAssertFalse(databaseImpl.existsTable(db, table: table), "The table was not removed correctly")
        }
    }*/

}
/*
/// Dummy implementation of the callback in order to run the tests
class IDatabaseResultCallbackImpl: NSObject, IDatabaseResultCallback {
    
    func onError(error : IDatabaseResultCallbackError) {
        XCTAssert(false, "\(error)")
    }
    
    func onResult(database : Database) {
        
        XCTAssert(true, "")
    }
    
    func onWarning(database : Database, warning : IDatabaseResultCallbackWarning) {
        
        XCTAssert(true, "")
    }
    
    func toString() -> String? {
        return ""
    }
    func getId() -> Int64 {return 0}
}

/// Dummy implementation of the callback in order to run the tests
class ITableResultCallbackImpl: NSObject, ITableResultCallback {
    
    func onError(error : ITableResultCallbackError) {
        XCTAssert(false, "\(error)")
    }
    
    func onResult(table : Table) {
        
        println("RESULT: name:\(table.getName()!), columns[\(table.getColumnCount())]: \(table.getColumns()!), rows[\(table.getRowCount())]: \(table.getRows()!)")
        XCTAssert(true, "")
    }
    
    func onWarning(table : Table, warning : ITableResultCallbackWarning) {
        
        println("RESULT: name:\(table.getName()!), columns[\(table.getColumnCount())]: \(table.getColumns()!), rows[\(table.getRowCount())]: \(table.getRows()!)")
        XCTAssert(true, "")
    }
    
    func toString() -> String? {
        return ""
    }
    func getId() -> Int64 {return 0}
}*/
