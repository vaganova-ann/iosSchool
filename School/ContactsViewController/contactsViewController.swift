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
    
    private var dataSourse: ContactsTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sections = generateModels()
        dataSourse = ContactsTableViewDataSource(sections: sections)
        
        tableView.dataSource = dataSourse
        tableView.delegate = dataSourse
        
        let personCellNib = UINib(nibName: PersonTableViewCell.className, bundle: Bundle.main)
        let animalCellNib = UINib(nibName: AnimalTableViewCell.className, bundle: Bundle.main)
        
        tableView.register(personCellNib, forCellReuseIdentifier: PersonTableViewCell.className)
        tableView.register(animalCellNib, forCellReuseIdentifier: AnimalTableViewCell.className)
    }
    
    func generateModels() -> [Section] {
        
        var modelsPerson: [Person] = []
        for (index, name) in PersonNames.enumerated() {
            let person = Person(name: name, portrait: UIImage.portraitImageWithNumber(index))
            modelsPerson.append(person)
                }
        
        var modelsAnimal: [Animal] = []
        for (index, name) in AnimalNames.enumerated() {
            let animal = Animal(name: name, image: UIImage.animalImageWithNumber(index))
            modelsAnimal.append(animal)
                }
        
        var sections: [Section] = []
        sections.append(Section(header: "These are people!", models: modelsPerson))
        sections.append(Section(header: "These are animals!", models: modelsAnimal))
        
        return sections
    }
}


