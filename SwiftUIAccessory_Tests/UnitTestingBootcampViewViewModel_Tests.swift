//
//  UnitTestingBootcampViewViewModel_Tests.swift
//  SwiftUIAccessory_Tests
//
//  Created by MANAS VIJAYWARGIYA on 24/03/22.
//

import XCTest
@testable import SwiftUIAccessory
import Combine

// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure : test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When, Then

class UnitTestingBootcampViewViewModel_Tests: XCTestCase {
    var viewModel: UnitTestingBootcampViewViewModel?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func randomWord() -> String {
        var x = "";
        for _ in 0..<5{
            let string = String(format: "%c", Int.random(in: 97..<123)) as String
            x+=string
        }
        return x
    }
    
    func test_UnitTestingBootcampViewViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = UnitTestingBootcampViewViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = UnitTestingBootcampViewViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingBootcampViewViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingBootcampViewViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingBootcampViewViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingBootcampViewViewModel_dataArrau_shouldBeEmpty() {
        // Given
        
        // When
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewViewModel_dataArray_shouldAdditems() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        // vm.addItem(item: "Apple")
        // vm.addItem(item: UUID().uuidString)
        // vm.addItem(item: randomWord())
        
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0 ..< loopCount {
            vm.addItem(item: randomWord())
        }
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        // XCTAssertEqual(vm.dataArray.count, 1)
        // XCTAssertEqual(vm.dataArray[0], "Apple")
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        // XCTAssertGreaterThanOrEqual
        // XCTAssertLessThan()
        // XCTAssertLessThanOrEqual
    }
    
    func test_UnitTestingBootcampViewViewModel_dataArray_shouldNotAddBlankString() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewViewModel_dataArray_shouldNotAddBlankString2() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        // selcting valid item
        let newItem = randomWord()
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // selecting invalid item
        vm.selectItem(item: randomWord())
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let newItem = randomWord()
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootcampViewViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = randomWord()
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootcampViewViewModel_saveItem_shouldThrowErrorBeSelected_noData() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: randomWord())
        }
        
        // Then
        // XCTAssertThrowsError(try vm.saveItem(item: ""))
        // XCTAssertThrowsError(try vm.saveItem(item: ""), "Should throw No Data Error!") { error in
           // let returnedError = error as? UnitTestingBootcampViewViewModel.DataError
           // XCTAssertEqual(returnedError, UnitTestingBootcampViewViewModel.DataError.noData)
        // }
        // Or,
        do {
            try vm.saveItem(item: "")
        } catch let error {
             let returnedError = error as? UnitTestingBootcampViewViewModel.DataError
             XCTAssertEqual(returnedError, UnitTestingBootcampViewViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingBootcampViewViewModel_saveItem_shouldThrowErrorBeSelected_itemNotFound() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: randomWord())
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw Item not found Error!") { error in
            let returnedError = error as? UnitTestingBootcampViewViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootcampViewViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = randomWord()
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        // Or,
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
             XCTFail()
        }
    }
    
    func test_UnitTestingBootcampViewViewModel_downloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.downloadWithEscaping()
       
        // Then
        // to be more sure so put 5 sec instead of 3
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewViewModel_downloadWithCombine_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random())
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a seconds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.downloadWithCombine()
       
        // Then
        // to be more sure so put 5 sec instead of 3
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewViewModel_downloadWithCombine_shouldReturnItems2() {
        // Given
        let items: [String] = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
        let vm = UnitTestingBootcampViewViewModel(isPremium: Bool.random(), dataService: dataService)
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a seconds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.downloadWithCombine()
       
        // Then
        // to be more sure so put 5 sec instead of 3
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
}
