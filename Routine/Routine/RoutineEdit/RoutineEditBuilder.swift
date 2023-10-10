//
//  RoutineEditBuilder.swift
//  Routine
//
//  Created by 한현규 on 10/1/23.
//

import Foundation
import ModernRIBs

protocol RoutineEditDependency: Dependency {
    var routineApplicationService: RoutineApplicationService{ get }
    var routineRepository: RoutineRepository{ get }
}

final class RoutineEditComponent: Component<RoutineEditDependency> , RoutineEditTitleDependency, RoutineTintDependency, RoutineEmojiIconDependency, RoutineEditRepeatDependency, RoutineEditInteractorDependency{
    
    let routineId: UUID
    
    var routineApplicationService: RoutineApplicationService{ dependency.routineApplicationService }
    var routineRepository: RoutineRepository{ dependency.routineRepository }
    
    var title: ReadOnlyCurrentValuePublisher<String>{ titleSubject}
    lazy var titleSubject = CurrentValuePublisher<String>( routineRepository.currentRoutineDetail.value!.routineName )
    
    var description: ReadOnlyCurrentValuePublisher<String>{ descriptionSubject }
    lazy var descriptionSubject = CurrentValuePublisher<String>( routineRepository.currentRoutineDetail.value!.routineDescription )
    
    var repeatSegmentType: ReadOnlyCurrentValuePublisher<RepeatSegmentType>{ repeatSegmentTypeSubject }
    let repeatSegmentTypeSubject = CurrentValuePublisher<RepeatSegmentType>(.none)
    
    var repeatDoItOnceControlValue: ReadOnlyCurrentValuePublisher<Date>{ repeatDoItOnceControlValueSubject }
    var repeatDoItOnceControlValueSubject = CurrentValuePublisher<Date>( .init() )
    
    var repeatWeeklyControlValue: ReadOnlyCurrentValuePublisher<Set<Weekly>>{ repeatWeeklyControlValueSubject }
    let repeatWeeklyControlValueSubject = CurrentValuePublisher<Set<Weekly>>(.init())
    
    var repeatMonthlyControlValue: ReadOnlyCurrentValuePublisher<Set<Monthly>>{ repeatMonthlyControlValueSubject }
    let repeatMonthlyControlValueSubject = CurrentValuePublisher<Set<Monthly>>(.init())

    var tint: ReadOnlyCurrentValuePublisher<String>{ tintSubject }
    lazy var  tintSubject = CurrentValuePublisher<String>( routineRepository.currentRoutineDetail.value!.tint )
    
    var emoji: ReadOnlyCurrentValuePublisher<String>{ emojiSubject }
    lazy var  emojiSubject = CurrentValuePublisher<String>( routineRepository.currentRoutineDetail.value!.emojiIcon )
    
    init(
        dependency: RoutineEditDependency,
        routineId: UUID
    ) {
        self.routineId = routineId
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RoutineEditBuildable: Buildable {
    func build(withListener listener: RoutineEditListener, routineId : UUID) -> RoutineEditRouting
}

final class RoutineEditBuilder: Builder<RoutineEditDependency>, RoutineEditBuildable {

    override init(dependency: RoutineEditDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RoutineEditListener, routineId: UUID) -> RoutineEditRouting {
        let component = RoutineEditComponent(dependency: dependency, routineId: routineId)
        let viewController = RoutineEditViewController()
        let interactor = RoutineEditInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        
        let routineEditTitleBuilder = RoutineEditTitleBuilder(dependency: component)
        let routineTintBuilder = RoutineTintBuilder(dependency: component)
        let routineEmojiIconBuilder = RoutineEmojiIconBuilder(dependency: component)
        let routineEditRepeatBuilder = RoutineEditRepeatBuilder(dependency: component)
        
        return RoutineEditRouter(
            interactor: interactor,
            viewController: viewController,
            routineEditTitleBuildable: routineEditTitleBuilder,
            routineTintBuildable: routineTintBuilder,
            routineEmojiIconBuildable: routineEmojiIconBuilder,
            routineEditRepeatBuidlable: routineEditRepeatBuilder
        )
    }
}
