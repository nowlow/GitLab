//
//  CICanceledIcon.swift
//  GitLab
//
//  Created by Stef Kors on 22/06/2022.
//

import SwiftUI

struct CICanceledIcon: View {
    var body: some View {
        Image(systemName: "circle.slash")
            .foregroundColor(.gray)
            .font(.system(size: 18))
    }
}

struct CICanceledIcon_Previews: PreviewProvider {
    static var previews: some View {
        CICanceledIcon()
    }
}
