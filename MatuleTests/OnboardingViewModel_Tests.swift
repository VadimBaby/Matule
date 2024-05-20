//
//  OnboardingViewModel_Tests.swift
//  MatuleTests
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import XCTest
@testable import Matule

final class OnboardingViewModel_Tests: XCTestCase {
    
    private let queue: [QueueModel] = Constants.queue

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // Изображение и текста из очереди извлекается правильно (в порядке добавления в очередь).
    
    func test_OnboardingViewModel_ImagesAndTextsExtractedFromQueueSuccess() {
        let viewModel = OnboardingView.ViewModel(watchedQueueItemId: 0, customQueue: queue)
        
        var i = viewModel.queue.count
        
        while true {
            guard let firstQueueElement = viewModel.queue.first else { return }
            
            guard i > 0 else { XCTFail(); return }
            
            viewModel.next()
            i -= 1
            
            guard let currentQueueElement = viewModel.currentQueueItem else { return }
            
            XCTAssertEqual(firstQueueElement.id, currentQueueElement.id)
        }
    }
    
    // Корректное извлечение элементов из очереди (количество элементов в очереди уменьшается на единицу).
    
    func test_OnboardingViewModel_CorrectExtractElementsFromQueue() {
        let viewModel = OnboardingView.ViewModel(watchedQueueItemId: 0, customQueue: queue)
        
        var i = viewModel.queue.count
        
        while true {
            guard !viewModel.queue.isEmpty else { return }
            
            guard i > 0 else { XCTFail(); return }
            
            let oldCount = viewModel.queue.count
            
            viewModel.next()
            
            let nowCount = viewModel.queue.count
            
            let difference = oldCount - nowCount
            
            XCTAssertEqual(difference, 1)
            
            i -= 1
        }
    }
    
    // В случае, когда в очереди несколько картинок, устанавливается правильная надпись на кнопке.
    
    func test_OnboardingViewModel_IfQueueHasSeveralElementsThenSetRightButton() {
        let viewModel = OnboardingView.ViewModel(watchedQueueItemId: 0, customQueue: queue)
        
        var i = viewModel.queue.count
        
        while true {
            guard viewModel.queue.count > 1 else { return }
            
            guard i > 1 else { XCTFail(); return }
            
            XCTAssertFalse(viewModel.showdNextButton)
            
            viewModel.next()
            
            i -= 1
        }
    }
    
    // Случай, когда очередь пустая, надпись на кнопке должна измениться на "Sing Up".
    
    func test_OnboardingViewModel_IfQueueIsEmptyThenShowSkipAndNextButtonShouldEqualFalse() {
        let viewModel = OnboardingView.ViewModel(watchedQueueItemId: 0, customQueue: [])
        
        XCTAssertFalse(viewModel.showdNextButton)
    }
    
    // Если очередь пустая и пользователь нажал на кнопку “Sing in”, происходит открытие пустого экрана «Holder» приложения. Если очередь не пустая – переход отсутствует.
    
    func test_OnboardingViewModel_IfQueueIsEmptyAndUserPressSignInThenHolderIsOpenedElseQueueIsNotEmptyThenHolderIsNotOpened() {
        let viewModel = OnboardingView.ViewModel(watchedQueueItemId: 0, customQueue: queue)
        
        var i = viewModel.queue.count
        
        while true {
            guard i < 0 else { return }
            
            if viewModel.queue.isEmpty {
                guard i == 0 else { XCTFail(); return}
                
                viewModel.next()
                
                XCTAssertNil(viewModel.currentQueueItem)
            } else {
                guard i > 0 else { XCTFail(); return}
                
                viewModel.next()
                
                XCTAssertNotNil(viewModel.currentQueueItem)
            }
            
            i -= 1
        }
    }
}
