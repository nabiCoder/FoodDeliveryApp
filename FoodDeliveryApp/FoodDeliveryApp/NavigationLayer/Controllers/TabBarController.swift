import UIKit

class TabBarController: UITabBarController {
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tabBarController in tabBarControllers {
            self.addChild(tabBarController)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = AppColors.backgroundWhiteColor
        tabBar.tintColor = AppColors.activeOrangeColor
//        tabBar.selectedItem?.image = UIImage(systemName: "star")
    }
}
