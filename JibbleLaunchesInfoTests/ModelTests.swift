//
//  ModelTests.swift
//  JibbleLaunchesInfoTests
//
//  Created by zip520123 on 13/04/2021.
//

import XCTest
import Foundation
@testable import JibbleLaunchesInfo
class ModelTests: XCTestCase {
    
    func test_modelDecode() throws {
        let input = try XCTUnwrap(readString(from: "latest.json").data(using: .utf8), "Fail to read json file.")
        let model = try XCTUnwrap(ISO8601JSONDecoder().decode(Launch.self, from: input))
        
        XCTAssertEqual("Starlink-23 (v1.0)", model.name)
    }
    
    
    func readString(from file: String) throws -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: file, withExtension: nil)!
        let data = try Data(contentsOf: path)
        return String(data: data, encoding: .utf8)!
    }
}


class MockData {
    func mockLaunch() throws -> Launch {
        let input = try XCTUnwrap(readString(from: "latest.json").data(using: .utf8), "Fail to read json file.")
        let model = try XCTUnwrap(ISO8601JSONDecoder().decode(Launch.self, from: input))
        return model
    }
    
    func readString(from file: String) throws -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: file, withExtension: nil)!
        let data = try Data(contentsOf: path)
        return String(data: data, encoding: .utf8)!
    }
}
