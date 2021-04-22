//
//  LaunchesViewController.swift
//  JibbleLaunchesInfo
//
//  Created by zip520123 on 13/04/2021.
//

import UIKit
import RxSwift

class LaunchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let disposeBag = DisposeBag()
    let tableView = UITableView()
    private var viewModel: ViewModel!
    convenience init(_ viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        rxBinding()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(LaunchTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func fetchData() {
        viewModel.fetchData()
    }
    
    private func rxBinding() {
        viewModel.launches.asDriver().drive {[weak self] (_) in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launches.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(LaunchTableViewCell.self)
        let launch = viewModel.launches.value[indexPath.row]
        cell?.setData(launch)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = viewModel.launches.value[indexPath.row]
        viewModel.didSelectLaunch.accept(launch)
    }
}

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
