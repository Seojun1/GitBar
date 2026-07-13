// Custom/View/InfoCard.swift

import SwiftUI

public struct InfoCard: View {
    let title: String
    let count: String
    let icon: String
    let iconColor: Color
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: icon).foregroundColor(iconColor)
                Text(title).font(.system(size: 9)).foregroundColor(GitTheme.textSub)
            }
            Text(count).font(.system(size: 12, weight: .bold))
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(GitTheme.cardBg)
        .cornerRadius(8)
    }
}
