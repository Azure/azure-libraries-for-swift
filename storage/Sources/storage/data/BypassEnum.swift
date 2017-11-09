// BypassEnum enumerates the values for bypass enum.

public enum BypassEnum: String, Codable
{
// AzureServices specifies the azure services state for bypass enum.
    case AzureServices = "AzureServices"
// Logging specifies the logging state for bypass enum.
    case Logging = "Logging"
// Metrics specifies the metrics state for bypass enum.
    case Metrics = "Metrics"
// None specifies the none state for bypass enum.
    case None = "None"
}
