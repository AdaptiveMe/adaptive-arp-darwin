/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

    * Carlos Lozano Diez
            <http://github.com/carloslozano>
            <http://twitter.com/adaptivecoder>
            <mailto:carlos@adaptive.me>

Contributors:

    * Ferran Vila Conesa
             <http://github.com/fnva>
             <http://twitter.com/ferran_vila>
             <mailto:ferran.vila.conesa@gmail.com>

    * See source code files for contributors.

Release:

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
import AdaptiveArpApi
import SQLite

/**
   Interface for Managing the Cloud operations
   Auto-generated implementation of IDatabase specification.
*/
public class DatabaseDelegate : BaseDataDelegate, IDatabase {
    
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "DatabaseDelegate"
    
    /// Documents directory
    var docDir:AnyObject?
    
    /// Queue for executing sync tasks
    var queue:dispatch_queue_t?
    
    /// SQLite database instance
    var db:SQLite.Database?
    
    /// Label for the queue
    let QUEUE_LABEL = "SQLiteDB"
    
    /// Database file extension
    let DB_EXT_FILE = ".sqlite3"
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        
        // Getting the "documents" directory
        docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        // Create a queue for executing syncronized methods
        queue = dispatch_queue_create(QUEUE_LABEL, nil)
        
        db = SQLite.Database("")
    }

    /**
       Creates a database on default path for every platform.

       @param callback Asynchronous callback
       @param database Database object to create
       @since ARP1.0
    */
    public func createDatabase(database : AdaptiveArpApi.Database, callback : IDatabaseResultCallback) {
        
        // TODO: handle NoSpace result callback error
        // TODO: The attribute compress database is not used, because in this framework (SQLite) is not supported
        
        if !self.checkDatabaseName(database) {
            callback.onError(IDatabaseResultCallbackError.SqlException)
            return
        }
        
        let dbName:String = String.fromCString(database.getName()!)!
        let path:String = self.docDir!.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
        
        self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Path of the database file: \(path)")
        
        // Create a file manager
        let fm:NSFileManager = NSFileManager.defaultManager()
        
        if !(fm.fileExistsAtPath(path)) {
            
            // The database does not exist, so create it
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Creating database file (\(dbName)) and setting a new database connection...")
            
            // Creating database
            self.db = SQLite.Database(path)
            
            callback.onResult(database)
            
            
        } else {
            
            // The database exists, opening
            self.logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "The database file, alredy exists (\(dbName)) opening a new database connection...")
            
            // Opening database
            //self.db = SQLite.Database(path)
            
            callback.onWarning(database, warning: IDatabaseResultCallbackWarning.DatabaseExists)
        }
    }

    /**
       Creates a databaseTable inside a database for every platform.

       @param database      Database for databaseTable creating.
       @param databaseTable DatabaseTable object with the name of the databaseTable inside.
       @param callback      DatabaseTable callback with the response
       @since ARP1.0
    */
    public func createTable(database : AdaptiveArpApi.Database, databaseTable : DatabaseTable, callback : IDatabaseTableResultCallback) {
        
        if !self.openDatabase(database) {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database is not found in the file system")
            callback.onError(IDatabaseTableResultCallbackError.DatabaseNotFound)
            return
        }
        
        // Check if there are columns in the table creation
        // MARK: The table parameters has to define columns inside the element because
        // it has no sense to create a table without columns
        if databaseTable.getDatabaseColumns()?.count == 0 {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The table has no columns defined")
            callback.onError(IDatabaseTableResultCallbackError.SqlException)
            return
        }
        
        var columns:String = ""
        
        for (index, column:DatabaseColumn) in enumerate(databaseTable.getDatabaseColumns()!) {
            if index != 0 {
                columns += ","
            }
            columns += "`"+column.getName()!+"`"
        }
        
        // Prepared statement
        var query:String = "CREATE TABLE IF NOT EXISTS `\(databaseTable.getName()!)` (\(columns));"
        self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Query: \(query)")
        
        let stmt = self.db!.prepare(query)
        
        // Run the prepared statement
        stmt.run()
        
        // Handle errors
        if stmt.failed {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error during the creation of the table. Reason: \(stmt.reason)")
            callback.onError(IDatabaseTableResultCallbackError.SqlException)
        } else {
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Table created correctly")
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Total changes: \(self.db!.totalChanges)")
            callback.onResult(databaseTable)
        }
    }

    /**
       Deletes a database on default path for every platform.

       @param database Database object to delete
       @param callback Asynchronous callback
       @since ARP1.0
    */
    public func deleteDatabase(database : AdaptiveArpApi.Database, callback : IDatabaseResultCallback) {
        
        if !self.checkDatabaseName(database) {
            callback.onError(IDatabaseResultCallbackError.SqlException)
            return
        }
        
        let dbName:String = String.fromCString(database.getName()!)!
        let path:String = self.docDir!.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
        
        self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Path of the database file: \(path)")
        
        // Create a file manager
        let fm:NSFileManager = NSFileManager.defaultManager()
        var error:NSError?
        
        if fm.removeItemAtPath(path, error: &error) {
            
            // Database removed succesfully
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The database \(dbName) was removed succesfully from the path: \(path)")
            callback.onResult(database)
            
        } else {
            
            // The database wasn't removed
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database \(dbName) wasn't removed succesfully from the path: \(path) due to reason: \(error?.description)")
            callback.onError(IDatabaseResultCallbackError.NotDeleted)
        }
    }

    /**
       Deletes a databaseTable inside a database for every platform.

       @param database      Database for databaseTable removal.
       @param databaseTable DatabaseTable object with the name of the databaseTable inside.
       @param callback      DatabaseTable callback with the response
       @since ARP1.0
    */
    public func deleteTable(database : AdaptiveArpApi.Database, databaseTable : DatabaseTable, callback : IDatabaseTableResultCallback) {
        
        if !self.openDatabase(database) {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database is not found in the file system")
            callback.onError(IDatabaseTableResultCallbackError.DatabaseNotFound)
            return
        }
        
        
        if self.existsTable(database, databaseTable: databaseTable)! {
            var query:String = "DROP TABLE `\(databaseTable.getName()!)`"
            let stmt = self.db!.prepare(query)
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Query: \(query)")
            
            // Run the prepared statement
            stmt.run()
            
            // Handle errors
            if stmt.failed {
                self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error droping the table. Reason: \(stmt.reason)")
                callback.onError(IDatabaseTableResultCallbackError.SqlException)
            } else {
                self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Table dropped correctly")
                self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Total changes: \(self.db!.totalChanges)")
                callback.onResult(databaseTable)
            }
            
        } else {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The table \(databaseTable.getName()) is not found in \(database.getName()) database")
            callback.onError(IDatabaseTableResultCallbackError.NoTableFound)
        }
    }

    /**
       Executes SQL statement into the given database. The replacements
should be passed as a parameter

       @param database     The database object reference.
       @param statement    SQL statement.
       @param replacements List of SQL statement replacements.
       @param callback     DatabaseTable callback with the response.
       @since ARP1.0
    */
    public func executeSqlStatement(database : AdaptiveArpApi.Database, statement : String, replacements : [String], callback : IDatabaseTableResultCallback) {
        
        if !self.openDatabase(database) {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database is not found in the file system")
            callback.onError(IDatabaseTableResultCallbackError.DatabaseNotFound)
            return
        }
        
        // Check if the replacements are the same than the ?
        if statement.rangesOfString("?").count != replacements.count {
            
            var c = statement.rangesOfString("?").count
            
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The number of replacements (\(replacements.count)) is different from the number of '?' (\(c))")
            callback.onError(IDatabaseTableResultCallbackError.SqlException)
            return
        }
        
        // Prepare the statement
        var sql = self.replaceReplacements(statement, replacements: replacements)
        
        self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Query: \(sql)")
        
        // run the statement
        let stmt = self.db!.prepare(sql)
        
        // Prepare the table for the result
        var table:DatabaseTable = self.prepareTable(stmt)
        
        // Handle errors
        if stmt.failed {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error executing the statement. Reason: \(stmt.reason)")
            callback.onError(IDatabaseTableResultCallbackError.SqlException)
        } else {
            
            if table.getRowCount() == 0 {
                self.logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "There are no results")
                callback.onWarning(table, warning: IDatabaseTableResultCallbackWarning.NoResults)
            } else {
                self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Statement executed correctlly")
                self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Total changes: \(self.db!.totalChanges)")
                callback.onResult(table)
            }
        }
    }

    /**
       Executes SQL transaction (some statements chain) inside given database.

       @param database     The database object reference.
       @param statements   The statements to be executed during transaction.
       @param rollbackFlag Indicates if rollback should be performed when any
                    statement execution fails.
       @param callback     DatabaseTable callback with the response.
       @since ARP1.0
    */
    public func executeSqlTransactions(database : AdaptiveArpApi.Database, statements : [String], rollbackFlag : Bool, callback : IDatabaseTableResultCallback) {
        
        // TODO: use rollbackFlag. Now, when error ocurs, all the transaction is rolled back
        
        if !self.openDatabase(database) {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database is not found in the file system")
            callback.onError(IDatabaseTableResultCallbackError.DatabaseNotFound)
            return
        }
        
        // Start transaction
        var txn = self.db!.prepare("BEGIN TRANSACTION")
        for query in statements {
            txn = txn && self.db!.prepare(query)
        }
        
        if txn.failed {
            self.db!.run("ROLLBACK TRANSACTION")
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error executing the statement. Reason: \(txn.reason)")
            callback.onError(IDatabaseTableResultCallbackError.SqlException)
            return
        } else {
            self.db!.run("COMMIT TRANSACTION")
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Transaction commited correctlly")
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Total changes: \(self.db!.totalChanges)")
        }
        
        // TODO: the table is empty
        callback.onResult(DatabaseTable())
    }

    /**
       Checks if database exists by given database name.

       @param database Database Object to check if exists
       @return True if exists, false otherwise
       @since ARP1.0
    */
    public func existsDatabase(database : AdaptiveArpApi.Database) -> Bool? {
        
        if !self.checkDatabaseName(database) {
            return false
        }
        
        let dbName:String = String.fromCString(database.getName()!)!
        let path:String = self.docDir!.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
        
        self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Path of the database file: \(path)")
        
        // Create a file manager
        let fm:NSFileManager = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(path) {
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The database \(dbName) exists :)")
            return true
        } else {
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "The database \(dbName) NOT exists :(")
            return false
        }
    }

    /**
       Checks if databaseTable exists by given database name.

       @param database      Database for databaseTable consulting.
       @param databaseTable DatabaseTable object with the name of the databaseTable inside.
       @return True if exists, false otherwise
       @since ARP1.0
    */
    public func existsTable(database : AdaptiveArpApi.Database, databaseTable : DatabaseTable) -> Bool? {
        
        if !self.openDatabase(database) {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database is not found in the file system")
            return false
        }
        
        // Prepare query
        let sqlite_master:Query = self.db!["sqlite_master"]
        
        let tbl_name = Expression<String>("tbl_name")
        
        let tables:Query = sqlite_master.filter(tbl_name == databaseTable.getName()!).order("tbl_name").limit(1)
        
        //self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Query: \(tables.description)")
        
        for row in tables {
            self.logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Founded one table with name: \(databaseTable.getName())")
            return true
        }
        return false
    }
    
    /**
       Check if the database name is a valid
    
       @param database      Database for databaseTable consulting.
    */
    private func checkDatabaseName(database: AdaptiveArpApi.Database) -> Bool {
        
        if(database.getName()!.isEmpty || database.getName() == ""){
            
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The name of the database could not be empty")
            return false
        }
        return true
    }
    
    /**
       This method open a database connection if is not open yet
    
       @param database      Database for databaseTable consulting.
    */
    private func openDatabase(database: AdaptiveArpApi.Database) -> Bool {
        
        if !self.checkDatabaseName(database) {
            return false
        }
        
        if !self.existsDatabase(database)! {
            self.logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The database you are trying to open is not created")
            return false
        }
        
        let dbName:String = String.fromCString(database.getName()!)!
        let path:String = self.docDir!.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
        
        // Opening database
        self.db = SQLite.Database(path)
        
        return true
    }
    
    /**
       Replace all the ? in the query by the replacements
    */
    private func replaceReplacements(s:String, replacements : [String]) -> String {
        
        // MARK: We supose that the replacements are ?
        
        var iteration = 0
        var count = 0
        var sql = s
        
        if replacements.count > 0 {
            
            repeat {
                var range = sql.rangesOfString("?")
                count = range.count
                
                sql = sql.stringByReplacingCharactersInRange(range[0], withString: "'\(replacements[iteration])'")
                iteration++
            } while count > 1
            
        }
        
        return sql
    }
    
    /**
       Compose a Table object with the result set of the statement
    */
    private func prepareTable(stmt:Statement) -> DatabaseTable {
        
        // TODO: extract table name from statement
        // TODO: set the column names to the result table
        
        let table:DatabaseTable = DatabaseTable()
        var rowCount:Int32 = 0
        var columnCount:Int32 = 0
        var rows:[DatabaseRow] = []
        
        for row in stmt {
            
            var vals = [String]()
            columnCount = Int32(row.count)
            
            for (value) in row {
                vals.append("\(value!)")
            }
            
            rows.append(DatabaseRow(values: vals as [String]))
            rowCount++
        }
        
        table.setRowCount(rowCount)
        table.setColumnCount(columnCount)
        table.setDatabaseRows(rows)
        
        return table
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
