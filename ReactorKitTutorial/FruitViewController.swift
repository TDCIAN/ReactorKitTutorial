//
//  ViewController.swift
//  ReactorKitTutorial
//
//  Created by JeongminKim on 2022/04/11.
//

import UIKit

class FruitViewController: UIViewController {
    
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
        label.text = "선택되어진 과일 없음"
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
        // Do any additional setup after loading the view.
    }

    func configureUI() {
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

