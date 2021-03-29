//
//  contactsViewController.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

class contactsViewController: UIViewController {
    
    private var PersonNames: [String] =
        ["Addie Davis",
         "Gayle Park",
         "Lesley Mills",
         "Elton Hernandez",
         "Melvin Mayer",
         "Trina Roberts",
         "Lindsay West",
         "Toby Bauer",
         "Laurel Simon",
         "Eugenia Blair",
         "Martha Marquez",
         "Fritz Keller"]
    
    private var AnimalNames: [String] = ["Cat", "Dog", "Cow", "Rabbit", "Lion"]
    
    
    @IBOutlet private var tableView: UITableView!
    
    private var dataSourse: PersonTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let models = generateModels()
        dataSourse = PersonTableViewDataSource(models: models)
        
        tableView.dataSource = dataSourse
        tableView.delegate = dataSourse
        
        let personCellNib = UINib(nibName: PersonTableViewCell.className, bundle: nil)
        // регестр ячейку под животных
            tableView.register(personCellNib, forCellReuseIdentifier: PersonTableViewCell.className)
    }
    
    func generateModels() -> [Person] {
        var models:[Person] = []
        
        for index in 0..<names.count {
            let person = Person(name: names[index], portrait: UIImage.portraitImageWithNumber(index))
            models.append(person)
        }
        return models
    }
}


