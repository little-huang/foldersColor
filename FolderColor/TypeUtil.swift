//
//  TypeUtil.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation

struct TypeUtil {
	
	static public let shared = TypeUtil()
	
	func isNull<T: Any>(value: T?) -> Bool {
		return value == nil
	}
	
	func isNotNull<T: Any>(value: T?) -> Bool {
		return value != nil
	}
	
}
