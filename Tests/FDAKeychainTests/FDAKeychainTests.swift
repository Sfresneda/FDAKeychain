@testable import FDAKeychain
import XCTest

final class FDAKeychainManagerTests: XCTestCase {
    var sut: FDAKeychainManager!
    var data: Data!
    var key: String!
    var type: CFString!

    let badKey: String = "badKey"
    let badType: CFString = "badType" as CFString

    override func setUp() {
        sut = FDAKeychainManager()
        data = "test".data(using: .utf8)!
        key = "test"
        type = kSecClassGenericPassword
        sut.deleteData(for: key, with: type)
    }

    override func tearDown() {
        sut.deleteData(for: key, with: type)
        sut = nil
        data = nil
        key = nil
        type = nil
    }

    func test_saveData() {
        // When
        let result = sut.saveData(data, for: key, with: type)

        // Then
        XCTAssertTrue(result)
    }

    func test_saveData_withError() {
        // Given
        sut.saveData(data, for: key, with: type)

        // When
        let result = sut.saveData(data, for: key, with: badType)

        // Then
        XCTAssertFalse(result)
    }

    func test_loadData() {
        // Given
        sut.saveData(data, for: key, with: type)

        // When
        let result = sut.loadData(for: key, with: type)

        // Then
        XCTAssertEqual(result, data)
    }

    func test_loadData_withError() {
        // Given
        sut.saveData(data, for: key, with: type)

        // When
        let result = sut.loadData(for: badKey, with: type)

        // Then
        XCTAssertNil(result)
    }

    func test_deleteData() {
        // Given
        sut.saveData(data, for: key, with: type)

        // When
        let result = sut.deleteData(for: key, with: type)

        // Then
        XCTAssertTrue(result)
    }

    func test_deleteData_withError() {
        // When
        let result = sut.deleteData(for: key, with: type)

        // Then
        XCTAssertFalse(result)
    }
}
