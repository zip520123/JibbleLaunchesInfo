//
//  LaunchesViewControllerTests.swift
//  JibbleLaunchesInfoTests
//
//  Created by zip520123 on 13/04/2021.
//

import XCTest
import RxSwift
@testable import JibbleLaunchesInfo
class LaunchesViewControllerTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func test_viewDidLoad_fetchMockData_selectTableViewFirstCell() {
        let viewModel = ViewModel(MockService())
        let sut = makSUT(viewModel)
        
        _ = sut.view
        let except = expectation(description: "didSelectLaunch")
        viewModel.didSelectLaunch.subscribe { (launch) in
            except.fulfill()
        }.disposed(by: disposeBag)

        sut.tableView.select(at: 0)
        wait(for: [except], timeout: 1)
    }
    
    
    func test_viewDidLoad_fetchMockData_tableViewCelldataPresent() {
        let viewModel = ViewModel(MockService())
        let sut = makSUT(viewModel)
        
        _ = sut.view
        
        let cell = sut.tableView.cell(at: 0) as! LaunchTableViewCell
        XCTAssertEqual(cell.launchNumberLabel.text, "flightNumber: 122")
        
    }
    
    func makSUT(_ viewMode: ViewModel) -> LaunchesViewController {
        
        LaunchesViewController(viewMode)
    }
}
extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return self.cell(at: row)?.textLabel?.text
    }
    
    func select(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}
