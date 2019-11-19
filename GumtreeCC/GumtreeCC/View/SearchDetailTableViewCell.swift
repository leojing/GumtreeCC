//
//  SearchDetailTableViewCell.swift
//  GumtreeCC
//
//  Created by Jing LUO on 19/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit

class SearchDetailTableViewCell: UITableViewCell {

    typealias ClearActionHandler = (_ index: IndexPath) -> Void

    @IBOutlet private weak var searchDetailLabel: UILabel!

    private var clearAction: ClearActionHandler?
    var index: IndexPath? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static func reuseId() -> String {
        return String(describing: self)
    }

    func configureCell(_ searchDetailText: String?, _ clearAction: ClearActionHandler?) {
        guard let searchDetailText = searchDetailText else {
            return
        }
        searchDetailLabel.text = searchDetailText
        self.clearAction = clearAction
    }

    @IBAction func clearTapped(_ sender: UIButton) {
        if let index = index {
            clearAction?(index)
        }
    }
}
