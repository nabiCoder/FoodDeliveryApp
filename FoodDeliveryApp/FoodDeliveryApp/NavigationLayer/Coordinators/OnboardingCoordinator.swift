import UIKit

class OnboardingCoordinator: Coordinator {
    
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
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .blue
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .green
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .red
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        
        let onboardingViewModel = OnboardingViewModel(onboardingCoordinator: self)
        let onboardingViewController = OnboardingViewController(pages: pages,
                                                                onboardingViewOutput: onboardingViewModel)
        navigationController?.pushViewController(onboardingViewController, animated: true)
        
    }
}
