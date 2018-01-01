// UsageUnit enumerates the values for usage unit.

public enum UsageUnit: String, Codable
{
// Bytes specifies the bytes state for usage unit.
    case Bytes = "Bytes"
// BytesPerSecond specifies the bytes per second state for usage unit.
    case BytesPerSecond = "BytesPerSecond"
// Count specifies the count state for usage unit.
    case Count = "Count"
// CountsPerSecond specifies the counts per second state for usage unit.
    case CountsPerSecond = "CountsPerSecond"
// Percent specifies the percent state for usage unit.
    case Percent = "Percent"
// Seconds specifies the seconds state for usage unit.
    case Seconds = "Seconds"
}
