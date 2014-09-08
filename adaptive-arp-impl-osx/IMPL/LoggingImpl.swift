import Foundation

class LoggingImpl : ILogging {
    
    func log(level : ILoggingLogLevel, message : String) {
        log(level, category: "GENERAL", message: message);
    }
    
    func log(level : ILoggingLogLevel, category : String, message : String) {
        if (level == ILoggingLogLevel.DEBUG) {
            #if DEBUG
            println("DEBUG - "+category+": "+message)
            #endif
        } else if (level == ILoggingLogLevel.ERROR) {
            println("ERROR - "+category+": "+message)
        } else if (level == ILoggingLogLevel.WARN) {
            println("WARN - "+category+": "+message)
        } else {
            println("INFO - "+category+": "+message)
        }
    }
    
}