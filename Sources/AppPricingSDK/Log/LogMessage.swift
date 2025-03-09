public enum LogMessage {
    case info(message: String)
    case error(message: String, error: Error)
}
