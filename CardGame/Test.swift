//
//  Test.swift
//  CardGame
//
//  Created by Nato Egnatashvili on 07.05.24.
//

import SwiftUI

struct Test: View {
    @State private var message = "This is a long message that may vary in length."

        var body: some View {
            ViewThatFits {
                Text(message)
                    .padding()
                    .border(Color.black) // For visualization
 
                Button("Change Message") {
                    self.message = "Short message"
                }
                .padding()
            }
            .frame(width: 200, height: 200) // Provide a fixed frame for demonstration
            .border(Color.red) // For visualization
        }
}

#Preview {
    Test()
}
