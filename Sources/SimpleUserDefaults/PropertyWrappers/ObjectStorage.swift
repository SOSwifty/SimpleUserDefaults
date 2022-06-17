import Foundation
import Combine

@propertyWrapper
struct ObjectStorage<Value: Codable> {
    let key: String
    var storage: UserDefaultsStorageProtocol
    private let publisher = PassthroughSubject<Value, Never>()

    var wrappedValue: Value {
        get {
            let data = storage.object(forKey: key) as! Data
            return try! JSONDecoder().decode(Value.self, from: data)
        }
        nonmutating set {
            let data = try! JSONEncoder().encode(newValue)
            storage.setObject(data, forKey: key)
            publisher.send(newValue)
            
        }
    }
    
    var projectedValue: AnyPublisher<Value, Never> {
        return publisher.eraseToAnyPublisher()
    }
    
    public init(wrappedValue: Value, _ key: String, storage: UserDefaultsStorageProtocol = UserDefaultsStorage()) {
        self.key = key
        self.storage = storage
        let data = try! JSONEncoder().encode(wrappedValue)
        storage.registerDefault(value: data, key: key)
    }
}

@propertyWrapper
struct OptionalObjectStorage<Value: Codable> {
    let key: String
    var storage: UserDefaultsStorageProtocol
    private let publisher = PassthroughSubject<Value?, Never>()

    var wrappedValue: Value? {
        get {
            guard let data = storage.object(forKey: key) as? Data else { return nil }
            return try? JSONDecoder().decode(Value.self, from: data)
        }
        nonmutating set {
            if let data = try? JSONEncoder().encode(newValue) {
                storage.setObject(data, forKey: key)
                publisher.send(newValue)
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

