//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Randhir Kumar on 21/05/20.
//  Copyright © 2020 Randhir Kumar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak private var searchTextfield: UITextField!
    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var celciusSegmentControl: UISegmentedControl!
  
    private var viewModel: SearchViewModel!
    let activityView = UIActivityIndicatorView(style: .large)
    
    private var searchText: String? {
        didSet {
            loadWeatherData()
        }
    }
    private var selectedIndex = 0 {
        didSet {
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCell()
        viewModel.loadWeatherDataFromDefaults(completion: {
            refreshUI()
        })
    }

    private func setup() {
        viewModel = SearchViewModel()
        searchTextfield.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        // Activity View
        activityView.color = .red
        activityView.center = self.view.center
        self.view.addSubview(activityView)

        // set table background image
        let imageView = UIImageView(image: UIImage(named: "blue_gradient"))
        imageView.frame = self.tableView.frame
        self.tableView.backgroundView = imageView
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: kWeatherCellIdentifiers, bundle: nil), forCellReuseIdentifier: kWeatherCellIdentifiers)
    }
    
    fileprivate func refreshUI() {
        tableView.reloadDataInMainQueue()
    }
    
    fileprivate func loadWeatherData() {
        guard let searchText = searchText, !searchText.isEmpty else {
            return
        }
        activityView.startAnimating()
        viewModel.loadWeatherData(cityName: searchText) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.showToast(message: "City Added", bottomMargin: 200)
            case let .failure(errorMsg: error):
                this.showToast(message: "Error: \(error)", bottomMargin: 200)
            }
            DispatchQueue.main.async {
                this.activityView.stopAnimating()
            }
            this.refreshUI()
        }
    }
    
    fileprivate func clearSearchTextField() {
        searchTextfield.text = ""
        searchText = ""
    }
    
    fileprivate func openWeatherDetails(data: WeatherModel) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let dest = storyBoard.instantiateViewController(identifier: kWeatherDetailsScreen) as? WeatherDetailVC else { return }
        dest.dataSource = data
        navigationController?.show(dest, sender: nil)
    }
    
    // MARK:- Show Toast
    private func showToast(message: String, bottomMargin: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.viewWithTag(9999)?.removeFromSuperview()
            let toastLabel = UILabel(frame: CGRect(x: 20, y: ScreenSize.SCREEN_HEIGHT - bottomMargin, width: self.view.frame.size.width - 40, height: 60))
            toastLabel.tag = 9999
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont.systemFont(ofSize: 15)
            toastLabel.text = message
            
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.numberOfLines = 0
            toastLabel.clipsToBounds = true
            self.view.addSubview(toastLabel)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.removeToast(label: toastLabel)
            }
        }
    }
    
    func removeToast(label:UILabel) -> Void {
        label.removeFromSuperview()
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
    }
    @IBAction func searchTapped(_ sender: UIButton) {
        searchTextfield.resignFirstResponder()
        loadWeatherData()
    }
}

// MARK: Textfield delegate method
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        clearSearchTextField()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchText = textField.text
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.resignFirstResponder()
        return true
    }
}

// MARK: TableView delegate and datasource method
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNoOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kWeatherCellIdentifiers, for: indexPath) as! WeatherTableViewCell
        let data = viewModel.getWeatherData(atIndex: indexPath.row)
        
        
        let temperature = celciusSegmentControl.selectedSegmentIndex == 0 ? data?.main?.temperatureInCelsius : data?.main?.temperatureInFahren
        let currentTime = viewModel.getCurrentTime()
        cell.configCell(timeText: currentTime, regionText: data?.name ?? "", temperature: temperature ?? "", bgImage: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = viewModel.getWeatherData(atIndex: indexPath.item)
        guard let data = selectedData else {
            return
        }
        openWeatherDetails(data: data)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
      
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
            viewModel.deleteWeatherData(atIndex: indexPath.item) {
                refreshUI()
            }
          }
      }
}
