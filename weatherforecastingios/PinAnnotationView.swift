/*
 *     Copyright 2016,2017,2018 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */

import MapKit

class PinAnnotationView: MKPinAnnotationView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        if hitView != nil {
            self.superview?.bringSubviewToFront(self)
        }
        return hitView
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        let rect = self.bounds
        var isInside = rect.contains(point)

        if !isInside {
            for subview in self.subviews {
                isInside = subview.frame.contains(point)

                if isInside {
                    break
                }
            }
        }
        return isInside
    }
}
