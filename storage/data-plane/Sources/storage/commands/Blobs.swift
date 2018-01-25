// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.

// Blobs is the client for the Blobs methods of the AzureBlobStorage service.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Blobs {
    public static func AbortCopy(accountName: String, container: String, blob: String, copyId: String, comp: String) -> BlobsAbortCopy {
        return AbortCopyCommand(accountName: accountName, container: container, blob: blob, copyId: copyId, comp: comp)
    }
    public static func AppendBlock(accountName: String, container: String, blob: String, comp: String, _body: Data) -> BlobsAppendBlock {
        return AppendBlockCommand(accountName: accountName, container: container, blob: blob, comp: comp, _body: _body)
    }
    public static func Copy(accountName: String, container: String, blob: String) -> BlobsCopy {
        return CopyCommand(accountName: accountName, container: container, blob: blob)
    }
    public static func Delete(accountName: String, container: String, blob: String) -> BlobsDelete {
        return DeleteCommand(accountName: accountName, container: container, blob: blob)
    }
    public static func Get(azureStorageKey: String, accountName: String, container: String, blob: String) -> BlobsGet {
        return GetCommand(azureStorageKey: azureStorageKey, accountName: accountName, container: container, blob: blob)
    }
    public static func GetMetadata(accountName: String, container: String, blob: String, comp: String) -> BlobsGetMetadata {
        return GetMetadataCommand(accountName: accountName, container: container, blob: blob, comp: comp)
    }
    public static func GetProperties(azureStorageKey: String, accountName: String, container: String, blob: String) -> BlobsGetProperties {
        return GetPropertiesCommand(azureStorageKey: azureStorageKey, accountName: accountName, container: container, blob: blob)
    }
    public static func Lease(accountName: String, container: String, blob: String, comp: String) -> BlobsLease {
        return LeaseCommand(accountName: accountName, container: container, blob: blob, comp: comp)
    }
    public static func Put(azureStorageKey: String, accountName: String, container: String, blob: String) -> BlobsPut {
        return PutCommand(azureStorageKey: azureStorageKey, accountName: accountName, container: container, blob: blob)
    }
    public static func SetMetadata(accountName: String, container: String, blob: String, comp: String) -> BlobsSetMetadata {
        return SetMetadataCommand(accountName: accountName, container: container, blob: blob, comp: comp)
    }
    public static func SetProperties(accountName: String, container: String, blob: String, comp: String) -> BlobsSetProperties {
        return SetPropertiesCommand(accountName: accountName, container: container, blob: blob, comp: comp)
    }
    public static func TakeSnapshot(accountName: String, container: String, blob: String, comp: String) -> BlobsTakeSnapshot {
        return TakeSnapshotCommand(accountName: accountName, container: container, blob: blob, comp: comp)
    }
}
}
