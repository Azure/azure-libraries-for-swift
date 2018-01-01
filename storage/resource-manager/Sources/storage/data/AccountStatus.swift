// AccountStatus enumerates the values for account status.

public enum AccountStatus: String, Codable
{
// Available specifies the available state for account status.
    case Available = "available"
// Unavailable specifies the unavailable state for account status.
    case Unavailable = "unavailable"
}
