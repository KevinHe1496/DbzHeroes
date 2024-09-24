//
//  TranformationsListViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 19/9/24.
//

import UIKit

class TransformationsListViewController: UITableViewController {
    
    // MARK: - TableView DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, DbzCharacter>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, DbzCharacter>
    
    // MARK: - Model
    private let networkModel: NetworkModel
    private var dataSource: DataSource?
    
    // MARK: - Components
    // es la reudita cuando esta cargando la vista
    private var activiryIndicator: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - Initializers
    
    init(networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"
        tableView.backgroundView = activiryIndicator
        // registro mi cell creado
        tableView.register(
            UINib(nibName: TransformationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: TransformationTableViewCell.identifier)
        
        dataSource = DataSource(tableView: tableView) {  tableView, indexPath, character in
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TransformationTableViewCell.identifier,
                for: indexPath) as? TransformationTableViewCell else{
                return UITableViewCell()
            }
      
            // aqui pongo el titulo y el parrafo de cell
            cell.titleLabel.text = character.name
            cell.bodyLabel.text = character.description
            
            return cell
        }
        
        tableView.dataSource = dataSource
        
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        
        
        networkModel.getAllCharacters { [weak self] result in
            switch result{
                
            case let .success(characters):
                
                snapshot.appendItems(characters)
                self?.dataSource?.apply(snapshot)
            case .failure(_):
                break
            }
        }
        
    }
    
    
}


extension TransformationsListViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
