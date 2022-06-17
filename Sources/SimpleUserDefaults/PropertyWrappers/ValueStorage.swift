import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, *)
@propertyWrapper
struct ValueStorage<Value: Storable> {
    let key: String
    var storage: UserDefaultsStorageProtocol
    private let publisher = PassthroughSubject<Value, Never>()

    var wrappedValue: Value {
        get {
            return storage.object(forKey: key) as! Value
        }
        nonmutating set {
            storage.setObject(newValue, forKey: key)
            publisher.send(newValue)
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return publisher.eraseToAnyPublisher()
    }
    
    init(wrappedValue: Value, _ key: String, storage: UserDefaultsStorageProtocol = UserDefaultsStorage()) {
        self.key = key
        self.storage = storage
        storage.registerDefault(value: wrappedValue, key: key)
    }
}

@available(macOS 10.15, iOS 13.0, *)
@propertyWrapper
struct OptionalValueStorage<Value: Storable> {
    let key: String
    var storage: UserDefaultsStorageProtocol
    private let publisher = PassthroughSubject<Value?, Never>()

    var wrappedValue: Value? {
        get {
            return storage.object(forKey: key) as? Value
        }
        nonmutating set {
            if let newValue = newValue {
                self.storage.setObject(newValue, forKey: key)
                self.publisher.send(newValue)
            } else {
                self.storage.removeObject(forKey: key)
                self.publisher.send(nil)
            }
        }
    }

    var projectedValue: AnyPublisher<Value?, Never> {
        return publisher.eraseToAnyPublisher()
    }
    
    public init(_ key: String, storage: UserDefaultsStorageProtocol = UserDefaultsStorage()) {
        self.key = key
        self.storage = storage
    }
}
