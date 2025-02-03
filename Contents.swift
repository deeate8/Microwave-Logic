// 電子レンジのロジック構築。１５分を安全上の都合リミットとする

import UIKit


enum PowerLevel: Int {
    case watt200 = 200
    case watt500 = 500
    case watt600 = 600
    case watt1000 = 1000
}


class Microwave: @unchecked Sendable {
    var timer: Timer?
    var remainingTime: TimeInterval = 0
    var powerLevel: PowerLevel
    let maxTime: TimeInterval = 15 * 60
    
    init(powerLevel: PowerLevel) {
        self.powerLevel = powerLevel
    }
    
    func startHeating(minute: Double) -> String {
        let seconds = minute * 60
        
        if seconds > maxTime {
            return "温めを実行できません。１５分以下に設定して下さい"
        }
        
        timer?.invalidate()
        remainingTime = seconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self
            else { return }
            
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                self.stop()
            }
        }
        
        return "温めを開始します"
    }
        
        func stop() {
            timer?.invalidate()
            timer = nil
            remainingTime = 0
        }
        
    func setPowerLevel(_ level: PowerLevel) {
        powerLevel = level
    }
    
    
    func getRemainingTime() -> String {
        let minute = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    func getCurrentPowerLevel() -> Int {
        return powerLevel.rawValue
    }
}

