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
        var json = try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers,.allowFragments])
        
        if (json == nil){
            let jsonString = (String(data: data, encoding: .utf8))!
            let jsCount : Int = jsonString.count
            let substring = jsonString[jsonString.index(of: "{")!..<jsonString.index(jsonString.index(of: "{")!, offsetBy: (jsCount - 7))] //7 Because thats the length count of "song = "
            var js = String(substring)
            js = js.replace(target: "'", withString: "\"")
            js = js.replace(target: "\n", withString: " ")
            
            var jsonDict: [String: Any] = [:]
            if let data : Data = js.data(using: .utf8, allowLossyConversion: false){
                do {
                    jsonDict = (try JSONSerialization.jsonObject(with: data, options:[.mutableContainers,.allowFragments]) as? [String: Any])!
                    var arrayObject: [Any] = []
                    arrayObject.append(jsonDict)
                    print("JSON DICT: \(arrayObject)")
                    
                    var dict : Dictionary <String, Any> = [:]
                    dict["results"] = arrayObject
                    print("Dict: \(dict)")
                    json = dict
                } catch {
                    print(error.localizedDescription)
                }
            }
            
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

struct LyricsResource: ApiResource {
    let methodPath = ""
    func makeModel(serialization: Serialization) -> Lyrics {
        return Lyrics(serialization: serialization)
    }
}

