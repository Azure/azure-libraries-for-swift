// SequenceNumberAction enumerates the values for sequence number action.

public enum SequenceNumberAction: String, Codable
{
// SequenceNumberActionIncrement specifies the sequence number action increment state for sequence number action.
    case SequenceNumberActionIncrement = "increment"
// SequenceNumberActionMax specifies the sequence number action max state for sequence number action.
    case SequenceNumberActionMax = "max"
// SequenceNumberActionUpdate specifies the sequence number action update state for sequence number action.
    case SequenceNumberActionUpdate = "update"
}
