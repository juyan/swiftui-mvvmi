import XCTest
@testable import MVVMI

final class TaskAwareInteractorTests: XCTestCase {
    
    func test_whenViewAppear_taskExecuted() async throws {
        let expectation = XCTestExpectation(description: "task to complete")
        let cancelExpectation = XCTestExpectation(description: "task to cancel")
        let interactor = TestInteractor(expectation: expectation, cancelExpectation: cancelExpectation)
        let vm = await TestViewModel()
        interactor.onAppear(viewModel: vm)
        await fulfillment(of: [expectation], timeout: 1.0)
        interactor.onDisappear(viewModel: vm)
        await fulfillment(of: [cancelExpectation], timeout: 1.0)
    }
  
    final class TestViewModel: ViewModel {}
    
    final class TestInteractor: TaskAwareInteractor<TestViewModel> {
        
        private let expectation: XCTestExpectation
        private let cancelExpectation: XCTestExpectation
        
        init(
            expectation: XCTestExpectation,
            cancelExpectation: XCTestExpectation
        ) {
            self.expectation = expectation
            self.cancelExpectation = cancelExpectation
        }
        
        override func onAppear(viewModel: TaskAwareInteractorTests.TestViewModel) {
            super.onAppear(viewModel: viewModel)
            addTask {
                self.expectation.fulfill()
            }
            addTask {
                while Task.isCancelled {
                    //sleep for 500ms
                    try await Task.sleep(nanoseconds: 500 * 1000 * 1000)
                }
                self.cancelExpectation.fulfill()
            }
        }
        
        override func onDisappear(viewModel: TaskAwareInteractorTests.TestViewModel) {
            super.onDisappear(viewModel: viewModel)
        }
    }
}
