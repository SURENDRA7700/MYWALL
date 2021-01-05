//
//  ImageSlidingLayout.swift
//  8020
//
//  Created by Vijesh on 06/08/2018.
//  Copyright © 2018 DNet. All rights reserved.
//

import Foundation
import UIKit


class ImageSlidingLayout: UICollectionViewFlowLayout {
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        if let offset = collectionView?.contentOffset {
            if offset.y < 0 {
                let deltaY = fabs(offset.y)
                for attributes in layoutAttributes {
                    if let elementKind = attributes.representedElementKind {
                        if elementKind == UICollectionView.elementKindSectionHeader {
                            var frame = attributes.frame
                            frame.size.height = max(0, headerReferenceSize.height + deltaY)
                            frame.origin.y = frame.minY - deltaY
                            attributes.frame = frame
                        }
                    }
                }
            }
        }
        
        return layoutAttributes
    }
}
