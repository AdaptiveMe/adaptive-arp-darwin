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

public class DatabaseImpl : IDatabase {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /**
    Class constructor
    */
    init() {
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
        
        // TODO
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
        
        // TODO
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
        
        // TODO
        
        return true
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
        
        // TODO
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
        
        // TODO
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
        
        // TODO
        
        return true
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
        
        // TODO
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
        
        // TODO
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
        
        // TODO
    }
}