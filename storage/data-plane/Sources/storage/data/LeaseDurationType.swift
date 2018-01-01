// LeaseDurationType enumerates the values for lease duration type.

public enum LeaseDurationType: String, Codable
{
// Fixed specifies the fixed state for lease duration type.
    case Fixed = "fixed"
// Infinite specifies the infinite state for lease duration type.
    case Infinite = "infinite"
}
