//
//  PersonajesListViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 14/9/24.
//

import UIKit

final class PersonajesListViewController: UITableViewController {
    
    //MARK: - TableView DataSource
    // manejar los datos y proveer celdas al tableview
    // vamos a representar objetos de tipos Razas
    typealias DataSource = UITableViewDiffableDataSource<Int,DbzCharacter>
    // esto nos ayuda a actualizar los datos de la tabla
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, DbzCharacter>
    
    //MARK: - Model
    
    private let networkModel: NetworkModel
    // inicialmente este valor es nulo
    private var dataSource: DataSource?
    
     
     
    // MARK: Components
    // es la reudita cuando esta cargando la vista
    private var activityIndicator: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - initializers
    init(networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes"
        tableView.backgroundView = activityIndicator
        
        //1. registrar nuestra celda
        // registramos nuestro celda que creamos
        tableView.register(UINib(nibName: PersonajesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PersonajesTableViewCell.identifier)
        //2. configurar el data source
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, character in
            // Obtenemos una celda reusable y la casteamos
            //a el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonajesTableViewCell.identifier, for: indexPath) as? PersonajesTableViewCell else{
                // si  no puede desempaquetar
                // retornamos un uitableviewcell vacio
                return UITableViewCell()
            }
            
            cell.titleLabel.text = character.name
            cell.bodyLabel.text = character.description
            return cell
        }
        //3. añadir el data source al table view
        tableView.dataSource = dataSource
        //4. crear un snapshot con los objetos a representar
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        
        //5. aplicar el snapshot al data source para añadir los objetos
        networkModel.getAllCharacters { result in
            switch result{
                
            case let .success(character):
                snapshot.appendItems(character)
                self.dataSource?.apply(snapshot)
            case .failure(_):
                break
            }
        }
        
    }
    
}

// MARK: - Table View Delagate
extension PersonajesListViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            // aqui obtenemos el personaje seleccionado del datasource
            guard let selectedCharacter = dataSource?.itemIdentifier(for: indexPath) else {
                return
            }


            // aqui instanciamos el DescriptionViewController y pasamos el personaje seleccionado
            let descriptionViewController = DescriptionViewController(character: selectedCharacter)
            
            // Navegar al nuevo controlador
            navigationController?.show(descriptionViewController, sender: self)
        

    }
}
