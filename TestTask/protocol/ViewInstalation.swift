//
//  ViewInstalation.swift
//  PlayMap
//
//  Created by Adilbek Mailanov on 5/11/19.
//  Copyright © 2019 Adilbek Mailanov. All rights reserved.
//

import Foundation

protocol ViewInstalation {
    func addSubviews()
    func addConstraints()
    func stylizeViews()
}

extension ViewInstalation {
    func setupViews() {
        addSubviews()
        addConstraints()
        stylizeViews()
    }
}
