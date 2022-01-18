//
//  Coordinator.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
