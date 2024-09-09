//
//  AppState.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUI
import SwiftUIFlux

fileprivate var savePath: URL!
fileprivate let encoder = JSONEncoder()
fileprivate let decoder = JSONDecoder()

struct AppState: FluxState, Codable {
    var colorState: ColorState

    init() {
        do {
            let icloudDirectory = FileManager.default.url(forUbiquityContainerIdentifier: nil)
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: false)
            if let icloudDirectory = icloudDirectory {
                try FileManager.default.startDownloadingUbiquitousItem(at: icloudDirectory)
            }

            savePath = (icloudDirectory ?? documentDirectory).appendingPathComponent("userData")
        } catch let error {
            fatalError("Couldn't create save state data with error: \(error)")
        }

        if let data = try? Data(contentsOf: savePath),
           let savedState = try? decoder.decode(AppState.self, from: data) {
            colorState = savedState.colorState
        } else {
            colorState = initColorState()
        }
    }

    func archiveState() {
        let colorState = self.colorState

        DispatchQueue.global().async {
            let savingState = self

            guard let data = try? encoder.encode(savingState) else {
                return
            }

            do {
                try data.write(to: savePath)
            } catch let error {
                print("Error while saving app state :\(error)")
            }
        }
    }

    func sizeOfArchivedState() -> String {
        do {
            let resources = try savePath.resourceValues(forKeys: [.fileSizeKey])
            let formatter = ByteCountFormatter()

            formatter.allowedUnits = .useKB
            formatter.countStyle = .file

            return formatter.string(fromByteCount: Int64(resources.fileSize ?? 0))

        } catch {
            return "0"
        }
    }

    func deleteArchivedState() {
        do {
            try FileManager.default.removeItem(at: savePath)
            print("Successfully deleted saved state data.")
        } catch let error {
            print("Error while deleting app state: \(error)")
        }
    }

    #if DEBUG
        init(colorState: ColorState) {
            self.colorState = colorState
        }
    #endif
}
