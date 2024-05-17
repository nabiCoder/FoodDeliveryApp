import UIKit

class OnboardingCoordinator: BaseCoordinator {
    
    private let faktory = SceneFactory.self
    
    override func start() {
        showOnboarding()
    }
    
    override func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
private extension OnboardingCoordinator {
    func showOnboarding() {
        let onboardingViewController = faktory.makeOnboardingScene(coordinator: self)
        navigationController?.pushViewController(onboardingViewController, animated: true)
    }
}
