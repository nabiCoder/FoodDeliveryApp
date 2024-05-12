import UIKit

class AppCoordinator: Coordinator {
    
    override func start() {
//        showOnboardingFlow()
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnboardingCoordinator(type: .onboarding,
                                                          navigationController: navigationController,
                                                          finishDelegate: self)
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home,
                                              navigationController: homeNavigationController,
                                              finishDelegate: self)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 0)
        addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
        
        let searchNavigationController = UINavigationController()
        let searchCoordinator = SearchCoordinator(type: .search,
                                                  navigationController: searchNavigationController,
                                                  finishDelegate: self)
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 1)
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        let ordersNavigationController = UINavigationController()
        let ordersCoordinator = OrdersCoordinator(type: .orders,
                                                  navigationController: ordersNavigationController,
                                                  finishDelegate: self)
        ordersNavigationController.tabBarItem = UITabBarItem(title: "Orders",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 2)
        addChildCoordinator(ordersCoordinator)
        ordersCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile,
                                                    navigationController: profileNavigationController,
                                                    finishDelegate: self)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 3)
        addChildCoordinator(profileCoordinator)
        profileCoordinator.start()
        
        let tabBarControllers = [homeNavigationController,
                                 searchNavigationController,
                                 ordersNavigationController,
                                 profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .app:
            return
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}
