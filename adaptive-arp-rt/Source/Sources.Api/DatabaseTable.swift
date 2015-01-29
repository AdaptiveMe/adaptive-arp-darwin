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

    * @version v2.1.1

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Represents a data table composed of databaseColumns and databaseRows.

   @author Ferran Vila Conesa
   @since v2.0
   @version 1.0
*/
public class DatabaseTable : APIBean {

    /**
       Number of databaseColumns.
    */
    var columnCount : Int?
    /**
       Definition of databaseColumns.
    */
    var databaseColumns : [DatabaseColumn]?
    /**
       Rows of the table containing the data.
    */
    var databaseRows : [DatabaseRow]?
    /**
       Name of the table.
    */
    var name : String?
    /**
       Number of databaseRows.
    */
    var rowCount : Int?

    /**
       Default constructor

       @since v2.0
    */
    public override init() {
        super.init()
    }

    /**
       Constructor by default

       @param name The name of the table
       @since v2.0
    */
    public init(name: String) {
        super.init()
        self.name = name
    }

    /**
       Constructor using fields

       @param name            The name of the table
       @param columnCount     The number of databaseColumns
       @param rowCount        The number of databaseRows
       @param databaseColumns The databaseColumns of the table
       @param databaseRows    The databaseRows of the table
       @since v2.0
    */
    public init(name: String, columnCount: Int, rowCount: Int, databaseColumns: [DatabaseColumn], databaseRows: [DatabaseRow]) {
        super.init()
        self.name = name
        self.columnCount = columnCount
        self.rowCount = rowCount
        self.databaseColumns = databaseColumns
        self.databaseRows = databaseRows
    }

    /**
       Get the number of databaseColumns

       @return The number of databaseColumns
       @since v2.0
    */
    public func getColumnCount() -> Int? {
        return self.columnCount
    }

    /**
       Sets the number of databaseColumns

       @param columnCount The number of databaseColumns
       @since v2.0
    */
    public func setColumnCount(columnCount: Int) {
        self.columnCount = columnCount
    }

    /**
       Get the databaseColumns

       @return The databaseColumns
       @since v2.0
    */
    public func getDatabaseColumns() -> [DatabaseColumn]? {
        return self.databaseColumns
    }

    /**
       Sets the databaseColumns of the table

       @param databaseColumns The databaseColumns of the table
       @since v2.0
    */
    public func setDatabaseColumns(databaseColumns: [DatabaseColumn]) {
        self.databaseColumns = databaseColumns
    }

    /**
       Get the databaseRows of the table

       @return The databaseRows of the table
       @since v2.0
    */
    public func getDatabaseRows() -> [DatabaseRow]? {
        return self.databaseRows
    }

    /**
       Sets the databaseRows of the table

       @param databaseRows The databaseRows of the table
       @since v2.0
    */
    public func setDatabaseRows(databaseRows: [DatabaseRow]) {
        self.databaseRows = databaseRows
    }

    /**
       Returns the name of the table

       @return The name of the table
       @since v2.0
    */
    public func getName() -> String? {
        return self.name
    }

    /**
       Sets the name of the table

       @param name The name of the table
       @since v2.0
    */
    public func setName(name: String) {
        self.name = name
    }

    /**
       Get the number of databaseRows

       @return The number of databaseRows
       @since v2.0
    */
    public func getRowCount() -> Int? {
        return self.rowCount
    }

    /**
       Sets the number of databaseRows

       @param rowCount The number of databaseRows
       @since v2.0
    */
    public func setRowCount(rowCount: Int) {
        self.rowCount = rowCount
    }


    /**
       JSON Serialization and deserialization support.
    */
    struct Serializer {
        static func fromJSON(json : String) -> DatabaseTable {
            var data:NSData = json.dataUsingEncoding(NSUTF8StringEncoding)!
            var jsonError: NSError?
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary
            return fromDictionary(dict)
        }

        static func fromDictionary(dict : NSDictionary) -> DatabaseTable {
            var resultObject : DatabaseTable = DatabaseTable()

            if let value : AnyObject = dict.objectForKey("columnCount") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.columnCount = (value as Int)
                }
            }

            if let value : AnyObject = dict.objectForKey("databaseColumns") {
                if "\(value)" as NSString != "<null>" {
                    var databaseColumns : [DatabaseColumn] = [DatabaseColumn]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        databaseColumns.append(DatabaseColumn.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.databaseColumns = databaseColumns
                }
            }

            if let value : AnyObject = dict.objectForKey("databaseRows") {
                if "\(value)" as NSString != "<null>" {
                    var databaseRows : [DatabaseRow] = [DatabaseRow]()
                    for (var i = 0;i < (value as NSArray).count ; i++) {
                        databaseRows.append(DatabaseRow.Serializer.fromDictionary((value as NSArray)[i] as NSDictionary))
                    }
                    resultObject.databaseRows = databaseRows
                }
            }

            if let value : AnyObject = dict.objectForKey("name") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.name = (value as String)
                }
            }

            if let value : AnyObject = dict.objectForKey("rowCount") {
                if "\(value)" as NSString != "<null>" {
                    resultObject.rowCount = (value as Int)
                }
            }

            return resultObject
        }

        static func toJSON(object: DatabaseTable) -> String {
            var jsonString : NSMutableString = NSMutableString()
            // Start Object to JSON
            jsonString.appendString("{ ")

            // Fields.
            object.columnCount != nil ? jsonString.appendString("\"columnCount\": \(object.columnCount!), ") : jsonString.appendString("\"columnCount\": null, ")
            if (object.databaseColumns != nil) {
                // Start array of objects.
                jsonString.appendString("\"databaseColumns\": [")

                for var i = 0; i < object.databaseColumns!.count; i++ {
                    jsonString.appendString(DatabaseColumn.Serializer.toJSON(object.databaseColumns![i]))
                    if (i < object.databaseColumns!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"databaseColumns\": null, ")
            }
            if (object.databaseRows != nil) {
                // Start array of objects.
                jsonString.appendString("\"databaseRows\": [")

                for var i = 0; i < object.databaseRows!.count; i++ {
                    jsonString.appendString(DatabaseRow.Serializer.toJSON(object.databaseRows![i]))
                    if (i < object.databaseRows!.count-1) {
                        jsonString.appendString(", ");
                    }
                }

                // End array of objects.
                jsonString.appendString("], ");
            } else {
                jsonString.appendString("\"databaseRows\": null, ")
            }
            object.name != nil ? jsonString.appendString("\"name\": \"\(JSONUtil.escapeString(object.name!))\", ") : jsonString.appendString("\"name\": null, ")
            object.rowCount != nil ? jsonString.appendString("\"rowCount\": \(object.rowCount!)") : jsonString.appendString("\"rowCount\": null")

            // End Object to JSON
            jsonString.appendString(" }")
            return jsonString
        }
    }
}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
