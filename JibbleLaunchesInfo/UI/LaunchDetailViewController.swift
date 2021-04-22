//
//  LaunchDetailViewController.swift
//  JibbleLaunchesInfo
//
//  Created by zip520123 on 14/04/2021.
//

import UIKit
import RxSwift
import Kingfisher
class LaunchDetailViewController: UIViewController {
    
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var linkLabel: UILabel!
    private var launch: Launch!
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    convenience init(_ launch: Launch, viewModel: ViewModel) {
        self.init(nibName: "LaunchDetailViewController", bundle: nil)
        self.launch = launch
        self.viewModel = viewModel

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = launch.name
        descriptionLabel.text = launch.details
        linkLabel.text = launch.links.wikipedia
        imageView.kf.indicatorType = .activity
        if let s = launch.links.patch.small, let url = URL(string: s) {
            imageView.kf.setImage(with: url, options: [
                                  .transition(.fade(0.2)),
                                  .backgroundDecode
                                  ])
        }
        rxBinding()
    }
    
    func rxBinding() {
        let gesture = UITapGestureRecognizer()
        gesture.rx.event.subscribe {[weak self] (_) in
            if let string = self?.linkLabel.text, let url = URL(string: string) {
                self?.viewModel.didSelectURLString.accept(string)
                UIApplication.shared.open(url)
            }
        }.disposed(by: disposeBag)
        
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(gesture)
    }
}
