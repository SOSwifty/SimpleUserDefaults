import XCTest
import Combine
@testable import SimpleUserDefaults

struct TestingObject: Codable, Equatable {
    var someValue: String
}

final class ObjectStorageTests: XCTestCase {
    var mockedStorage: UserDefaultsStorageProtocol!
    var bindings = Set<AnyCancellable>()
    
    let value = TestingObject(someValue: "value1")
    let updatedValue = TestingObject(someValue: "value2")
    
    override func setUp() {
        super.setUp()
        mockedStorage = MockUserDefaultsStorage()
    }
    
    // MARK: - ObjectStorage tests
    func test_objectStorage_getDefault() {
        @ObjectStorage("test1", storage: mockedStorage) var test1: TestingObject = value
        
        XCTAssert(test1 == value)
    }
    
    func test_objectStorage_setNewValue() {
        @ObjectStorage("test1", storage: mockedStorage) var test1: TestingObject = value
        test1 = updatedValue
        XCTAssert(test1 == updatedValue)
    }
    
    func test_objectStorage_observeValueChange() {
        let expection = expectation(description: "value storage - value changed")
        
        @ObjectStorage("test1", storage: mockedStorage) var test1: TestingObject = value
        $test1
            .sink { newValue in
                XCTAssert(newValue == self.updatedValue)
                expection.fulfill()
            }
            .store(in: &bindings)
        
        test1 = updatedValue
        waitForExpectations(timeout: 0.2)
    }
    
    func test_objectValue_codableValue() {
        @ObjectStorage("test1", storage: mockedStorage) var test1: TestingObject = value
        
        XCTAssert(test1.someValue == value.someValue)
    }
    
    // MARK: OptionalObjectStorage tests
    func test_optionalValueStorage_getDefault() {
        @OptionalObjectStorage("test1", storage: mockedStorage) var test1: TestingObject?
        
        XCTAssertNil(test1)
    }
    
    func test_optionalValueStorage_setNewValue() {
        @OptionalObjectStorage("test1", storage: mockedStorage) var test1: TestingObject?
        test1 = updatedValue
        XCTAssert(test1 == updatedValue)
    }
    
    func test_optionalValueStorage_observeValueChange() {
        let expection = expectation(description: "value storage - value changed")
        
        @OptionalObjectStorage("test1", storage: mockedStorage) var test1: TestingObject?
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
