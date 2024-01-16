//
//  TimerEditMinutesBuilder.swift
//  Routine
//
//  Created by 한현규 on 1/16/24.
//

import ModernRIBs

protocol TimerEditMinutesDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TimerEditMinutesComponent: Component<TimerEditMinutesDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TimerEditMinutesBuildable: Buildable {
    func build(withListener listener: TimerEditMinutesListener, minutes: Int) -> TimerEditMinutesRouting
}

final class TimerEditMinutesBuilder: Builder<TimerEditMinutesDependency>, TimerEditMinutesBuildable {

    override init(dependency: TimerEditMinutesDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TimerEditMinutesListener, minutes: Int) -> TimerEditMinutesRouting {
        let component = TimerEditMinutesComponent(dependency: dependency)
        let viewController = TimerEditMinutesViewController()
        let interactor = TimerEditMinutesInteractor(presenter: viewController, minutes: minutes)
        interactor.listener = listener
        return TimerEditMinutesRouter(interactor: interactor, viewController: viewController)
    }
}
