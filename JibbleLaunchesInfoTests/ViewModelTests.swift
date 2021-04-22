//
//  ViewModel.swift
//  JibbleLaunchesInfoTests
//
//  Created by zip520123 on 13/04/2021.
//

import XCTest
import RxSwift
@testable import JibbleLaunchesInfo
class ViewModelTests: XCTestCase {
    
    func test_viewModel_initStatus_hasOneEmptyArray() {
        let sut = makeSUT()
        let spy = StateSpy(sut)
        
        XCTAssertEqual(spy.launches.count, 1)
    }
    
    func test_viewModel_fetchData_hasTwoArray() {
        let sut = makeSUT()
        let spy = StateSpy(sut)
        sut.fetchData()
        XCTAssertEqual(spy.launches.count, 2)
    }
    
    func test_viewModel_fetchData_getOneLaunchDataFromSecondArray() {
        let sut = makeSUT()
        let spy = StateSpy(sut)
        sut.fetchData()
        
        XCTAssertEqual("Starlink-23 (v1.0)", spy.launches[1][0].name)
    }
    
    func test_viewModel_fetchData_selectOneLaunch() {
        let sut = makeSUT()
        let spy = StateSpy(sut)
        sut.fetchData()
        let launch = spy.launches[1][0]
        sut.didSelectLaunch.accept(launch)
        XCTAssertEqual(spy.didSelectLaunch.count, 1)
    }
    
    func test_viewModel_clickLink() {
        let sut = makeSUT()
        let spy = StateSpy(sut)
        
        sut.didSelectURLString.accept("someURL")
        XCTAssertEqual(spy.didSelectURLString[0], "someURL")
        
    }
    
    class StateSpy {
        let disposeBag = DisposeBag()
        private(set) var launches: [[Launch]] = []
        private(set) var didSelectLaunch: [Launch] = []
        private(set) var didSelectURLString: [String] = []
        init(_ viewModel: ViewModel) {
            viewModel.launches.subscribe {[weak self] (launches) in
                self?.launches.append(launches)
            }.disposed(by: disposeBag)
            
            viewModel.didSelectLaunch.subscribe {[weak self] (launch) in
                self?.didSelectLaunch.append(launch)
            }.disposed(by: disposeBag)
            
            viewModel.didSelectURLString.subscribe {[weak self] (s) in
                self?.didSelectURLString.append(s)
            }.disposed(by: disposeBag)

        }
    }
    

    
    func makeSUT(_ service: ServiceType = MockService()) -> ViewModel {
        return ViewModel(service)
    }
    
}


