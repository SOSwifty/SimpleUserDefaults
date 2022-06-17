import XCTest
@testable import SimpleUserDefaults

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

extension UserDefaultsStorage {
    func reset(forKey key: String) {
        storage.removeObject(forKey: key)
        defaultValues.removeAll()
        UserDefaults.resetDefaults()
    }
}

final class UserDefaultsStorageTests: XCTestCase {
    let key = "someKey"
    let value = "someValue"
    let secondValue = "someOtherValue"
    
    var sut: UserDefaultsStorage!
    
    override func setUp() {
        super.setUp()
        sut = UserDefaultsStorage()
    }
    
    override func tearDown() {
        super.tearDown()
        sut.reset(forKey: key)
    }
    
    func test_getObject_optional() {
        let object = sut.object(forKey: key)
        XCTAssertNil(object)
    }
    
    func test_setObject() {
        sut.setObject(value, forKey: key)
        let object = sut.object(forKey: key) as! String
        XCTAssert(object == value)
    }
    
    func test_defualtObject() {
        sut.registerDefault(value: value, key: key)
        let object = sut.object(forKey: key) as! String
        XCTAssert(object == value)
    }
    
    func test_defaultObject_updateValue() {
        sut.registerDefault(value: value, key: key)
        sut.setObject(secondValue, forKey: key)
        let object = sut.object(forKey: key) as! String
        XCTAssert(object == secondValue)
    }

    func test_defaultObject_removeValueFallback() {
        sut.registerDefault(value: value, key: key)
        sut.setObject(secondValue, forKey: key)
        sut.removeObject(forKey: key)
        let object = sut.object(forKey: key) as! String
        XCTAssert(object == value)
    }
    
    func test_removeObject_withoutDefault() {
        sut.setObject(value, forKey: key)
        sut.removeObject(forKey: key)
        let object = sut.object(forKey: key)
        XCTAssertNil(object)
    }
    
    func test_updateObject() {
        sut.setObject(value, forKey: key)
        sut.setObject(secondValue, forKey: key)
        let object = sut.object(forKey: key) as! String
        XCTAssert(object == secondValue)
    }
}

