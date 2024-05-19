import UIKit

struct SceneFactory {
    // MARK: - Onboarding
    static func makeOnboardingScene(coordinator: OnboardingCoordinator) -> OnboardingPageViewController {
        var pages = [UIViewController]()
        let firstVC = ReusableOnboardingViewController(onboardinStep: .welcome)
        
        firstVC.illustrationImageView.image = UIImage(resource: .welcimeIll)
        firstVC.mainTextLabel.text = "Welcome"
        firstVC.subTextLabel.text = "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!"
        
        let secondVC = ReusableOnboardingViewController(onboardinStep: .favorites)
        secondVC.illustrationImageView.image = UIImage(resource: .favoritesIll)
        secondVC.mainTextLabel.text = "All your favorites"
        secondVC.subTextLabel.text = "Order from the best local restaurants with easy, on-demand delivery."
        
        let thirdVC = ReusableOnboardingViewController(onboardinStep: .freeDelivery)
        thirdVC.illustrationImageView.image = UIImage(resource: .freeDeliveryIll)
        thirdVC.mainTextLabel.text = "Free delivery offers"
        thirdVC.subTextLabel.text = "Free delivery for new customers via Apple Pay and others payment methods."

        let fourVC = ReusableOnboardingViewController(onboardinStep: .foodChoice)
        fourVC.illustrationImageView.image = UIImage(resource: .foodChoiceIll)
        fourVC.mainTextLabel.text = "Choose your food"
        fourVC.subTextLabel.text = "Easily find your type of food craving and you’ll get delivery in wide range."
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        pages.append(fourVC)
        
        let onboardingViewModel = OnboardingViewModel(onboardingCoordinator: coordinator)
        let onboardingViewController = OnboardingPageViewController(pages: pages,
                                                                onboardingViewOutput: onboardingViewModel)
        
        return onboardingViewController
    }
    // MARK: - Main Flow
    static func makeMainFlow(appCoordinator: AppCoordinator,
                             finishDelegate: CoordinatorFinishDelegate,
                             navigationController: UINavigationController) -> TabBarController {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home,
                                              navigationController: homeNavigationController,
                                              finishDelegate: finishDelegate)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 0)
        appCoordinator.addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
        
        let searchNavigationController = UINavigationController()
        let searchCoordinator = SearchCoordinator(type: .search,
                                                  navigationController: searchNavigationController,
                                                  finishDelegate: finishDelegate)
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 1)
        appCoordinator.addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        let ordersNavigationController = UINavigationController()
        let ordersCoordinator = OrdersCoordinator(type: .orders,
                                                  navigationController: ordersNavigationController,
                                                  finishDelegate: finishDelegate)
        ordersNavigationController.tabBarItem = UITabBarItem(title: "Orders",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 2)
        appCoordinator.addChildCoordinator(ordersCoordinator)
        ordersCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile,
                                                    navigationController: profileNavigationController,
                                                    finishDelegate: finishDelegate)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                           image: UIImage(systemName: "star"),
                                                           tag: 3)
        appCoordinator.addChildCoordinator(profileCoordinator)
        profileCoordinator.start()
        
        let tabBarControllers = [homeNavigationController,
                                 searchNavigationController,
                                 ordersNavigationController,
                                 profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        return tabBarController
    }
    // MARK: - Onboarding Flow
    static func makeOnboardingFlow(appCoordinator: AppCoordinator, 
                                   finishDelegate: CoordinatorFinishDelegate,
                                   navigationController: UINavigationController) {
        let onboardingCoordinator = OnboardingCoordinator(type: .onboarding,
                                                          navigationController: navigationController,
                                                          finishDelegate: finishDelegate)
        appCoordinator.addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }
}
