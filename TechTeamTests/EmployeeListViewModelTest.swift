//
//  EmployeeListViewModelTest.swift
//  TechTeamTests
//
//  Created by Ivica Petrsoric on 09/02/2021.
//

import XCTest
@testable import TechTeam

class EmployeeListViewModelTest: XCTestCase {
    
    var employeeListViewModel: EmployeeListViewModel!
    
    let employees = [
        Employee(department: "deparment", name: "name", surname: "surname", image: "image", title: "title", agency: "agency", intro: "intro", description: "description")
    ]

    let index = 0
    var employeeViewModel: EmployeeViewModel!

    override func setUp() {
        employeeListViewModel = EmployeeListViewModel(employees)
        employeeViewModel = employeeListViewModel.getEmployeeAt(index)
    }
    
    func test_employeeListViewModelCount() {
        XCTAssertEqual(employeeListViewModel.numberOfItemsInSection(), 1)
    }
    
    func test_employeeViewModelDepartment() {
        XCTAssertEqual(employeeViewModel.departmentValue, employees[index].department?.uppercased())
    }
    
    func test_employeeViewModelName() {
        XCTAssertEqual(employeeViewModel.nameValue, employees[index].name)
    }
    
    func test_employeeViewModelSurname() {
        XCTAssertEqual(employeeViewModel.surnameValue, employees[index].surname)
    }
    
    func test_employeeViewModelImage() {
        XCTAssertEqual(employeeViewModel.imageValue, employees[index].image)
    }
    
    func test_employeeViewModelTitle() {
        XCTAssertEqual(employeeViewModel.titleValue, employees[index].title)
    }
    
    func test_employeeViewModelAgency() {
        XCTAssertEqual(employeeViewModel.agencyValue, employees[index].agency)
    }
    
    func test_employeeViewModelIntro() {
        XCTAssertEqual(employeeViewModel.introValue, employees[index].intro)
    }
    
    func test_employeeViewModelDescription() {
        XCTAssertEqual(employeeViewModel.descriptionValue, employees[index].description)
    }

}
