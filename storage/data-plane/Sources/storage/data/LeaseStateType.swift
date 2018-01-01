// LeaseStateType enumerates the values for lease state type.

public enum LeaseStateType: String, Codable
{
// Available specifies the available state for lease state type.
    case Available = "available"
// Breaking specifies the breaking state for lease state type.
    case Breaking = "breaking"
// Broken specifies the broken state for lease state type.
    case Broken = "broken"
// Expired specifies the expired state for lease state type.
    case Expired = "expired"
// Leased specifies the leased state for lease state type.
    case Leased = "leased"
}
