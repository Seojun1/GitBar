// Custom/View/TabButton.swift

import SwiftUI

public struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 11, weight: isSelected ? .bold : .medium))
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(isSelected ? Color.white : Color.clear)
                .cornerRadius(6)
                .shadow(color: isSelected ? Color.black.opacity(0.1) : Color.clear, radius: 2)
        }
        .buttonStyle(.plain)
    }
}
