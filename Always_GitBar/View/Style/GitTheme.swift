// View/Style/GitTheme.swift

import SwiftUI

public enum GitTheme {
    public static let bg = Color(NSColor.windowBackgroundColor)
    public static let cardBg = Color(NSColor.controlBackgroundColor)
    public static let textMain = Color.primary
    public static let textSub = Color.secondary
    
    public static func grassColor(for level: Int) -> Color {
        switch level {
        case 1: return Color(red: 0.08, green: 0.27, blue: 0.16)
        case 2: return Color(red: 0.0, green: 0.43, blue: 0.24)
        case 3: return Color(red: 0.15, green: 0.65, blue: 0.31)
        case 4: return Color(red: 0.24, green: 0.83, blue: 0.40)
        default: return Color(NSColor.quaternaryLabelColor)
        }
    }
}
