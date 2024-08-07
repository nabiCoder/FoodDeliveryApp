import Foundation

class UserStorage {
    
    static let shared = UserStorage()
    
    private init() {}
    
    var passedOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "passedOnboarding") }
        set { UserDefaults.standard.set(newValue, forKey: "passedOnboarding")}
    }
    
    var passedAuth: Bool {
        get { UserDefaults.standard.bool(forKey: "passedAuth") }
        set { UserDefaults.standard.set(newValue, forKey: "passedAuth")}
    }
}
