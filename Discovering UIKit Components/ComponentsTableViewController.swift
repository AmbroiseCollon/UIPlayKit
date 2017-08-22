//
//  TableViewController.swift
//  Discovering UIKit Components
//
//  Created by Ambroise COLLON on 23/06/2017.
//  Copyright © 2017 Ambroise Collon. All rights reserved.
//

import UIKit

class ComponentsTableViewController: UITableViewController, UITextFieldDelegate {
    let sectionTitles = ["Générique", "Présentation", "Interaction Basique", "Sélecteurs", "Chargement"]

    override func viewDidLoad() {
        super.viewDidLoad()
        populateScrollView()
        animateProgressView()
        updateDateLabel(with: Date())
        hideKeyboardWhenTappedAround()
    }

    //MARK: - UIScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    func populateScrollView() {
        scrollView.contentSize = CGSize(width: 50*10, height: 50*10)

        for i in 0..<10 {
            for j in 0..<10 {
                if (i % 2 == 0 && j % 2 == 1) || (i % 2 == 1 && j % 2 == 0) {
                    let view = UIView(frame: CGRect(
                        origin: CGPoint(x: 50*i, y:50*j),
                        size: CGSize(width: 50, height: 50)))
                    view.backgroundColor = .customLightBlue
                    scrollView.addSubview(view)
                }
            }
        }
    }


    //MARK: - UIButton
    @IBOutlet weak var buttonDescriptionLabel: UILabel!
    @IBAction func tapButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.buttonDescriptionLabel.alpha = 0
        }) { (completed) in
            if completed {
                UIView.animate(withDuration: 0.2, animations: { 
                    self.buttonDescriptionLabel.alpha = 1
                })
            }
        }
    }

    //MARK: - UITextField
    @IBOutlet weak var textfieldDescriptionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func editingTextField(_ sender: UITextField) {
        textfieldDescriptionLabel.text = "text = \"\(sender.text!)\"\nplaceholder = \"Ecrivez ce que vous voulez\""
    }

    //MARK: - UISwitch
    @IBOutlet weak var switchDescriptionLabel: UILabel!
    @IBAction func switchChanged(_ sender: UISwitch) {
        let text = sender.isOn ? "true" : "false"
        switchDescriptionLabel.text = "action = Value Changed\nisOn = " + text
    }

    //MARK: - UISegmentedControl
    @IBOutlet weak var segmentedControlDescriptionLabel: UILabel!
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        segmentedControlDescriptionLabel.text = "action = Value Changed\nselectedSegmentIndex = \(sender.selectedSegmentIndex)"
    }

    //MARK: - UISlider
    @IBOutlet weak var sliderDescriptionLabel: UILabel!
    @IBAction func sliderChanged(_ sender: UISlider) {
        sliderDescriptionLabel.text = String(format: "action = Value Changed\nvalue = %.1f", sender.value)
    }

    //MARK: - UIStepper
    @IBOutlet weak var stepperDescriptionLabel: UILabel!
    @IBAction func stepperChanged(_ sender: UIStepper) {
        stepperDescriptionLabel.text = "stepValue = 1 / minimumValue = 0 / maximumValue = 10 / value = \(sender.value)"
    }

    //MARK: - UIDatePickerView
    @IBOutlet weak var datePickerDescriptionLabel: UILabel!
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDateLabel(with: sender.date)
    }
    func updateDateLabel(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let string = dateFormatter.string(from: date)
        datePickerDescriptionLabel.text = "action = Value Changed\ndate = " + string
    }

    //MARK: - UIProgressView
    @IBOutlet weak var progressViewDescriptionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    func animateProgressView() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            var progress = self.progressView.progress
            if progress < 1 {
                progress += 0.01
            } else {
                progress = 0
            }
            self.progressView.progress = progress
            self.progressViewDescriptionLabel.text = String(format: "progress = %.0f%%", progress * 100)
        }
    }

    //MARK: - TableView
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(
            origin: CGPoint.zero,
            size: CGSize(width: tableView.frame.width, height: tableView.sectionHeaderHeight)))
        view.backgroundColor = UIColor.customDarkBlue

        let label = UILabel(frame: view.frame)
        label.text = sectionTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center

        view.addSubview(label)
        return view
    }
}
