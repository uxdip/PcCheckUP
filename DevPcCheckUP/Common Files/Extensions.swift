//
//  Extensions.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 15/3/22.
//

import Foundation
//import GBDeviceInfo

extension SplitViewControllerDetail {

    func printWhenLoaded(infoName: InfoButton) -> String? {
        
        var stringLine: String?
        
        switch infoName {
       
        case .systemInformation:
            stringLine = "// MACHINE STATUS" +   getCPUinfo() +  getMemoryInfo() + getOSInfo() + getBatteryInfo()
        
            startMain()
        case .hardware:
            stringLine = "// MACHINE STATUS" +  getMemoryInfo()
            //setMinFanSpeed(fanId: 0, fanSpeed: )
        case .os:
            stringLine = "// MACHINE STATUS" + getOSInfo()
        case .network:
            stringLine = ""
        case .graphChart:
            stringLine = ""
        case .battery:
            stringLine = "// MACHINE STATUS" +  getBatteryInfo()
        case .cpuUsage:
            stringLine = "// MACHINE STATUS" +   getCPUinfo()
        case .about:
            stringLine = ""
        }
       
        return stringLine
    }
    
    func getCPUFrequency() -> String {
        let Hz = "\(info.cpuInfo.frequency) Hz"
        return Hz
    }
    
    func getOSversion() -> String{
        let version = "\(info.osVersion.major).\(info.osVersion.minor)"
        let versionWithPatch = version + ".\(info.osVersion.patch)"
//        getOSname(versionMain: Int(info.osVersion.major), versionMinor: Int(info.osVersion.minor))
        return versionWithPatch
    }
    
    func getOSname(versionMain: Int, versionMinor: Int) -> String{
        var osName:String?
        switch versionMain {
        case 10:
            if versionMinor == 12 {
                osName = "Siera"
            }else if versionMinor == 13 {
                osName = "High Siera"
            }else if versionMinor == 14 {
                osName = "Mojave"
            }else if versionMinor == 15 {
                osName = "Catalina"
            }
        case 11:
            osName = "Big Sur"
        case 12: osName = "Monterey"
        default:
            break
        }
       
        return osName!
    }
    
    func getCPUinfo() -> String {
        let loadAverage = System.loadAverage().map { NSString(format:"%.2f", $0) }
        let cpuThermalStatus = System.CPUPowerLimit()
        let cpuUsage = sys.usageCPU()
        let cpuInfo = "\n-- CPU --\n" + "\tPHYSICAL CORES:  \(System.physicalCores())\n" + "\tLOGICAL CORES:   \(System.logicalCores())\n" + "\tSYSTEM:          \(Int(cpuUsage.system))%\n" + "\tUSER:            \(Int(cpuUsage.user))%\n" + "\tIDLE:            \(Int(cpuUsage.idle))%\n" + "\tNICE:            \(Int(cpuUsage.nice))%\n" + "\tFREQUENCY:       \(getCPUFrequency())\n" + "\tCPU SPEED LIMIT: \(cpuThermalStatus.processorSpeed)% \n" + "\tCPUs AVAILABLE:  \(cpuThermalStatus.processorCount)\n" + "\tSCHEDULER LIMIT: \(cpuThermalStatus.schedulerTime)% \n" +  "\tTHERMAL LEVEL:   \(System.thermalLevel().rawValue)\n" + "\tLOAD AVERAGE:    \(loadAverage)\n" + "\tMACH FACTOR:     \(System.machFactor())"
        return cpuInfo
    }
    
    func getMemoryInfo() -> String {
        let memoryInfo = "\n-- MEMORY --\n"+"\tPHYSICAL SIZE:   \(System.physicalMemory())GB\n" + "\tFREE:            \(memoryUnit(memoryUsage.free))\n" + "\tWIRED:           \(memoryUnit(memoryUsage.wired))" + "\tACTIVE:          \(memoryUnit(memoryUsage.active))\n" + "\tINACTIVE:        \(memoryUnit(memoryUsage.inactive))\n" + "\tCOMPRESSED:      \(memoryUnit(memoryUsage.compressed))"
        return memoryInfo
    }
    
    func getOSInfo() -> String {
        let loadAverage = System.loadAverage().map { NSString(format:"%.2f", $0) }
        let counts = System.processCounts()
        let uptime = System.uptime()
        let osInfo =  "\n-- SYSTEM OS --\n" + "\tMODEL:           \(System.modelName())\n" + "\tVERSION:           \(getOSversion())\n" + "\tOS NANME:           \(getOSname(versionMain: Int(info.osVersion.major), versionMinor: Int(info.osVersion.minor)))\n"
            + "\tUPTIME:          \(uptime.days)d \(uptime.hrs)h \(uptime.mins)m " + "\(uptime.secs)s \n" + "\tPROCESSES:       \(counts.processCount)\n" + "\tTHREADS:         \(counts.threadCount) \n" + "\tLOAD AVERAGE:    \(loadAverage)\n" + "\tMACH FACTOR:     \(System.machFactor())\n"
        return osInfo
    
    }
    func getBatteryInfo() -> String {
        var info: String! = "\n-- BATTERY --\n"
        var battery = Battery()
        if battery.open() != kIOReturnSuccess { info = info + "No Battery Found"
            return info
        }
        info = info + "\tAC POWERED:      \(battery.isACPowered())" + "\tCHARGED:         \(battery.isCharged())" + "\tCHARGING:        \(battery.isCharging())" + "\tCHARGE:          \(battery.charge())%" + "\tCAPACITY:        \(battery.currentCapacity()) mAh" + "\tMAX CAPACITY:    \(battery.maxCapactiy()) mAh" + "\tDESGIN CAPACITY: \(battery.designCapacity()) mAh" + "\tCYCLES:          \(battery.cycleCount())" + "\tMAX CYCLES:      \(battery.designCycleCount())" + "\tTEMPERATURE:     \(battery.temperature())°C" + "\tTIME REMAINING:  \(battery.timeRemainingFormatted())"
        _ = battery.close()
        return info
    }
    
    func memoryUnit(_ value: Double) -> String {
    if value < 1.0 { return String(Int(value * 1000.0))    + "MB" }
    else           { return NSString(format:"%.2f", value) as String + "GB" }
}
    
}
