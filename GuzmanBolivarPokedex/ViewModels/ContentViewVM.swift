//
//  ContentView_VM.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import Foundation
import SwiftUI

class ContentViewVM: ObservableObject {
  var network = Networking()
  @Published var sprites = [String]()
}
