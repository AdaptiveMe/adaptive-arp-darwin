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
import AdaptiveArpApi

/**
*  Database delegate tests class
*/
class DatabaseTest: XCTestCase {
    
    /// Callback for results
    var callbackDatabase:DatabaseResultCallbackTest!
    var callbackTable:DatabaseTableResultCallbackTest!
    
    /// Constants
    let DBNAME:String = "DBTEST"
    let TBLNAME:String = "TBLTEST"
    let COLNAME1:String = "COL1"
    let COLNAME2:String = "COL2"
    
    /**
    Constructor.
    */
    override func setUp() {
        super.setUp()
        
        AppRegistryBridge.sharedInstance.getLoggingBridge().setDelegate(LoggingDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContext().setDelegate(AppContextDelegate())
        AppRegistryBridge.sharedInstance.getPlatformContextWeb().setDelegate(AppContextWebviewDelegate())
        AppRegistryBridge.sharedInstance.getDatabaseBridge().setDelegate(DatabaseDelegate())
        
        callbackDatabase = DatabaseResultCallbackTest(id: 0)
        callbackTable = DatabaseTableResultCallbackTest(id: 0)
    }
    
    /**
    Test case for testing the database operations
    */
    func testDatabase() {
        
        let db:Database = Database(name: DBNAME)
        
        // EXISTS
        if AppRegistryBridge.sharedInstance.getDatabaseBridge().existsDatabase(db)! {
            
            // DELETE
            AppRegistryBridge.sharedInstance.getDatabaseBridge().deleteDatabase(db, callback: callbackDatabase)
            XCTAssertFalse(AppRegistryBridge.sharedInstance.getDatabaseBridge().existsDatabase(db)!, "The database was not removed correctly")
        }
        
        // CREATE
        AppRegistryBridge.sharedInstance.getDatabaseBridge().createDatabase(db, callback: callbackDatabase)
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getDatabaseBridge().existsDatabase(db)!, "The database was not created correctly")
    }
    
    /**
    Test case for testing table operations
    */
    func testTable(){
        
        let db:Database = Database(name: DBNAME)
        let table:DatabaseTable = DatabaseTable(name: TBLNAME)
        
        // Table columns
        table.setDatabaseColumns([DatabaseColumn(name: COLNAME1), DatabaseColumn(name: COLNAME2)])
        table.setColumnCount(2)
        table.setRowCount(0)
        
        // NOT EXISTS DATABASE
        if !AppRegistryBridge.sharedInstance.getDatabaseBridge().existsDatabase(db)! {
            
            // CREATE DATABASE
            AppRegistryBridge.sharedInstance.getDatabaseBridge().createDatabase(db, callback: callbackDatabase)
            XCTAssertTrue(AppRegistryBridge.sharedInstance.getDatabaseBridge().existsDatabase(db)!, "The database was not created correctly")
        }
        
        // CREATE TABLE
        AppRegistryBridge.sharedInstance.getDatabaseBridge().createTable(db, databaseTable: table, callback: callbackTable)
        
        // EXISTS TABLE
        XCTAssertTrue(AppRegistryBridge.sharedInstance.getDatabaseBridge().existsTable(db, databaseTable: table)!, "The table was not created correctly")
        
        // INSERT DATA (SQL)
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlStatement(db, statement: "INSERT INTO `\(table.getName()!)` (\(COLNAME1), \(COLNAME2)) VALUES (?, ?)", replacements: ["1", "value"], callback: callbackTable)
        
        // QUERY DATA (SQL)
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlStatement(db, statement: "SELECT * FROM \(table.getName()!)", replacements: [], callback: callbackTable)
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlStatement(db, statement: "SELECT * FROM \(table.getName()!) WHERE \(COLNAME1) = ?", replacements: ["1"], callback: callbackTable)
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlStatement(db, statement: "SELECT * FROM \(table.getName()!) WHERE \(COLNAME1) = ?", replacements: ["0"], callback: callbackTable)
        
        // DELETE DATA (SQL)
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlStatement(db, statement: "DELETE FROM \(table.getName()!) WHERE \(COLNAME1) = ?", replacements: ["1"], callback: callbackTable)
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlStatement(db, statement: "DELETE FROM \(table.getName()!) WHERE \(COLNAME1) = ?", replacements: ["0"], callback: callbackTable)
        
        // TRANSACTION (INSERT, DELETE)
        let statements = [
            "INSERT INTO \(table.getName()!) (\(COLNAME1), \(COLNAME2)) VALUES (1, 'value')",
            "DELETE FROM \(table.getName()!) WHERE \(COLNAME1) = 1"
        ]
        AppRegistryBridge.sharedInstance.getDatabaseBridge().executeSqlTransactions(db, statements: statements, rollbackFlag: true, callback: callbackTable)
        
        
        if AppRegistryBridge.sharedInstance.getDatabaseBridge().existsTable(db, databaseTable: table)! {
            
            // DELETE TABLE
            AppRegistryBridge.sharedInstance.getDatabaseBridge().deleteTable(db, databaseTable: table, callback: callbackTable)
            
            XCTAssertFalse(AppRegistryBridge.sharedInstance.getDatabaseBridge().existsTable(db, databaseTable: table)!, "The table was not removed correctly")
        }
    }
}