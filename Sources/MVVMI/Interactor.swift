//
//  File.swift
//
//
//  Created by Jun Yan on 5/19/23.
//

import Foundation

/// Base Interactor that exposes SwiftUI view's lifecycle callbacks
open class Interactor<ViewModelType: ViewModel>: ViewLifecycleObserver {
  
  public init() {}
  
  open func task(viewModel: ViewModelType) async {}

  open func onAppear(viewModel: ViewModelType) {}
  
  open func onDisappear(viewModel: ViewModelType) {}
}
