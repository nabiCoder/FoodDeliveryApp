import Foundation

protocol OnboardingViewOutput: AnyObject {
    func onboardingFinish()
}

class OnboardingViewModel {
    
    private let userStorage = UserStorage.shared
    // MARK: - Propertys
    weak var onboardingCoordinator: OnboardingCoordinator?
    // MARK: - Init
    init(onboardingCoordinator: OnboardingCoordinator) {
        self.onboardingCoordinator = onboardingCoordinator
    }
}
// MARK: - Extensions
extension OnboardingViewModel: OnboardingViewOutput {
    func onboardingFinish() {
        userStorage.passedOnboarding = true
        onboardingCoordinator?.finish()
    }
}
