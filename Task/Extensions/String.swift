//
//  String.swift
//  Task
//
//  Created by Victor Mendes on 03/11/21.
//

import Foundation

extension String {
    func convertDate(format: DueDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        guard let dateRevert = formatter.date(from: self) else { return "" }
        let date = Date()
        
        switch format {
        case .today:
            formatter.dateFormat = "Hoje às HH:mm"
        case .week:
            formatter.dateFormat = "dd/MM 'às' HH:mm"
        case .month:
            formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm:"
        }
        
        let dateConverted = formatter.string(from: dateRevert)
        return dateConverted.description
    }
}

let str = "03/10/1997"
//str.convertDate(format: .)
