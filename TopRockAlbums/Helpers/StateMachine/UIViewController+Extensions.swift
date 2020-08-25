//
//  UIViewController+Extensions.swift
//  TopRockAlbums
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController{

    func insertViewController(activeVC:UIViewController, childContainerView:UIView){
        addChild(activeVC)
        activeVC.view.translatesAutoresizingMaskIntoConstraints = false
        childContainerView.addSubview(activeVC.view)
        activeVC.view.leadingAnchor.constraint(equalTo: childContainerView.leadingAnchor).isActive = true
        activeVC.view.trailingAnchor.constraint(equalTo: childContainerView.trailingAnchor).isActive = true
        activeVC.view.topAnchor.constraint(equalTo: childContainerView.topAnchor).isActive = true
        activeVC.view.bottomAnchor.constraint(equalTo: childContainerView.bottomAnchor).isActive = true
        activeVC.didMove(toParent: self)
    }
}
