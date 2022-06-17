import Foundation

public protocol UserDefaultsStorageProtocol {
    func object(forKey key: String) -> Any?
    func setObject(_ value: Any, forKey key: String)
    func registerDefault(value: Any, key: String)
    func removeObject(forKey key: String)
}

class UserDefaultsStorage: UserDefaultsStorageProtocol {
    let storage: UserDefaults
    var defaultValues = [String: Any]()
    
    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }
    
    func object(forKey key: String) -> Any? {
        if let object = storage.object(forKey: key) {
            return object
        } else {
            return defaultValues[key]
        }
    }
    
    func setObject(_ value: Any, forKey key: String) {
        storage.set(value, forKey: key)
    }
    
    func registerDefault(value: Any, key: String) {
        defaultValues[key] = value
    }
    
    func removeObject(forKey key: String) {
        storage.removeObject(forKey: key)
    }
}
