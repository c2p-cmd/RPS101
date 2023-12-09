//
//  FileService.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import Foundation

class FileService {
    static let shared: FileService = FileService()
    
    private init() { }
    
    func loadData() throws -> [RPSObject] {
        let fileManager: FileManager = .default
        
        guard let bundle = Bundle.main.resourcePath else {
            throw GameError.notFound
        }
        
        let contents: [String] = try fileManager.contentsOfDirectory(atPath: bundle)
        let dataList = contents.filter(filterToJson).map(nameToURL)
        
        let objectList: [RPSObject] = try dataList.map(fileURLToObject)
        
        return objectList.sorted { object1, object2 in
            object1.name < object2.name
        }
    }
    
    // closures for helping
    private let filterToJson: (String) -> Bool = { $0.hasSuffix(".json") }
    
    private let nameToURL: (String) -> URL = { Bundle.main.bundleURL.appending(path: $0) }
    
    private let fileURLToObject: (URL) throws -> RPSObject = { fileUrl in
        let data = try Data(contentsOf: fileUrl)
        return try JSONDecoder().decode(RPSObject.self, from: data)
    }
}
