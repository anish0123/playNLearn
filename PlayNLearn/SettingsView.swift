//
//  SettingsView.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 15.4.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var moc
        @FetchRequest(entity: SwitchObject.entity(), sortDescriptors: []) private var objects: FetchedResults<SwitchObject>

        var body: some View {
            VStack {
                Toggle("Voice Mode", isOn: bindingForSwitch)
                Spacer()
            }
            .padding()
        }

    // Variable introduced to getting and setting the data from core data
        private var bindingForSwitch: Binding<Bool> {
            Binding<Bool>(
                get: { objects.first?.switchState ?? false },
                set: { newValue in
                    updateSwitchState(newValue)
                }
            )
        }

    // Function for updating the voice mode data in core data
        private func updateSwitchState(_ newState: Bool) {
            if let object = objects.first {
                object.switchState = newState
            } else {
                let object = SwitchObject(context: moc)
                object.switchState = newState
            }

            do {
                try moc.save()
            } catch {
                print("Error saving switch state: \(error)")
            }
        }
    }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
