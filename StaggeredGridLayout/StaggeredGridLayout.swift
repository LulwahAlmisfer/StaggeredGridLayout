//
//  StaggeredGridLayout.swift
//  StaggeredGridLayout
//
//  Created by Lulwah almisfer on 05/02/2025.
//

import SwiftUI

struct StaggeredGridLayout: Layout {
    var columns: Int
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let columnHeights = calculateColumnHeights(subviews: subviews, proposal: proposal)
        let maxHeight = columnHeights.max() ?? 0
        return CGSize(width: proposal.width ?? 300, height: maxHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        var columnHeights = Array(repeating: CGFloat(0), count: columns)
        let columnWidth = (bounds.width - CGFloat(columns - 1) * spacing) / CGFloat(columns)

        for subview in subviews {
            let minColumnIndex = columnHeights.firstIndex(of: columnHeights.min()!)!
            let x = CGFloat(minColumnIndex) * (columnWidth + spacing)
            let y = columnHeights[minColumnIndex] + bounds.origin.y

            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: columnWidth, height: nil))
            columnHeights[minColumnIndex] += subview.sizeThatFits(ProposedViewSize(width: columnWidth, height: nil)).height + spacing
        }
    }


    private func calculateColumnHeights(subviews: Subviews, proposal: ProposedViewSize) -> [CGFloat] {
        var columnHeights = Array(repeating: CGFloat(0), count: columns)
        let columnWidth = proposal.width.map { ($0 - CGFloat(columns - 1) * spacing) / CGFloat(columns) } ?? 150

        for subview in subviews {
            let minColumnIndex = columnHeights.firstIndex(of: columnHeights.min()!)!
            columnHeights[minColumnIndex] += subview.sizeThatFits(ProposedViewSize(width: columnWidth, height: nil)).height + spacing
        }

        return columnHeights
    }
}
