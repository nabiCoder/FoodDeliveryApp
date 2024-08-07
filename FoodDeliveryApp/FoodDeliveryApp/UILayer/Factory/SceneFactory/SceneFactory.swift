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
    // MARK: - Login
    static func makeLoginScene(coordinator: AuthCoordinator) -> LoginViewController {
        let loginViewModel = LoginViewModel(authCoordinator: coordinator)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        return loginViewController
    }
    // MARK: - Create Account
    static func makeCreateAccountScene(coordinator: AuthCoordinator) -> CreateAccountViewController {
        let createAccountViewModel = CreateAccountViewModel(authCoordinator: coordinator)
        let createAccountViewController = CreateAccountViewController(viewModel: createAccountViewModel)
        
        return createAccountViewController
    }
    // MARK: - Password Reset
    static func makePasswordResetScene(coordinator: AuthCoordinator) -> PasswordResetViewController {
        let passwordResetViewModel = PasswordResetViewModel(authCoordinator: coordinator)
        let passwordResetViewController = PasswordResetViewController(viewModel: passwordResetViewModel)
        
        return passwordResetViewController
    }
    // MARK: - Password Reset Success
    static func makePasswordResetSuccessScene(coordinator: AuthCoordinator,
                                              email: String) -> PasswordResetSuccessViewController {
        let passwordResetSuccessViewModel = PasswordResetSuccessViewModel(authCoordinator: coordinator)
        let passwordResetSuccessVC = PasswordResetSuccessViewController(email: email,
                                                                        PRSViewOutput: passwordResetSuccessViewModel)
        
        return passwordResetSuccessVC
    }
    // MARK: - Enter Number
    static func makeEnterNumberScene(coordinator: AuthCoordinator) -> EnterNumberViewController {
        let countryCodeArray = [CountryCode(name: "Russia", dialCode: "+7", code: "RU"),
                                CountryCode(name: "USA", dialCode: "+1", code: "US"),
                                CountryCode(name: "Kazakhstan", dialCode: "+76", code: "KZ")]
        let enterNumberViewModel = EnterNumberViewModel(authCoordinator: coordinator, countries: countryCodeArray)
        let enterNumberViewController = EnterNumberViewController(viewModel: enterNumberViewModel)
        
        return enterNumberViewController
    }
    // MARK: - Verify Number
    static func makeVerifyNumberScene(coordinator: AuthCoordinator, phoneNumber: String) -> VerifyNumberViewController {
        let verifyNumberViewModel = VerifyNumberViewModel(authCoordinator: coordinator)
        let verifyNumberViewController = VerifyNumberViewController(viewModel: verifyNumberViewModel, 
                                                                    phoneNumber: phoneNumber)
        
        return verifyNumberViewController
    }
    // MARK: - Home Scene
    static func makeHomeScene(coordinator: HomeCoordinator) -> HomeViewController {
        let homeViewModel = HomeViewModel(homeCoordinator: coordinator)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        return homeViewController
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
                                                           image: UIImage(resource: .home),
                                                           tag: 0)
        appCoordinator.addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
        
        let searchNavigationController = UINavigationController()
        let searchCoordinator = SearchCoordinator(type: .search,
                                                  navigationController: searchNavigationController,
                                                  finishDelegate: finishDelegate)
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search",
                                                             image: UIImage(resource: .search),
                                                             tag: 1)
        appCoordinator.addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        let ordersNavigationController = UINavigationController()
        let ordersCoordinator = OrdersCoordinator(type: .orders,
                                                  navigationController: ordersNavigationController,
                                                  finishDelegate: finishDelegate)
        ordersNavigationController.tabBarItem = UITabBarItem(title: "Orders",
                                                           image: UIImage(resource: .orders),
                                                           tag: 2)
        appCoordinator.addChildCoordinator(ordersCoordinator)
        ordersCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile,
                                                    navigationController: profileNavigationController,
                                                    finishDelegate: finishDelegate)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                              image: UIImage(resource: .profile),
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
    // MARK: - Auth Flow
    static func makeAuthFlow(appCoordinator: AppCoordinator,
                             finishDelegate: CoordinatorFinishDelegate,
                             navigationController: UINavigationController) {
        let authCoordinator = AuthCoordinator(type: .authorization,
                                              navigationController: navigationController,
                                              finishDelegate: finishDelegate)
        appCoordinator.addChildCoordinator(authCoordinator)
        authCoordinator.start()
    }
}
