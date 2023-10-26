//
//  TimerListModel.swift
//  Routine
//
//  Created by 한현규 on 10/18/23.
//

import Foundation


struct TimerListModel{
    let timerId: UUID
    let name: String
    let timerType: TimerTypeModel
    let timerCountdown: Int?
    let tint: String
    
    init(_ dto: TimerListDto) {
        self.timerId = dto.timerId
        self.name = dto.timerName
        self.timerType = TimerTypeModel(dto.timerType)
        self.timerCountdown = dto.timerCountdown
        self.tint = "#CCFFCCFF"
    }

}


enum TimerTypeModel: String{
    case focus
    case section
    
    init(_ dto: TimerTypeDto){
        switch dto {
        case .focus: self = .focus
        case .section: self = .section
        }
    }
}
