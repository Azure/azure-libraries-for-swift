import XCTest
import Foundation
import azureSwiftRuntime
import storage

struct DataSize {
    static let b = 1
    static let kb = b << 10
    static let mb = kb * kb
    static let gb = mb * mb
    static let tb = gb * gb
    static let blobMaxLimit = 256 * mb
}

struct RangeBuilder {
    let size: Int
    let step: Int
    
    private var beg = 0
    
    init (size: Int, step: Int) {
        self.size = size
        self.step = step
    }
    
    func hasNext() -> Bool {
        return self.beg < self.size
    }
    
    mutating func next() -> (String, Int, Int) {
        var range = String()
        var first = 0
        var last = 0
        if hasNext() {
            let end = self.beg + self.step - 1
            if end >= self.size {
                range = "bytes=\(self.beg)-"
                first = self.beg
                last = self.size - 1
            } else {
                range =  ("bytes=\(self.beg)-\(end)")
                first = self.beg
                last = end
            }
            
            self.beg = end + 1
        }
        
        return (range, first, last)
    }
}

public class BlobCommandTests : StorageTestsBase {
    
    func test_BlobsPut() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command = storage.Commands.Blobs.Put(
            azureStorageKey: self.azureStorageKey,
            accountName: "storageswifttest1",
            container: "container1",
            blob: "helloworld")
        command.blobType = "BlockBlob"
        command.optionalbody = Data("This is my text file! Hello world!".utf8)
        
        command.execute(client: self.azureClient) {
            (error) in
            defer { e.fulfill() }
            if let e = error,
                let azureError = AzureStorageDecoder.decode(error: e) {
                print("=== AzureError:", azureError.message)
            }
            
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_BlobsGetProperties() {
        let blobName = "bytes256mb"
        let accountName = "storageswifttest1"
        let container = "container1"
        
        let e = self.expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Commands.Blobs.GetProperties(azureStorageKey: self.azureStorageKey, accountName: accountName, container: container, blob: blobName)
        
        cmd.execute(client: self.azureClient) {
            (res, error) in
            defer { e.fulfill() }
            
            if let e = error {
                if let azureError = AzureStorageDecoder.decode(error: e) {
                    print("=== AzureError:", azureError.message)
                    XCTFail(azureError.message)
                } else {
                    print ("=== Error:", e)
                    XCTFail(e.localizedDescription)
                }
            }
            
            guard let blobProperties = res else {
                XCTFail("nil result")
                return
            }
            
            print("=== props:", blobProperties)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    let helloString = "Hello world!"
    let byeString = "Bye world."
    
    func test_BlobsPutBytes() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command =
            storage.Commands.Blobs.Put(
                azureStorageKey: self.azureStorageKey,
                accountName: "storageswifttest1",
                container: "container1",
                blob: "bytes256mb")
        
        command.blobType = "BlockBlob"
        
        var testBytes = [UInt8]()
        let helloBytes = helloString.data(using: .utf8)!.bytes
        let byeBytes = byeString.data(using: .utf8)!.bytes
        let bytes = [UInt8](repeating: 0x01, count: 256 * DataSize.mb - helloBytes.count - byeBytes.count)
        
        testBytes.append(contentsOf: helloBytes)
        testBytes.append(contentsOf: bytes)
        testBytes.append(contentsOf: byeBytes)
        
        command.optionalbody = Data(bytes: testBytes)
        
        command.execute(client: self.azureClient) {
            (error) in
            defer { e.fulfill() }
            if let e = error,
                let azureError = AzureStorageDecoder.decode(error: e) {
                print("=== AzureError:", azureError.message)
            }
            
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_BlobsGetBytesInParallel() {
        
        let blobName = "bytes256mb"
        let accountName = "storageswifttest1"
        let container = "container1"
        
        let cmd = Commands.Blobs.GetProperties(azureStorageKey: self.azureStorageKey, accountName: accountName, container: container, blob: blobName)
        guard let bp = try? cmd.execute(client: self.azureClient) else {
            XCTFail("nil result")
            return
        }
        
        let blobLength = bp.contentLength
        let readRange = 32 * DataSize.mb
        let threadsQnty = 8
        
        XCTAssertTrue(blobLength > readRange)
        XCTAssertTrue(blobLength/readRange <= threadsQnty)
        
        
        var rb = RangeBuilder(size: blobLength, step: readRange)
        var map = [Int:Data]()
        
        var exp = [XCTestExpectation]()
        
        for i in 0 ..< threadsQnty {
            
            if !rb.hasNext() {
                break
            }
            
            let (range, first, last) = rb.next()
            let e = self.expectation(description: "Wait for HTTP request to complete")
            exp.append(e)
            
            let worker = DispatchQueue(label: "com.azure.storage #\(i)", qos: .userInitiated)
            
            worker.async {
                var command =
                    storage.Commands.Blobs.Get(
                        azureStorageKey: self.azureStorageKey,
                        accountName: "storageswifttest1",
                        container: "container1",
                        blob: blobName)
                
                command.range = range
                
                command.execute(client: self.azureClient) {
                    (result, error) in
                    defer { e.fulfill() }
                    
                    if let e = error {
                        if let azureError = AzureStorageDecoder.decode(error: e) {
                            print("=== AzureError:", azureError.message)
                            XCTFail(azureError.message)
                        } else {
                            print ("=== Error:", e)
                            XCTFail(e.localizedDescription)
                        }
                    }
                    
                    if let data = result {
                        map[first] = data
                    }
                    
                }
            }
        }
        
        self.wait(for: exp, timeout: self.timeout, enforceOrder: false)
        
        var resultData = Data()
        let sortedKeys = Array(map.keys).sorted{$0<$1}
        for key in sortedKeys {
            resultData.append(map[key]!)
        }
        
        XCTAssertEqual(blobLength, resultData.bytes.count)

        let helloSize = helloString.data(using: .utf8)!.bytes.count
        let helloData = resultData[0..<helloSize]
        let receivedHelloString = String(data: helloData, encoding: .utf8)
        print("=== receivedHelloString", receivedHelloString!)
        
        let byeSize = byeString.data(using: .utf8)!.bytes.count
        let byeStartIndex = blobLength - byeSize
        let byeData = resultData[byeStartIndex..<blobLength]
        let receivedByeString = String(data: byeData, encoding: .utf8)
        print("=== receivedByeString", receivedByeString!)
    }
    
    func test_BlobsGetBytes() {
        let e = expectation(description: "Wait for HTTP request to complete")
        
        var command =
            storage.Commands.Blobs.Get (
                azureStorageKey: self.azureStorageKey,
                accountName: "storageswifttest1",
                container: "container1",
                blob: "helloworld")
        
        command.execute(client: self.azureClient) {
            (result, error) in
            defer { e.fulfill() }
            if let e = error,
                let azureError = AzureStorageDecoder.decode(error: e) {
                print("=== AzureError:", azureError.message)
            }
            
            if let e = error {
                if let azureError = AzureStorageDecoder.decode(error: e) {
                    print("=== AzureError:", azureError.message)
                    XCTFail(azureError.message)
                } else {
                    print ("=== Error:", e)
                    XCTFail(e.localizedDescription)
                }
            }
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
