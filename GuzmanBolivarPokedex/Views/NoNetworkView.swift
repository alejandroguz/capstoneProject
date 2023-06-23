//
//  NoNetworkView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/23/23.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
      VStack {
        Image(systemName: "wifi.slash")
          .foregroundColor(.red)
        VStack {
          Text("No network connection. Seems to be offline.")
            .multilineTextAlignment(.center)
          Text("Please check your connectivity.")
            .multilineTextAlignment(.center)
        }
        .font(.headline)
        .padding(.top, 5)
      }
      .padding(.horizontal, 10)
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
    }
}
