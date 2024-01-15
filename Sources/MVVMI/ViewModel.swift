//
//  File.swift
//
//
//  Created by Jun Yan on 6/19/22.
//

import Foundation

/// A view model. It is intentionally main actor isolated so mutations of state can be guaranteed to be on UI thread
@MainActor
open class ViewModel: ObservableObject {
  public init() {}
}
