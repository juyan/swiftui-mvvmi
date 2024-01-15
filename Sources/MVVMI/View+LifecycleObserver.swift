//
//  File.swift
//
//
//  Created by Jun Yan on 6/19/22.
//

import Foundation
import SwiftUI

public extension View {
  
  /// Bind the view lifecycle to your interactor and view model.
  /// - Parameters:
  ///   - observer: The observer, this is normally the interactor.
  ///   - viewModel: The view model.
  /// - Returns: The view itself.
  func bind<ObserverType: ViewLifecycleObserver>(observer: ObserverType, viewModel: ObserverType.ViewModelType) -> some View {
    return self.onAppear {
      observer.onAppear(viewModel: viewModel)
    }.onDisappear {
      observer.onDisappear(viewModel: viewModel)
    }.task {
      await observer.task(viewModel: viewModel)
    }
  }
}
