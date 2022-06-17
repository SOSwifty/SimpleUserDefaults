import SimpleUserDefaults
import Foundation

final class MockUserDefaultsStorage: UserDefaultsStorageProtocol {
    var mockedReturnValue: Any?
    
    func object(forKey key: String) -> Any? { return mockedReturnValue }
    func setObject(_ value: Any, forKey key: String) {
        mockedReturnValue = value
    }
    func registerDefault(value: Any, key: String) {
        mockedReturnValue = value
    }
    func removeObject(forKey key: String) {
        mockedReturnValue = nil
    }
}
