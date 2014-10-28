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

import Foundation
//import SQLite

public class DatabaseImpl : NSObject, IDatabase {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Documents directory
    let docDir:AnyObject
    
    /// Queue for executing sync tasks
    // var queue:dispatch_queue_t
    
    /// SQLite database instance
    //var db:SQLite.Database = SQLite.Database("")
    
    /// Label for the queue
    let QUEUE_LABEL = "SQLiteDB"
    
    /// Database file extension
    let DB_EXT_FILE = ".sqlite3"
    
    /**
    Class constructor
    */
    override init() {
        
        // Getting the "documents" directory
        docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        // Create a queue for executing syncronized methods
        // queue = dispatch_queue_create(QUEUE_LABEL, nil)
    }
    
    /// Check if the database name is a valida
    private func checkDatabaseName(database: Database) -> Bool {
        
        if(database.getName()!.isEmpty || database.getName() == ""){
            
            self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The name of the database could not be empty")
            return false
        }
        return true
    }
    
    /**
    * Creates a database on default path for every platform.
    *
    * @param callback Asynchronous callback
    * @param database Database object to create
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func createDatabase(database : Database, callback : IDatabaseResultCallback) {
        
        // TODO: handle NoSpace result callback error
        // TODO: The attribute compress database is not used, because in this framework (SQLite) is not supported
        
        // Execute the method inside an async task
        dispatch_async(dispatch_get_main_queue()) {
            
            if !self.checkDatabaseName(database) {
                callback.onError(IDatabaseResultCallbackError.SqlException)
                return
            }
            
            let dbName:String = String.fromCString(database.getName()!)!
            let path:String = self.docDir.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
            
            self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Path of the database file: \(path)")
            
            // Create a file manager
            let fm:NSFileManager = NSFileManager.defaultManager()
            
            /*if (self.db != nil) {
                
                // The database is opened, so returning an instance
                self.logger.log(ILoggingLogLevel.WARN, category: "DatabaseImpl", message: "The database is opened use the same database connection")
                callback.onWarning(database, warning: IDatabaseResultCallbackWarning.IsOpen)
                
            } else {*/
                
                if !(fm.fileExistsAtPath(path)) {
                    
                    // The database does not exist, so create it
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Creating database file (\(dbName)) and setting a new database connection...")
                    
                    // Creating database
                    //self.db = SQLite.Database(path)
                    
                    callback.onResult(database)
                    
                    
                } else {
                    
                    // The database exists, opening
                    self.logger.log(ILoggingLogLevel.WARN, category: "DatabaseImpl", message: "The database file, alredy exists (\(dbName)) opening a new database connection...")
                    
                    // Opening database
                    //self.db = SQLite.Database(path)
                    
                    callback.onWarning(database, warning: IDatabaseResultCallbackWarning.DatabaseExists)
                }
            //}
        }
        
        
    }
    
    /**
    * Checks if database exists by given database name.
    *
    * @param database Database Object to check if exists
    * @return True if exists, false otherwise
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func existsDatabase(database : Database) -> Bool {
        
        if !self.checkDatabaseName(database) {
            return false
        }
        
        let dbName:String = String.fromCString(database.getName()!)!
        let path:String = self.docDir.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
        
        self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Path of the database file: \(path)")
        
        // Create a file manager
        let fm:NSFileManager = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(path) {
            self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "The database \(dbName) exists :)")
            return true
        } else {
            self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "The database \(dbName) NOT exists :(")
            return false
        }
    }
    
    /**
    * Deletes a database on default path for every platform.
    *
    * @param database Database object to delete
    * @param callback Asynchronous callback
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func deleteDatabase(database : Database, callback : IDatabaseResultCallback) {
        
        // Execute the method inside an async task
        dispatch_async(dispatch_get_main_queue()) {
            
            if !self.checkDatabaseName(database) {
                callback.onError(IDatabaseResultCallbackError.SqlException)
                return
            }
            
            let dbName:String = String.fromCString(database.getName()!)!
            let path:String = self.docDir.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
            
            self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Path of the database file: \(path)")
            
            // Create a file manager
            let fm:NSFileManager = NSFileManager.defaultManager()
            var error:NSError?
            
            if fm.removeItemAtPath(path, error: &error) {
                
                // Database removed succesfully
                self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "The database \(dbName) was removed succesfully from the path: \(path)")
                callback.onResult(database)
                
            } else {
                
                // The database wasn't removed
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database \(dbName) wasn't removed succesfully from the path: \(path) due to reason: \(error?.description)")
                callback.onError(IDatabaseResultCallbackError.NotDeleted)
            }
        }
    }
    
    /**
    * Returns a Database if exists by a given name encapsulated inside a
    * Database Object.
    *
    * @param database Database object to find
    * @param callback Asynchronous callback
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func getDatabase(database : Database, callback : IDatabaseResultCallback) {
        
        // TODO: this will be removed
    }
    
    /**
    * This method open a database connection if is not open yet
    *
    * @param database Database object to find
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    private func openDatabase(database: Database) -> Bool {
        
        if !self.checkDatabaseName(database) {
            return false
        }
        
        if !self.existsDatabase(database) {
            self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database you are trying to open is not created")
            return false
        }
        
        // We always open the database
        //if (self.db == nil) {
            
            let dbName:String = String.fromCString(database.getName()!)!
            let path:String = self.docDir.stringByAppendingPathComponent(dbName + self.DB_EXT_FILE)
            
            // Opening database
            //self.db = SQLite.Database(path)
            
        //} else {
            
            //self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "The database is alredy opened")
        //}
        
        return true
    }
    
    /**
    * Creates a table inside a database for every platform.
    *
    * @param database Database for table creating.
    * @param table    Table object with the name of the table inside.
    * @param callback Table callback with the response
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func createTable(database : Database, table : Table, callback : ITableResultCallback) {
        
        // Execute the method inside an async task
        dispatch_async(dispatch_get_main_queue()) {
            
            if !self.openDatabase(database) {
                // TODO: change by DatabaseNotFound
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database is not found in the file system")
                callback.onError(ITableResultCallbackError.SqlException)
                return
            }
            
            var columns:String = ""
            
            for (index, column:Column) in enumerate(table.getColumns()!) {
                if index != 0 {
                    columns += ","
                }
                columns += column.getName()!
            }
            
            //let stmt = self.db.prepare("CREATE TABLE IF NOT EXISTS \(table.getName()) (\(columns))")
            
            // Query only for logging purposes
            var query:String = "CREATE TABLE IF NOT EXISTS \(table.getName()) (\(columns))"
            self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Query: \(query)")            
            
            // Run the prepared statement
            //stmt.run("")
            
            // Handle errors
            /*
            if stmt.failed {
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "Error during the creation of the table. Reason: \(stmt.reason)")
                callback.onError(ITableResultCallbackError.SqlException)
            } else {
                self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Table created correctly")
                self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Total changes: \(self.db.totalChanges)")
                callback.onResult(table)
            }
            */
        }
    }
    
    /**
    * Deletes a table inside a database for every platform.
    *
    * @param database Database for table removal.
    * @param table    Table object with the name of the table inside.
    * @param callback Table callback with the response
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func deleteTable(database : Database, table : Table, callback : ITableResultCallback) {
        
        // Execute the method inside an async task
        dispatch_async(dispatch_get_main_queue()) {
            
            if !self.openDatabase(database) {
                // TODO: change by DatabaseNotFound
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database is not found in the file system")
                callback.onError(ITableResultCallbackError.SqlException)
                return
            }
            
            
            if self.existsTable(database, table: table) {
                //let stmt = self.db.prepare("DROP TABLE \(table.getName())")
                
                // Query only for logging purposes
                var query:String = "DROP TABLE \(table.getName())"
                self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Query: \(query)")
                
                // Run the prepared statement
                // stmt.run("")
                
                // Handle errors
                /*
                if stmt.failed {
                    self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "Error droping the table. Reason: \(stmt.reason)")
                    callback.onError(ITableResultCallbackError.SqlException)
                } else {
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Table dropped correctly")
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Total changes: \(self.db.totalChanges)")
                    callback.onResult(table)
                }
                */
                
            } else {
                // TODO: change by NoTableFound
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The table \(table.getName()) is not found in \(database.getName()) database")
                callback.onError(ITableResultCallbackError.SqlException)
            }
        }
    }
    
    /**
    * Checks if table exists by given database name.
    *
    * @param database Database for table consulting.
    * @param table    Table object with the name of the table inside.
    * @return True if exists, false otherwise
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func existsTable(database : Database, table : Table) -> Bool {
        
        if !self.openDatabase(database) {
            // TODO: change by DatabaseNotFound
            self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database is not found in the file system")
            return false
        }
        
        // Prepare query
        //let sqlite_master:Query = self.db["sqlite_master"]
            
        //let tables:Query = sqlite_master.filter("tbl_name = ?", table.getName()).order("tbl_name").limit(1)
        //self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Query: \(tables)")
        /*
        for row in tables {
            self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Founded one table with name: \(table.getName())")
            return true
        }
        */
        return false
    }
    
    /**
    * Executes SQL query against given database. The replacements should be
    * passed as a parameter
    *
    * @param database     The database object reference.
    * @param query        SQL query
    * @param replacements List of SQL query replacements.
    * @param callback     Table callback with the response.
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func executeSqlQuery(database : Database, query : String, replacements : [String], callback : ITableResultCallback) {
        
        // TODO: discuss if this method is necessary
        self.executeSqlStatement(database, statement: query, replacements: replacements, callback: callback)
        
    }
    
    /**
    * Executes SQL statement into the given database. The replacements
    * should be passed as a parameter
    *
    * @param database     The database object reference.
    * @param statement    SQL statement.
    * @param replacements List of SQL statement replacements.
    * @param callback     Table callback with the response.
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func executeSqlStatement(database : Database, statement : String, replacements : [String], callback : ITableResultCallback) {
                
        // Execute the method inside an async task
        dispatch_async(dispatch_get_main_queue()) {
            
            if !self.openDatabase(database) {
                // TODO: change by DatabaseNotFound
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database is not found in the file system")
                callback.onError(ITableResultCallbackError.SqlException)
                return
            }
            
            // Check if the replacements are the same than the ?
            if statement.rangesOfString("?").count != replacements.count {
                
                var c = statement.rangesOfString("?").count
                
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The number of replacements (\(replacements.count)) is different from the number of '?' (\(c))")
                callback.onError(ITableResultCallbackError.SqlException)
                return
            }
                
            // Prepare the statement
            var sql = self.replaceReplacements(statement, replacements: replacements)
            
            // run the statement
            //let stmt = self.db.prepare(sql)
            
            // Prepare the table for the result
            //var table:Table = self.prepareTable(stmt)
            
            // Handle errors
            /*
            if stmt.failed {
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "Error executing the statement. Reason: \(stmt.reason)")
                callback.onError(ITableResultCallbackError.SqlException)
            } else {
                
                if table.getRowCount() == 0 {
                    self.logger.log(ILoggingLogLevel.WARN, category: "DatabaseImpl", message: "There are no results")
                    callback.onWarning(table, warning: ITableResultCallbackWarning.NoResults)
                } else {
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Statement executed correctlly")
                    self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Total changes: \(self.db.totalChanges)")
                    callback.onResult(table)
                }
            }
            */
        }
    }
    
    /**
    * Executes SQL transaction (some statements chain) inside given database.
    *
    * @param database     The database object reference.
    * @param statements   The statements to be executed during transaction.
    * @param rollbackFlag Indicates if rollback should be performed when any
    *                     statement execution fails.
    * @param callback     Table callback with the response.
    * @author Ferran Vila Conesa
    * @since ARP1.0
    */
    public func executeSqlTransactions(database : Database, statements : [String], rollbackFlag : Bool, callback : ITableResultCallback) {
        
        // TODO: use rollbackFlag. Now, when error ocurs, all the transaction is rolled back
        
        // Execute the method inside an async task
        dispatch_async(dispatch_get_main_queue()) {
            
            if !self.openDatabase(database) {
                // TODO: change by DatabaseNotFound
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "The database is not found in the file system")
                callback.onError(ITableResultCallbackError.SqlException)
                return
            }
            
            // Start transaction
            
            // Start transaction
            /*
            var txn = self.db.prepare("BEGIN TRANSACTION")
            for query in statements {
                txn = txn && self.db.prepare(query)
            }
            
            if txn.failed {
                self.db.run("ROLLBACK TRANSACTION")
                self.logger.log(ILoggingLogLevel.ERROR, category: "DatabaseImpl", message: "Error executing the statement. Reason: \(txn.reason)")
                callback.onError(ITableResultCallbackError.SqlException)
                return
            } else {
                self.db.run("COMMIT TRANSACTION")
                self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Transaction commited correctlly")
                self.logger.log(ILoggingLogLevel.DEBUG, category: "DatabaseImpl", message: "Total changes: \(self.db.totalChanges)")
            }
            */
            // TODO: the table is empty
            callback.onResult(Table())
        }
    }
    
    /// Replace all the ? in the query by the replacements
    private func replaceReplacements(s:String, replacements : [String]) -> String {
        
        // MARK: We supose that the replacements are ?
        
        var iteration = 0
        var count = 0
        var sql = s
        
        do {
            var range = sql.rangesOfString("?")
            count = range.count
            
            sql = sql.stringByReplacingCharactersInRange(range[0], withString: "'\(replacements[iteration])'")
            iteration++
        } while count > 1
        
        return sql
    }
    
    /// Compose a Table object with the result set of the statement
    /*
    private func prepareTable(stmt:Statement) -> Table {
        
        // TODO: extract table name from statement
        // TODO: set the column names to the result table
        
        var table:Table = Table()
        var rowCount:Int = 0
        var columnCount:Int = 0
        var rows:[Row] = [Row]()
        
        for row in stmt {
            
            var vals:[Any] = [Any]()
            columnCount = row.count
            
            for value in row {
                vals.append(value)
            }
            
            rows.append(Row(values: vals as [AnyObject]))
            rowCount++
        }
        
        table.setRowCount(rowCount)
        table.setColumnCount(columnCount)
        table.setRows(rows)
        
        return table
    }
    */
}