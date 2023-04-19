//
//  SettingsView.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 15.4.2023.
//

import SwiftUI

struct SettingsView: View {
    @State  public var voiceMode = false
    
    var body: some View {
        VStack() {
           Toggle("Activate Voice Mode", isOn: $voiceMode)
                .toggleStyle(SwitchToggleStyle(tint: Color.green))
            
            Text(voiceMode ? "voice Mode On" : "Voice Mode Off")
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
