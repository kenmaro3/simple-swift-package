// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

extension String {

    /// Transform Hiragana to Katakana.
    /// - Returns: The transformed string.
    /// - SeeAlso: ``toHiragana()``
    public func toKatakana() -> String? {
        applyingTransform(.hiraganaToKatakana, reverse: false)
    }

    /// Transform Katakana to Hiragana.
    /// - Returns: The transformed string.
    /// - SeeAlso: ``toKatakana()``
    public func toHiragana() -> String? {
        applyingTransform(.hiraganaToKatakana, reverse: true)
    }
}

import SwiftUI
 
@available(iOS 14, macOS 11.0, *)
public struct AnimatedMenuBar: View {
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
 
    var menuItems = [ "Travel", "Nature", "Architecture" ]
 
    public init(selectedIndex: Binding<Int>, menuItems: [String] = [ "Travel", "Nature", "Architecture" ]) {
        self._selectedIndex = selectedIndex
        self.menuItems = menuItems
    }
 
    public var body: some View {
 
        HStack {
            Spacer()
 
            ForEach(menuItems.indices) { index in
 
                if index == selectedIndex {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color.purple))
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
                } else {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color( red: 244, green: 244, blue: 244)))
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
 
                Spacer()
            }
 
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .animation(.easeInOut, value: selectedIndex)
 
    }
}
