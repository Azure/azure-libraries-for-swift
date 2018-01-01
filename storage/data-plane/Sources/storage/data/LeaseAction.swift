// LeaseAction enumerates the values for lease action.

public enum LeaseAction: String, Codable
{
// Acquire specifies the acquire state for lease action.
    case Acquire = "acquire"
// Break specifies the break state for lease action.
    case Break = "break"
// Change specifies the change state for lease action.
    case Change = "change"
// Release specifies the release state for lease action.
    case Release = "release"
// Renew specifies the renew state for lease action.
    case Renew = "renew"
}
