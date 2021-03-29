//
//  personTableViewDataSource.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit

class PersonTableViewDataSource: NSObject {
    private var models: [Person]
    private var animals: [Animal]
    
    
    
    internal init(models: [Person]) {
        self.models = models
    }
}

extension PersonTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.className)
        
        guard let cell = dequeuedCell as? PersonTableViewCell else {
            return UITableViewCell()
        }
        // доп секция для животных и смотря какой индетефайр
        let model = models[indexPath.row]
        
        return cell.configureWith(model)
    }
}

extension PersonTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
