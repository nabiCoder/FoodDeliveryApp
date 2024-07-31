import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let userStorage = UserStorage.shared
    private let factory = SceneFactory.self
    
    override func start() {
        if userStorage.passedOnboarding {
            if userStorage.passedAuth {
                showMainFlow()
            } else {
                showAuthFlow()
            }
        } else {
            showOnboardingFlow()
        }
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        factory.makeOnboardingFlow(appCoordinator: self,
                                   finishDelegate: self,
                                   navigationController: navigationController)
    }
    
    func showAuthFlow() {
        guard let navigationController = navigationController else { return }
        factory.makeAuthFlow(appCoordinator: self,
                             finishDelegate: self,
                             navigationController: navigationController)
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        let tabBarController = factory.makeMainFlow(appCoordinator: self,
                                                    finishDelegate: self,
                                                    navigationController: navigationController)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .onboarding:
            showAuthFlow()
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()]
        case .authorization:
            showMainFlow()
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()]
        case .app:
            return
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}
