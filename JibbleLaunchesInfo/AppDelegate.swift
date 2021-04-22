//
//  AppDelegate.swift
//  JibbleLaunchesInfo
//
//  Created by zip520123 on 13/04/2021.
//

import UIKit
import RxSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let viewModel: ViewModel
    let coordinator: UINavigationController
    let disposeBag = DisposeBag()
    
    override init() {
        viewModel = ViewModel(ApiService())
        let vc = LaunchesViewController(viewModel)
        coordinator = UINavigationController(rootViewController: vc)
        super.init()
        
        rxBinding()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator
        window?.makeKeyAndVisible()
        return true
    }

    func rxBinding() {
        viewModel.didSelectLaunch.subscribe(onNext: {[weak self] (launch) in
            guard let self = self else {return}
            self.coordinator.pushViewController(LaunchDetailViewController(launch, viewModel: self.viewModel), animated: true)
        }).disposed(by: disposeBag)

    }
}

