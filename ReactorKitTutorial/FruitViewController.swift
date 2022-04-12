//
//  ViewController.swift
//  ReactorKitTutorial
//
//  Created by JeongminKim on 2022/04/11.
//

import UIKit
import ReactorKit
import RxCocoa

class FruitViewController: UIViewController {
    let disposeBag = DisposeBag()
    let fruitReactor = FruitReactor()
    
    // MARK: Properties
    private lazy var appleButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("사과", for: .normal)
        return button
    }()
    
    private lazy var bananaButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("바나나", for: .normal)
        return button
    }()
    
    private lazy var grapeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("포도", for: .normal)
        return button
    }()
    
    private lazy var selectedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            appleButton, bananaButton, grapeButton, selectedLabel
        ])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(reactor: fruitReactor)
    }

    func configureUI() {
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: Helpers
    func bind(reactor: FruitReactor) {
        appleButton.rx.tap.map { return FruitReactor.Action.apple }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bananaButton.rx.tap.map { return FruitReactor.Action.banana }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        grapeButton.rx.tap.map { return FruitReactor.Action.grapes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.fruitName }
        .distinctUntilChanged()
        .map { $0 }
        .subscribe(onNext: { value in
            self.selectedLabel.text = value
        })
        .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .map { $0 }
        .subscribe(onNext: { value in
            if value == true {
                self.selectedLabel.text = "로딩중입니다"
            }
        })
        .disposed(by: disposeBag)
    }
}

