//
//  Service.swift
//  JibbleLaunchesInfo
//
//  Created by zip520123 on 13/04/2021.
//

import Foundation
enum ServiceError: Error {
    case urlIsNil
    case readFileFail
    case decodeError
}

protocol ServiceType {
    func getLaunches(completionHandler: @escaping ([Launch], Error?) -> Void)
}

struct ApiService: ServiceType {
    public let session: URLSession
    public let scheme = "https"
    public let host = "api.spacexdata.com"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    private func defualtURLComponets() -> URLComponents {
        var urlc = URLComponents()
        urlc.host = host
        urlc.scheme = scheme
        return urlc
    }
    
    func getLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        var urlc = defualtURLComponets()
        urlc.path = "/v4/launches"

        guard let url = urlc.url else {
            completionHandler([], ServiceError.urlIsNil)
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler([], error)
                return
            }
            guard let data = data, let model = try? ISO8601JSONDecoder().decode([Launch].self, from: data) else {
                completionHandler([], ServiceError.decodeError)
                return
            }
            completionHandler(model, nil)
        }

        task.resume()

    }
}
class MockService: ServiceType {
    func getLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        let input = try! readString(from: "latest.json").data(using: .utf8)
        let model = try! ISO8601JSONDecoder().decode(Launch.self, from: input!)
        completionHandler([model], nil)
        
    }
    func readString(from file: String) throws -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: file, withExtension: nil)!
        let data = try Data(contentsOf: path)
        return String(data: data, encoding: .utf8)!
    }
}

