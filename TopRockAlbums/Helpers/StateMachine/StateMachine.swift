//
//  StateMachine.swift
//  TopRockAlbums
//
//  Created by acon on 22/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class StateMachine {
    private var dict: [String: UIViewController] = [:]
    enum State: Equatable {
        case error(error: Error)
        case loading
        case ready
        
        var key: String {
            switch(self) {
            case .error(_):
                return "error"
            case .loading:
                return "loading"
            case .ready:
                return "ready"
            }
        }
        
        static func ==(lhs: State, rhs: State) -> Bool {
            return lhs.key == rhs.key
        }
    }
    var state: State = .loading {
        didSet {
            dict.values.forEach { remove(vc: $0) }
            let vc = dict[state.key]
            switch state {
            case .error(let error):
                if let vc = vc as? ErrorViewController {
                    vc.viewModel = ErrorViewController.ViewModel(errorMessage: "\(error.localizedDescription)")
                }
            default:
                break
            }
            add(vc: vc)
            didChanged?(state)
        }
    }
    var didChanged: ((_ state: State)->Void)?
    weak var mainVc: UIViewController!
    
    init(vc: UIViewController) {
        self.mainVc = vc
        dict["error"] = ErrorViewController()
        dict["loading"] = LoadingViewController()
    }
    
    func add(vc: UIViewController?) {
        guard let vc = vc else { return }
        mainVc.addChild(vc)
        mainVc.view.addSubview(vc.view)
        mainVc.didMove(toParent: vc)
    }
    
    func remove(vc: UIViewController?) {
        guard let vc = vc else { return }
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}
