//
//  CoreManager.swift
//  OpenInTerminalCore
//
//  Created by Jianing Wang on 2019/4/27.
//  Copyright © 2019 Jianing Wang. All rights reserved.
//

import Foundation

public class CoreManager {
    
    public static var shared = CoreManager()
    
    public var firstUsage: BoolType {
        if Defaults[.firstUsage] == nil {
            Defaults[.firstUsage] = BoolType._false.rawValue
            return ._true
        } else {
            return ._false
        }
    }
    
    public var launchAtLogin: BoolType {
        get {
            let defaultValue = Defaults[.launchAtLogin].map(BoolType.init(rawValue: )) ?? nil
            if let boolValue = defaultValue {
                return boolValue
            } else {
                // if we get a nil value, we should init it as 'false'
                Defaults[.launchAtLogin] = BoolType._false.rawValue
                return ._false
            }
        }
        
        set {
            Defaults[.launchAtLogin] = newValue.rawValue
        }
    }
    
    public var hideStatusItem: BoolType {
        get {
            let defaultValue = Defaults[.hideStatusItem].map(BoolType.init(rawValue: )) ?? nil
            if let boolValue = defaultValue {
                return boolValue
            } else {
                Defaults[.hideStatusItem] = BoolType._false.rawValue
                return ._false
            }
        }
        
        set {
            Defaults[.hideStatusItem] = newValue.rawValue
        }
    }
    
    public var quickToggle: BoolType {
        get {
            let defaultValue = Defaults[.quickToggle].map(BoolType.init(rawValue: )) ?? nil
            if let boolValue = defaultValue {
                return boolValue
            } else {
                Defaults[.quickToggle] = BoolType._false.rawValue
                return ._false
            }
        }
        
        set {
            Defaults[.quickToggle] = newValue.rawValue
        }
    }
    
    public var quickToggleType: QuickToggleType? {
        get {
            return Defaults[.quickToggleType].map(QuickToggleType.init(rawValue: )) ?? nil
        }
        
        set {
            Defaults[.quickToggleType] = newValue?.rawValue
        }
    }
    
    public func firstSetup() {
        guard firstUsage == ._true else { return }
        logw("First Setup")
        Defaults[.launchAtLogin] = BoolType._false.rawValue
        Defaults[.hideStatusItem] = BoolType._false.rawValue
        Defaults[.quickToggle] = BoolType._false.rawValue
        Defaults[.quickToggleType] = QuickToggleType.openWithDefaultTerminal.rawValue
        Defaults.removeObject(forKey: Constants.Key.defaultTerminal)
        Defaults.removeObject(forKey: Constants.Key.defaultEditor)
        Defaults[.terminalNewOption] = NewOptionType.window.rawValue
        Defaults[.iTermNewOption] = NewOptionType.window.rawValue
        Defaults[.terminalClearOption] = ClearOptionType.noClear.rawValue
        Defaults.synchronize()
    }
    
    public func removeAllUserDefaults() {
        logw("Remove all UserDefaults")
        let domain = Bundle.main.bundleIdentifier!
        Defaults.removePersistentDomain(forName: domain)
        Defaults.synchronize()
    }
    
}
