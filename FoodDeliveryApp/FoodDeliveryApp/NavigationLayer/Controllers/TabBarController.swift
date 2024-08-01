import UIKit

class TabBarController: UITabBarController {
    
    private var additionalImageView: UIImageView?
    // MARK: - Init
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tabBarController in tabBarControllers {
            self.addChild(tabBarController)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if tabBar.tag == 0 {
            showAdditionalImage(for: 0)
        }
    }
    // MARK: - Private methods
    private func setupTabBar() {
        tabBar.backgroundColor = AppColors.backgroundWhiteColor
        tabBar.tintColor = AppColors.activeOrangeColor
    }
    
    private func showAdditionalImage(for tabIndex: Int) {
        // Удаляем предыдущую дополнительную картинку, если она существует
        additionalImageView?.removeFromSuperview()
        // Создаем новую дополнительную картинку
        additionalImageView = UIImageView(image: UIImage(resource: .active))
        additionalImageView?.frame = CGRect(x: 0, y: 0, width: 14, height: 20) // Настройте размеры
        // Устанавливаем позицию дополнительной картинки в зависимости от выбранного таба
        if let tabBarItems = tabBar.items {
            let tabWidth = tabBar.frame.width / CGFloat(tabBarItems.count)
            let xPosition = CGFloat(tabIndex) * tabWidth + (tabWidth / 2) - (additionalImageView?.frame.width ?? 0) / 2
            let yPosition = tabBar.frame.origin.y + 15 // Позиция над таббаром
            
            additionalImageView?.center = CGPoint(x: xPosition, y: yPosition)
            
            if let additionalImageView = additionalImageView {
                view.addSubview(additionalImageView)
            }
        }
    }
}
// MARK: - TabBar Delegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let tabIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            showAdditionalImage(for: tabIndex)
        }
    }
}
