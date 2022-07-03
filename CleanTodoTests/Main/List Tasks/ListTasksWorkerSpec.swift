//
//  ListTasksWorkerSpec.swift
//  CleanTodoTests
//
//  Created by Zaim Ramlan on 11/01/2019.
//  Copyright © 2019 zaimramlan. All rights reserved.
//

import Quick
import Nimble
@testable import CleanTodo

class ListTasksWorkerSpec: QuickSpec {
    override func spec() {
        
        // MARK: - Subject Under Test (SUT)
        
        var sut: ListTasksWorker!
        
        // MARK: - Test Doubles
        
        // MARK: - Test Setup Helpers
        
        func setupWorker() {
            sut = ListTasksWorker()
        }
        
        // MARK: - Tests
        
        beforeEach {
            setupWorker()
        }
        
        describe("fetch from data store") {
            it("should return an array of string", closure: {
                let tasks = sut.fetchFromDataStore()
                expect(tasks).to(beAnInstanceOf(Array<String>.self))
                expect(tasks).notTo(beEmpty())
            })
        }
        
        describe("remove task") {
            context("task to remove is in the task list", closure: {
                it("should remove the task and return the remaining tasks", closure: {
                    let taskToRemove = Seeds.tasks.first!
                    let tasks = sut.removeTask(taskToRemove, from: Seeds.tasks)
                    expect(tasks.count).to(equal(Seeds.tasks.count - 1))
                    expect(tasks).notTo(contain(taskToRemove))
                })
            })
            
            context("task to remove not in the task list", closure: {
                it("should return the same task list", closure: {
                    let taskToRemove = ""
                    let tasks = sut.removeTask(taskToRemove, from: Seeds.tasks)
                    expect(tasks.count).to(equal(Seeds.tasks.count))
                    expect(tasks).to(equal(Seeds.tasks))
                })
            })
        }
    }
}
