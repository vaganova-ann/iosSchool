//
//  personTableViewDataSource.swift
//  School
//
//  Created by Студент 2 on 26.03.2021.
//

import UIKit


struct Section {
    var header: String
    var models: [CellConfigurator]
}

class ContactsTableViewDataSource: NSObject {
    
    private var sections: [Section]
    
    internal init(sections: [Section]) {
        self.sections = sections
        
    }
}

extension ContactsTableViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section].models[indexPath.row]
        
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: model.reuseIndentifier)
        
        guard let cell = dequeuedCell as? ConfigurableRow else {
            return UITableViewCell()
        }
        return cell.configureWith(model)
    }
}

extension ContactsTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
