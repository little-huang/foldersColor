//
//  Color.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUI

let defaultFolderColorComponents: [CGFloat] = [1, 0, 0, 1]

struct FolderColor: Codable {
	var color: [CGFloat]
	var isSelected: Bool
}

let sampleColor = FolderColor(
	color: [0, 0, 0, 1],
	isSelected: false
)
