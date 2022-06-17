import XCTest
import Combine
@testable import SimpleUserDefaults

final class ValueStorageTests: XCTestCase {
    var mockedStorage: UserDefaultsStorageProtocol!
    var bindings = Set<AnyCancellable>()
    
    let value = "value1"
    let updatedValue = "value2"
    
    override func setUp() {
        super.setUp()
        mockedStorage = MockUserDefaultsStorage()
    }
    
    // MARK: - ValueStorage tests
    func test_valueStorage_getDefault() {
        @ValueStorage("test1", storage: mockedStorage) var test1: String = value
        
        XCTAssert(test1 == value)
    }
    
    func test_valueStorage_setNewValue() {
        @ValueStorage("test1", storage: mockedStorage) var test1: String = value
        test1 = updatedValue
        XCTAssert(test1 == updatedValue)
    }
    
    func test_valueStorage_observeValueChange() {
        let expection = expectation(description: "value storage - value changed")
        
        @ValueStorage("test1", storage: mockedStorage) var test1: String = value
        $test1
            .sink { newValue in
                XCTAssert(newValue == self.updatedValue)
                expection.fulfill()
            }
            .store(in: &bindings)
        
        test1 = updatedValue
        waitForExpectations(timeout: 0.2)
    }
    
    // MARK: OptionalValueStorage tests
    func test_optionalValueStorage_getDefault() {
        @OptionalValueStorage("test1", storage: mockedStorage) var test1: String?
        
        XCTAssertNil(test1)
    }
    
    func test_optionalValueStorage_setNewValue() {
        @OptionalValueStorage("test1", storage: mockedStorage) var test1: String?
        test1 = updatedValue
        XCTAssert(test1 == updatedValue)
    }
    
    func test_optionalValueStorage_observeValueChange() {
        let expection = expectation(description: "value storage - value changed")
        
        @OptionalValueStorage("test1", storage: mockedStorage) var test1: String?
        $test1
            .sink { newValue in
                XCTAssert(newValue == self.updatedValue)
                expection.fulfill()
            }
            .store(in: &bindings)
        
        test1 = updatedValue
        waitForExpectations(timeout: 0.2)
    }
}
