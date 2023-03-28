//
//  EditVC.swift
//  Places
//
//  Created by Bekzhan on 15.12.2022.
//

import UIKit

class EditVC: UIViewController {

    var titleTextField = UITextField()
    
    var subtitleTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleTextField()
        configureSubtitleTextField()
        
        view.backgroundColor = .systemCyan
        // Do any additional setup after loading the view.
    }
    
    func configureTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.placeholder = "Enter title"
        titleTextField.borderStyle = .roundedRect
        setTitleConstraint()
        
    }
    
    func configureSubtitleTextField() {
        view.addSubview(subtitleTextField)
        subtitleTextField.placeholder = "Enter subtitle"
        subtitleTextField.borderStyle = .roundedRect
        setSubtitleConstraint()
    }
    
    func setTitleConstraint() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            titleTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setSubtitleConstraint() {
        subtitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitleTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50),
            subtitleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleTextField.heightAnchor.constraint(equalToConstant: 50),
            subtitleTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
