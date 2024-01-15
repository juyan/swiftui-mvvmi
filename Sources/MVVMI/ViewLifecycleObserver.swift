//
//  File.swift
//
//
//  Created by Jun Yan on 5/3/23.
//

import Foundation

/// Observer of a SwiftUI view's lifecycle
public protocol ViewLifecycleObserver<ViewModelType>: ObservableObject {
  associatedtype ViewModelType: ViewModel
  
  func task(viewModel: ViewModelType) async

  func onAppear(viewModel: ViewModelType)
  
  func onDisappear(viewModel: ViewModelType)
}
