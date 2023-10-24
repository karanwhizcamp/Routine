//
//  TimerNextSectionBuilder.swift
//  Routine
//
//  Created by 한현규 on 10/18/23.
//

import ModernRIBs

protocol TimerNextSectionDependency: Dependency {
    var detail: TimerDetailModel{ get }
    var timer: AppTimer{ get }
    var model: BaseTimerModel{ get }
}

final class TimerNextSectionComponent: Component<TimerNextSectionDependency>, TimerNextSectionInteractorDependency {
    
    var timer: AppTimer{ dependency.timer }
    var model: BaseTimerModel{ dependency.model }
    var detail: TimerDetailModel{ dependency.detail }
    
    
}

// MARK: - Builder

protocol TimerNextSectionBuildable: Buildable {
    func build(withListener listener: TimerNextSectionListener) -> TimerNextSectionRouting
}

final class TimerNextSectionBuilder: Builder<TimerNextSectionDependency>, TimerNextSectionBuildable {

    override init(dependency: TimerNextSectionDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TimerNextSectionListener) -> TimerNextSectionRouting {
        let component = TimerNextSectionComponent(dependency: dependency)
        let viewController = TimerNextSectionViewController()
        let interactor = TimerNextSectionInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return TimerNextSectionRouter(interactor: interactor, viewController: viewController)
    }
}
