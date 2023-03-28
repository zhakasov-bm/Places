//
//  Extension + UIView.swift
//  Places
//
//  Created by Bekzhan on 09.12.2022.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                             = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive           = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive   = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}
