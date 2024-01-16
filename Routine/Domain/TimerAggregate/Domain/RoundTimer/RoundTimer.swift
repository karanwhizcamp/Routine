//
//  RoundTimer.swift
//  Routine
//
//  Created by 한현규 on 1/17/24.
//

import Foundation



final class RoundTimer : DomainEntity{
    private(set) var timerId: TimerId!
    private(set) var timerName: TimerName!
    private(set) var emoji: Emoji!
    private(set) var tint: Tint!
    private(set) var timerType: TimerType!
    private(set) var ready: Ready!
    private(set) var exercise: Exercise!
    private(set) var rest: Rest!
    private(set) var round: Round!
    private(set) var cooldown: Cooldown!

    
    init(timerId: TimerId, timerName: TimerName, emoji: Emoji, tint: Tint, timerType: TimerType, ready: Ready, exercise: Exercise, rest: Rest, round: Round, cooldown: Cooldown) {
        self.timerId = timerId
        self.timerName = timerName
        self.emoji = emoji
        self.tint = tint
        self.timerType = timerType
        self.ready = ready
        self.exercise = exercise
        self.rest = rest
        self.round = round
        self.cooldown = cooldown
        super.init()
        
        let event = RoundTimerCreated(timerId: timerId, timerName: timerName, emoji: emoji, tint: tint, timerType: timerType, ready: ready, exercise: exercise, rest: rest, round: round, cooldown: cooldown)
        changes.append(event)
    }
    
    required init(_ events: [Event]) {
        super.init(events)
    }
    
    override func mutate(_ event: Event) {
        if let created = event as? RoundTimerCreated{
            when(created)
        }else if let updated = event as? RoundTimerUpdated{
            when(updated)
        }else{
            Log.e("Event is not handling")
        }
    }
    
    private func when(_ event: RoundTimerCreated){
        self.timerId = event.timerId
        self.timerName = event.timerName
        self.emoji = event.emoji
        self.tint = event.tint
        self.timerType = event.timerType
        self.ready = event.ready
        self.exercise = event.exercise
        self.rest = event.rest
        self.round = event.round
        self.cooldown = event.cooldown
    }
    
    private func when(_ event: RoundTimerUpdated){
        self.timerName = event.timerName
        self.emoji = event.emoji
        self.tint = event.tint
        self.timerType = event.timerType
        self.ready = event.ready
        self.exercise = event.exercise
        self.rest = event.rest
        self.round = event.round
        self.cooldown = event.cooldown
    }
    

    func updateTimer(timerName: TimerName, emoji: Emoji, tint: Tint, timerType: TimerType, ready: Ready, exercise: Exercise, rest: Rest, round: Round, cooldown: Cooldown){
        self.timerName = timerName
        self.emoji = emoji
        self.tint = tint
        self.timerType = timerType
        self.ready = ready
        self.exercise = exercise
        self.rest = rest
        self.round = round
        self.cooldown = cooldown
        
        let event = RoundTimerUpdated(timerId: timerId, timerName: timerName, emoji: emoji, tint: tint, timerType: timerType, ready: ready, exercise: exercise, rest: rest, round: round, cooldown: cooldown)
        changes.append(event)
    }
    
    
    func deleteTimer(){
        let event = TabataTimerDeleted(timerId: self.timerId)
        changes.append(event)
    }
    
    
    override func encode(with coder: NSCoder) {
        timerId.encode(with: coder)
        timerName.encode(with: coder)
        emoji.encode(with: coder)
        tint.encode(with: coder)
        timerType.encode(with: coder)
        ready.encode(with: coder)
        exercise.encode(with: coder)
        rest.encode(with: coder)
        round.encode(with: coder)
        cooldown.encode(with: coder)
        super.encode(with: coder)
    }
    
    required override init?(coder: NSCoder) {
        guard let timerId = TimerId(coder: coder),
              let timerName = TimerName(coder: coder),
              let emoji = Emoji(coder: coder),
              let tint = Tint(coder: coder),
              let timerType = TimerType(coder: coder),
              let ready = Ready(coder: coder),
              let exercise = Exercise(coder: coder),
              let rest = Rest(coder: coder),
              let round = Round(coder: coder),
              let cooldown = Cooldown(coder: coder)
        else { return nil}
        
        self.timerId = timerId
        self.timerName = timerName
        self.emoji = emoji
        self.tint = tint
        self.timerType = timerType
        self.ready = ready
        self.exercise = exercise
        self.rest = rest
        self.round = round
        self.cooldown = cooldown
        super.init(coder: coder)
    }
    
    static var supportsSecureCoding: Bool = true
}

