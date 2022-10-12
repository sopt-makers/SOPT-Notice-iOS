//
//  UIFont+.swift
//  DSKit
//
//  Created by 양수빈 on 2022/10/13.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

extension UIFont {
    @nonobjc public class var h1: UIFont {
        return DSKitFontFamily.Suit.extraBold.font(size: 32)
    }
    
    @nonobjc public class var h2: UIFont {
        return DSKitFontFamily.Suit.bold.font(size: 24)
    }

    @nonobjc public class var h3: UIFont {
        return DSKitFontFamily.Suit.bold.font(size: 20)
    }
    
    @nonobjc public class var h4: UIFont {
        return DSKitFontFamily.Suit.bold.font(size: 18)
    }
    
    @nonobjc public class var h5: UIFont {
        return DSKitFontFamily.Suit.medium.font(size: 18)
    }

    @nonobjc public class var subtitle1: UIFont {
        return DSKitFontFamily.Suit.bold.font(size: 16)
    }

    @nonobjc public class var subtitle2: UIFont {
        return DSKitFontFamily.Suit.medium.font(size: 16)
    }

    @nonobjc public class var body1: UIFont {
        return DSKitFontFamily.Suit.regular.font(size: 16)
    }

    @nonobjc public class var body2: UIFont {
        return DSKitFontFamily.Suit.medium.font(size: 14)
    }

    @nonobjc public class var caption: UIFont {
        return DSKitFontFamily.Suit.regular.font(size: 12)
    }
}

