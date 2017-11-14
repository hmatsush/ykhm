import UIKit
import Foundation
import PureLayout

class RootViewController: UITabBarController {
    let helloVC = HelloWorldViewController()

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        let helloNC = UINavigationController(rootViewController: helloVC)

        let tabs = [helloNC]

        self.setViewControllers(tabs, animated: false)
    }
}

extension RootViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (tabBarController.selectedIndex == 0) {
            print("[Info] tap TabBarItem HomeViewController")
        } else if(tabBarController.selectedIndex == 1) {
            print("[Info] tap TabBarItem SearchViewController")
        } else if(tabBarController.selectedIndex == 2) {
            print("[Info] tap TabBarItem CreateViewController")
        }
    }
}
