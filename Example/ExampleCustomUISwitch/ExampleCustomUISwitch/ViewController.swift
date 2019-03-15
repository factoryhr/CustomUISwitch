//
//  ViewController.swift
//  ExampleCustomUISwitch
//
//  Created by Luka Lovretić on 15/03/2019.
//  Copyright © 2019 BlueFactory. All rights reserved.
//

import UIKit
import CustomUISwitch

class ViewController: UIViewController {
    var customSwitch: CustomSwitch = {
        let customSwitch = CustomSwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = UIColor.orange
        customSwitch.offTintColor = UIColor.darkGray
        customSwitch.cornerRadius = 0.1
        customSwitch.thumbCornerRadius = 0.1
        customSwitch.thumbTintColor = UIColor.white
        customSwitch.animationDuration = 0.25
        return customSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(customSwitch)
        setupConstraints()
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            customSwitch.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            customSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            customSwitch.widthAnchor.constraint(equalToConstant: 80),
            customSwitch.heightAnchor.constraint(equalToConstant: 30)])
    }


}

