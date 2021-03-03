//
//  ViewController.swift
//  TextureSample
//
//  Created by Elijah Semyonov on 03.03.2021.
//

import AsyncDisplayKit

class TestCellNode: ASCellNode {
    private let index: Int
    private let indexTextNode = ASTextNode()
    private let descriptionNode = ASTextNode()
    private let layoutSpec: ASLayoutSpec

    init(index: Int) {
        self.index = index
        
        let insets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

        let extraNode = ASDisplayNode()
        extraNode.backgroundColor = .green
        
        indexTextNode.attributedText = NSAttributedString(
                string: "\(index)",
                attributes: [
                    .font: UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 12.0), maximumPointSize: 18.0)
                ]
        )

        descriptionNode.attributedText = NSAttributedString(
                string: "Some description",
                attributes: [
                    .font: UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 10.0), maximumPointSize: 16.0),
                ]
        )

        let verticalStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 12.0,
                justifyContent: .center,
                alignItems: .start,
                children: [
                    ASRatioLayoutSpec(ratio: 0.5, child: extraNode),
                    indexTextNode,
                    descriptionNode
                ]
        )
        
        layoutSpec = ASInsetLayoutSpec(insets: insets, child: verticalStack)

        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        layoutSpec
    }
}

class TestNode: ASTableNode, ASTableDataSource, ASTableDelegate {
    init() {
        super.init(style: .plain)

        dataSource = self
        delegate = self
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        {
            TestCellNode(index: indexPath.row)
        }
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        300        
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        .init(min: .init(width: 0.0, height: 50.0), max: .init(width: 0.0, height: 300.0))
    }

    func numberOfSections(in tableNode: ASTableNode) -> Int {
        1
    }
}

class TestViewController: ASDKViewController<TestNode> {
    override init() {
        super.init(node: .init())
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class MainViewController: ASNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        pushViewController(TestViewController(), animated: false)
    }
}

