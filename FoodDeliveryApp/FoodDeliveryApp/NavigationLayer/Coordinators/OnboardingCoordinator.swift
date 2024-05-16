import UIKit

class OnboardingCoordinator: BaseCoordinator {
    
    override func start() {
        showOnboarding()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
private extension OnboardingCoordinator {
    func showOnboarding() {
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
        
        let onboardingViewModel = OnboardingViewModel(onboardingCoordinator: self)
        let onboardingViewController = OnboardingPageViewController(pages: pages,
                                                                onboardingViewOutput: onboardingViewModel)
        navigationController?.pushViewController(onboardingViewController, animated: true)
        
    }
}
