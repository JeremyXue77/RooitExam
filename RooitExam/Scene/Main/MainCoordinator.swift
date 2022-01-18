//
//  MainCoordinator.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = NewsViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
