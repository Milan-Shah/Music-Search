//
//  APIResources.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/2/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//
import Foundation

struct ApiWrapper {
    let results: [Serialization]
}

extension ApiWrapper {
    private enum Keys: String, SerializationKey {
        case results
    }
    
    init(serialization: Serialization) {
        results = serialization.value(forKey: Keys.results) ?? []
    }
}

protocol ApiResource {
    associatedtype Model
    //var methodPath: String {get}
    func makeModel(serialization: Serialization) -> Model
}

extension ApiResource {
    func makeModel(data: Data) -> [Model]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            return nil
        }
        guard let jsonSerialization = json as? Serialization else {
            return nil
        }
        
        let wrapper = ApiWrapper(serialization: jsonSerialization)
        return wrapper.results.map(makeModel(serialization:))
    }
}


struct TracksResource: ApiResource {
    let methodPath = ""
    func makeModel(serialization: Serialization) -> Track {
        return Track(serialization: serialization)
    }
}

