//
//  File.swift
//  storage
//
//  Created by Vladimir Shcherbakov on 1/24/18.
//
import Foundation
import azureSwiftRuntime

public protocol StorageRuntimeClient {
    func executeHead<T:Decodable> (command: BaseCommand) throws -> T
    func executeAsyncHead<T:Decodable> (command: BaseCommand, completionHandler: @escaping (T?, Error?) -> Void )
}

extension AzureClient:  StorageRuntimeClient {
    public func executeAsyncHead<T:Decodable> (command: BaseCommand, completionHandler: @escaping (T?, Error?) -> Void ) {
        self.createExecuteObservable(command: command)
            .subscribe (
                onNext: { (httpResponse, data) in
                    let headers = httpResponse.allHeaderFields as! [String:String]
                    let res = try? HeadersDecoder().decode(T.self, from: headers)
                    completionHandler(res, nil)
                },
                onError: { error in
                    completionHandler(nil,error)
                }
            ).disposed(by: disposeBag)
    }
    
    public func executeHead<T:Decodable> (command: BaseCommand) throws -> T {
        guard let (httpResponse, _) = try self.createExecuteObservable(command: command).toBlocking().single() else {
            throw RuntimeError.general(message: "AzureClient.executeHead returned nil")
        }
        let headers = httpResponse.allHeaderFields as! [String:String]
        let res = try HeadersDecoder().decode(T.self, from: headers)
        return res
    }
}
