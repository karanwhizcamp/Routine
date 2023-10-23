//
//  AddYourTimerRouter.swift
//  Routine
//
//  Created by 한현규 on 10/17/23.
//

import ModernRIBs

protocol AddYourTimerInteractable: Interactable, TimerSectionEditListener, TimerEditTitleListener, TimerSectionListListener {
    var router: AddYourTimerRouting? { get set }
    var listener: AddYourTimerListener? { get set }
}

protocol AddYourTimerViewControllable: ViewControllable {
    func addEditTitle(_ view: ViewControllable)
    func addSectionLists(_ view: ViewControllable)
}

final class AddYourTimerRouter: ViewableRouter<AddYourTimerInteractable, AddYourTimerViewControllable>, AddYourTimerRouting {

    private let timerEditTitleBuildable: TimerEditTitleBuildable
    private var timerEditTitleRouting: TimerEditTitleRouting?
    
    private let timerSectionListBuildable: TimerSectionListBuildable
    private var timerSectionListRouting: TimerSectionListRouting?
    
    private let timerSectionEditBuildable: TimerSectionEditBuildable
    private var timerSectionEditRouting: TimerSectionEditRouting?
    
    init(
        interactor: AddYourTimerInteractable,
        viewController: AddYourTimerViewControllable,
        timerEditTitleBuildable: TimerEditTitleBuildable,
        timerSectionListBuildable: TimerSectionListBuildable,
        timerSectionEditBuildable: TimerSectionEditBuildable
    ) {
        self.timerEditTitleBuildable = timerEditTitleBuildable
        self.timerSectionListBuildable = timerSectionListBuildable
        self.timerSectionEditBuildable = timerSectionEditBuildable
                
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    
    func attachTimerSectionEdit(sectionList: TimerSectionListViewModel) {
        if timerSectionEditRouting != nil{
            return
        }
        
        let router = timerSectionEditBuildable.build(withListener: interactor, sectionList: sectionList)
        viewController.pushViewController(router.viewControllable, animated: true)
        
        timerSectionEditRouting = router
        attachChild(router)
    }
    
    func detachTimerSectionEdit() {
        guard let router = timerSectionEditRouting else { return }
        
        detachChild(router)
        timerSectionEditRouting = nil
    }
    
    func attachTimerEditTitle() {
        if timerEditTitleRouting != nil{
            return
        }
        
        
        let router = timerEditTitleBuildable.build(withListener: interactor)
        viewController.addEditTitle(router.viewControllable)
        
        timerEditTitleRouting = router
        attachChild(router)
    }
    
    func attachTimerSectionListection() {
        if timerSectionListRouting != nil{
            return
        }
        
        let router = timerSectionListBuildable.build(withListener: interactor)
        viewController.addSectionLists(router.viewControllable)
        
        timerSectionListRouting = router
        attachChild(router)
    }

}
