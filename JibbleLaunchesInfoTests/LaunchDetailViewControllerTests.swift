//
//  LaunchDetailViewControllerTests.swift
//  JibbleLaunchesInfoTests
//
//  Created by zip520123 on 14/04/2021.
//

import XCTest
@testable import JibbleLaunchesInfo
class LaunchDetailViewControllerTests: XCTestCase {
    
    func test_viewDidLoad_launchDetailInfo() throws {
        let input = try XCTUnwrap(readString(from: "latest.json").data(using: .utf8), "Fail to read json file.")
        let model = try XCTUnwrap(ISO8601JSONDecoder().decode(Launch.self, from: input))
        let sut = LaunchDetailViewController(model, viewModel: ViewModel(MockService()))
        _ = sut.view
        XCTAssertEqual(sut.nameLabel.text, "Starlink-23 (v1.0)")
    }
    
    func readString(from file: String) throws -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: file, withExtension: nil)!
        let data = try Data(contentsOf: path)
        return String(data: data, encoding: .utf8)!
    }
}
