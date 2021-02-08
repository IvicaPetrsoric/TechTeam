//
//  EmployeesCollectionViewController+HeaderCell.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit

extension EmployeesCollectionViewController {
    
    func registerHeaderCell() {
        collectionView.register(EmployeeHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath)
            return header
        } else {
            fatalError("Error with header cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = employeeListViewModel.numberOfItemsInSection() > 0 ? 0 : collectionView.frame.width * 1.5
        return .init(width: collectionView.frame.width, height: height)
    }
    
}
