import UIKit

typealias TapHandler = (Int, Int) -> ()

class GridView: UIView {
    let board: BoardState
    var tapHandler: TapHandler?
    
    private var boardWidth: CGFloat {
        return min(bounds.width, bounds.height)
    }
    
    private var cellCount: Int {
        return board.width + 1
    }
    
    private var cellSize: CGFloat {
        return boardWidth / CGFloat(cellCount)
    }

    lazy var tapper: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        recognizer.numberOfTapsRequired = 1
        return recognizer
    }()
    
    init(frame: CGRect, board: BoardState) {
        self.board = board
        super.init(frame: frame)
        self.addGestureRecognizer(tapper)
        self.backgroundColor = UIColor(displayP3Red: 255/255, green: 226/225, blue: 154/255, alpha: 1)
    }
    
    func setHandler(handler: @escaping TapHandler) {
        self.tapHandler = handler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func tapped(recognizer: UITapGestureRecognizer) {
        let locationOfTap = recognizer.location(in: self)
        let tappedColumn = Int((locationOfTap.x - cellSize) / cellSize + 0.5)
        let tappedRow = Int((locationOfTap.y - cellSize) / cellSize + 0.5)
        self.tapHandler?(tappedRow, tappedColumn)
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        
        for i in 1..<cellCount {
            let xPos = CGFloat(i) * cellSize
            path.move(to: CGPoint(x: xPos, y: cellSize))
            path.addLine(to: CGPoint(x: xPos, y: boardWidth - cellSize))
        }
        
        for i in 1..<cellCount {
            let yPos = CGFloat(i) * cellSize
            path.move(to: CGPoint(x: cellSize, y: yPos))
            path.addLine(to: CGPoint(x: boardWidth - cellSize, y: yPos))
        }
        path.lineWidth = 1
        path.stroke()
        
        for col in 0..<board.width {
            for row in 0..<board.height {
                let (stone, _) = board.get(at: Intersection(row, col))
                if stone != Player.empty {
                    let stonePath = UIBezierPath()
                    stone == Player.white ? UIColor.white.set() : UIColor.black.set()
                    let point = CGPoint(x: CGFloat(col + 1)*cellSize, y: CGFloat(row + 1)*cellSize + 1)
                    let stoneRadius = cellSize/2.5
                    stonePath.move(to: point)
                    stonePath.addArc(withCenter: point, radius: stoneRadius, startAngle: 0, endAngle: .pi * 2.0, clockwise: true)
                    stonePath.fill()
                }
            }
        }

    }
}
