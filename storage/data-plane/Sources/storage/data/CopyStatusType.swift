// CopyStatusType enumerates the values for copy status type.

public enum CopyStatusType: String, Codable
{
// Aborted specifies the aborted state for copy status type.
    case Aborted = "aborted"
// Failed specifies the failed state for copy status type.
    case Failed = "failed"
// Pending specifies the pending state for copy status type.
    case Pending = "pending"
// Success specifies the success state for copy status type.
    case Success = "success"
}
