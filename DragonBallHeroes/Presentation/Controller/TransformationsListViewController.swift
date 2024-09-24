//
//  TranformationsListViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 19/9/24.
//

import UIKit

class TransformationsListViewController: UITableViewController {
    
    // MARK: - TableView DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, Transformation>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Transformation>
    
    // MARK: - Model
    private let networkModel: NetworkModel
    private var dataSource: DataSource?
    private let character: DbzCharacter
    // MARK: - Components
    // es la reudita cuando esta cargando la vista
    private var activityIndicator: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - Initializers
    
    init(character: DbzCharacter, networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"
        tableView.backgroundView = activityIndicator
        // registro mi cell creado
        tableView.register(
            UINib(nibName: TransformationTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: TransformationTableViewCell.identifier)
        
        dataSource = DataSource(tableView: tableView) {  tableView, indexPath, transformacion in
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TransformationTableViewCell.identifier,
                for: indexPath) as? TransformationTableViewCell else{
                return UITableViewCell()
            }
      
            // aqui pongo el titulo y el parrafo de cell
            cell.titleLabel.text = transformacion.name
            cell.bodyLabel.text = transformacion.description
            
            guard let url = URL(string: transformacion.photo) else{
                print("url invalido")
                return UITableViewCell()
            }
            cell.TransformacionImageView.setImage(url: url)
            
            return cell
        }
        
        tableView.dataSource = dataSource
        
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        
        
    //TODO: - Arreglar el transformacion list
        
        
        networkModel.getTransformations(for: character) { result in
            switch result{
                
            case let .success(transformation):
                snapshot.appendItems(transformation)
                self.dataSource?.apply(snapshot)
            case .failure(_):
                break
            }
        }
        
    }
    
    
}


extension TransformationsListViewController{
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
