//
//  Config.swift
//  Mantis
//
//  Created by Yingtao Guo on 11/28/21.
//

import Foundation
import UIKit


// MARK: - Localization
public class LocalizationConfig {
    public var bundle: Bundle? = Mantis.Config.bundle
    public var tableName = "MantisLocalizable"
}

// MARK: - Config
public struct Config {
    public var presetTransformationType: PresetTransformationType = .none
    public var cropShapeType: CropShapeType = .rect
    public var cropVisualEffectType: CropVisualEffectType = .blurDark
    public var ratioOptions: RatioOptions = .all
    public var presetFixedRatioType: PresetFixedRatioType = .canUseMultiplePresetFixedRatio()
    public var showRotationDial = true
    public var dialConfig = DialConfig()
    public var cropToolbarConfig = CropToolbarConfig()
    public private(set) var localizationConfig = Mantis.localizationConfig

    var customRatios: [(width: Int, height: Int)] = []

    static private var bundleIdentifier: String = {
        return "com.echo.framework.Mantis"
    }()

    static private(set) var bundle: Bundle? = {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            return nil
        }

        if let url = bundle.url(forResource: "MantisResources", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return bundle
        }
        return nil
    }()

    public init() {
    }

    mutating public func addCustomRatio(byHorizontalWidth width: Int, andHorizontalHeight height: Int) {
        customRatios.append((width, height))
    }

    mutating public func addCustomRatio(byVerticalWidth width: Int, andVerticalHeight height: Int) {
        customRatios.append((height, width))
    }

    func hasCustomRatios() -> Bool {
        return !customRatios.isEmpty
    }

    func getCustomRatioItems() -> [RatioItemType] {
        return customRatios.map {
            (String("\($0.width):\($0.height)"), Double($0.width)/Double($0.height), String("\($0.height):\($0.width)"), Double($0.height)/Double($0.width))
        }
    }
}
