import UIKit
import Foundation
import PureLayout

class RootViewController: UITabBarController {
    let helloVC = HelloWorldViewController()
    let searchVC = RxSearchBarController()

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
        let searchNC = UINavigationController(rootViewController: searchVC)

        let tabs = [helloNC, searchNC]

        self.setViewControllers(tabs, animated: false)
    }
}

extension RootViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (tabBarController.selectedIndex == 0) {
            print("[Info] tap TabBarItem HelloWorld")
        } else if(tabBarController.selectedIndex == 1) {
            print("[Info] tap TabBarItem Search")
        }
    }
}
