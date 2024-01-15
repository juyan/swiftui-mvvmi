//
//  File.swift
//  
//
//  Created by Jun Yan on 1/13/24.
//

import Foundation

/// Interactor that manages tasks automatically based on SwiftUI view's callbacks.
/// Caller should use `addTask` to initiate async code so they will be cancelled and destroyed when the view disappears.
/// `task` method is intentionally prohibited because a single approach to manage task lifecycles is preferred.
/// Here's an example usage:
/// ```swift
/// final class FooInteractor: TaskAwareInteractor<FooViewModel> {
///   override func onAppear(viewModel: FooViewModel) {
///       addTask {
///           await initialize(viewModel)
///       }
///       addTask {
///           await subscribeToFooStream()
///       }
///   }
///
///   override func onDisappear(viewModel: FooViewModel) {
///       super.onDisappear(viewModel)
///   }
/// }
/// ```
open class TaskAwareInteractor<ViewModelType: ViewModel>: Interactor<ViewModelType> {
  
  private var tasks = Set<Task<(), Error>>()
  
  public final func addTask(task: @escaping @Sendable () async throws -> ()) {
    self.tasks.insert(Task(operation: task))
  }
  
  open override func task(viewModel: ViewModelType) async {
    fatalError("Use `addTask` to manage task lifecycle instead.")
  }
    
  open override func onAppear(viewModel: ViewModelType) {
    
  }
  
  open override func onDisappear(viewModel: ViewModelType) {
    tasks.forEach { $0.cancel() }
    tasks.removeAll()
  }
}
