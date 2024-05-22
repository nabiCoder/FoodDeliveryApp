import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let userStorage = UserStorage.shared
    private let faktory = SceneFactory.self
    
    override func start() {
       let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: false)
//        if userStorage.passedOnboarding {
//            showMainFlow()
//        } else {
//            showOnboardingFlow()
//        }
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        faktory.makeOnboardingFlow(appCoordinator: self,
                                   finishDelegate: self,
                                   navigationController: navigationController)
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        let tabBarController = faktory.makeMainFlow(appCoordinator: self,
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
            navigationController?.viewControllers.removeAll()
            showMainFlow()
        case .app:
            return
        default:
            navigationController?.popViewController(animated: true)
        }
    }
}
