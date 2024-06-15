import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, 
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))

        return Path(path.cgPath)
    }
}

extension View {
    func roundedCornerWithBorder(lineWidth: CGFloat, 
                                 borderColor: Color,
                                 radius: CGFloat,
                                 corners: UIRectCorner) -> some View {

        clipShape(RoundedCorner(radius: radius, corners: corners) )
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(borderColor, lineWidth: lineWidth))
    }
}

extension View {
    func roundedCornerFill(borderColor: Color,
                           radius: CGFloat,
                           corners: UIRectCorner) -> some View {

        clipShape(RoundedCorner(radius: radius, corners: corners) )
            .background(RoundedCorner(radius: radius, corners: corners)
                .fill(borderColor))
    }
}
