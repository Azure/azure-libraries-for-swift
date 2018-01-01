// Bypass enumerates the values for bypass.

public enum Bypass: String, Codable
{
// AzureServices specifies the azure services state for bypass.
    case AzureServices = "AzureServices"
// Logging specifies the logging state for bypass.
    case Logging = "Logging"
// Metrics specifies the metrics state for bypass.
    case Metrics = "Metrics"
// None specifies the none state for bypass.
    case None = "None"
}
