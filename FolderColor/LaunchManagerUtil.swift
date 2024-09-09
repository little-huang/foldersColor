//
// Created by 黄宝成 on 2024/9/9.
//

import Foundation

class LaunchManagerUtil {

    static let isFirstLaunchKey = "isFirstLaunch"

    static func isFirstLaunch() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: isFirstLaunchKey) == false
    }

    static func setFirstLaunchFlag() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: isFirstLaunchKey)
        userDefaults.synchronize()
    }

}
