//
//  ViewModel.swift
//  JibbleLaunchesInfo
//
//  Created by zip520123 on 13/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    let launches: BehaviorRelay<[Launch]>
    let didSelectLaunch: PublishRelay<Launch>
    let didSelectURLString: PublishRelay<String>
    let service: ServiceType
    init(_ service: ServiceType) {
        self.service = service
        launches = BehaviorRelay<[Launch]>(value: [])
        didSelectLaunch = PublishRelay<Launch>()
        didSelectURLString = PublishRelay<String>()
    }
    
    func fetchData() {
        service.getLaunches { [weak self] (launches, error) in
            if error != nil {
                print(error)
            } else {
                if let last3YearsLaunches = self?.filterForlast3Years(launches) {
                    
                    func sortedLaunchByDescendingOrder(_ launch1: Launch, _ launch2: Launch) -> Bool {
                        return launch1.dateLocal > launch2.dateLocal
                    }
                    
                    self?.launches.accept(last3YearsLaunches.sorted(by: sortedLaunchByDescendingOrder))
                }
            }
        }
    }
    
    func filterForlast3Years(_ launches: [Launch]) -> [Launch] {
        launches.filter { (launch) -> Bool in
            let now = Date()
            let year = 3
            let days = 365
            let hour = 24
            let minutes = 60
            let second = 60
            let before3year = now.addingTimeInterval(TimeInterval( -year * days * hour * minutes * second))
            
            return launch.dateLocal.timeIntervalSinceNow > before3year.timeIntervalSinceNow
        }
        
    }

}
