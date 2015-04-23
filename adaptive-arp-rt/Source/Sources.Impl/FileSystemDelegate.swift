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

/**
   Interface for Managing the File System operations
   Auto-generated implementation of IFileSystem specification.
*/
public class FileSystemDelegate : BaseDataDelegate, IFileSystem {

    /**
       Default Constructor.
    */
    public override init() {
        super.init()
    }

    /**
       Creates a new reference to a new or existing location in the filesystem.
This method does not create the actual file in the specified folder.

       @param parent Parent directory.
       @param name   Name of new file or directory.
       @return A reference to a new or existing location in the filesystem.
       @since ARP1.0
    */
    public func createFileDescriptor(parent : FileDescriptor, name : String) -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

    /**
       Returns a reference to the cache folder for the current application.
This path must always be writable by the current application.
This path is volatile and may be cleaned by the OS periodically.

       @return Path to the application's cache folder.
       @since ARP1.0
    */
    public func getApplicationCacheFolder() -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

    /**
       Returns a reference to the cloud synchronizable folder for the current application.
This path must always be writable by the current application.

       @return Path to the application's cloud storage folder.
       @since ARP1.0
    */
    public func getApplicationCloudFolder() -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

    /**
       Returns a reference to the documents folder for the current application.
This path must always be writable by the current application.

       @return Path to the application's documents folder.
       @since ARP1.0
    */
    public func getApplicationDocumentsFolder() -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

    /**
       Returns a reference to the application installation folder.
This path may or may not be directly readable or writable - it usually contains the app binary and data.

       @return Path to the application folder.
       @since ARP1.0
    */
    public func getApplicationFolder() -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

    /**
       Returns a reference to the protected storage folder for the current application.
This path must always be writable by the current application.

       @return Path to the application's protected storage folder.
       @since ARP1.0
    */
    public func getApplicationProtectedFolder() -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

    /**
       Returns the file system dependent file separator.

       @return char with the directory/file separator.
       @since ARP1.0
    */
    public func getSeparator() -> Character? {
        var response : Character
        // TODO: Not implemented.
        return " "
    }

    /**
       Returns a reference to the external storage folder provided by the OS. This may
be an external SSD card or similar. This type of storage is removable and by
definition, not secure.
This path may or may not be writable by the current application.

       @return Path to the application's documents folder.
       @since ARP1.0
    */
    public func getSystemExternalFolder() -> FileDescriptor? {
        var response : FileDescriptor
        // TODO: Not implemented.
        return FileDescriptor()
    }

}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
