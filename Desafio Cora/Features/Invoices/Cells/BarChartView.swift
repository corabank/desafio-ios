//
//  BarChartView.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 19/05/22.
//

import UIKit

protocol BarChartViewDelegate: AnyObject {
    func barClicked(barIndex: Int)
}

class BarChartView: UIView {
    weak var delegate: BarChartViewDelegate?

    // MARK: - Private vars
    private let TAG = 1_000

    private var data = [Chart]()
    private var tapRecognizer: UITapGestureRecognizer

    private var barColor = UIColor.secondaryLight

    private var maxY: Double {
        let newArray = data.map { item in
            item.value
        }
        return newArray.max() ?? 0
    }

    private var barGap: CGFloat {
        CGFloat(0.2) / CGFloat(data.count - 1)
    }

    private var barWidth: CGFloat {
        CGFloat(0.8) / CGFloat(data.count)
    }

    private var barCornerRadius: CGFloat {
        CGFloat(50 / data.count)
    }

    override init(frame: CGRect) {
        tapRecognizer = UITapGestureRecognizer(target: nil, action: #selector(handleBarTap))
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeGestureRecognizer(tapRecognizer)
    }

    private func clearViews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }

    private func createChart() {
        var lastBar: UIView?

        for (index, dataPoint) in data.enumerated() {
            let label = UILabel()
            label.text = dataPoint.month
            label.textColor = .white
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)

            let barView = createBarView(barNumber: index, barValue: dataPoint.value)

            if let lastBar = lastBar {
                let gapView = createGapView(lastBar: lastBar)
                barView.leftAnchor.constraint(equalTo: gapView.rightAnchor).isActive = true
                label.leftAnchor.constraint(equalTo: gapView.rightAnchor).isActive = true
            } else {
                barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
                label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            }

            if index == data.count - 1 {
                barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
                label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            }

            label.rightAnchor.constraint(equalTo: barView.rightAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            barView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8).isActive = true

            barView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(dataPoint.value / maxY) * 0.8).isActive = true

            lastBar = barView
        }
    }

    private func createBarView(barNumber: Int, barValue: Double) -> UIView {
        let barView = UIView()
        addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.widthAnchor.constraint( equalTo: widthAnchor, multiplier: barWidth).isActive = true

        barView.tag = barNumber + TAG
        barView.backgroundColor = barColor
        barView.layer.cornerRadius = barCornerRadius
        return barView
    }

    private func createGapView(lastBar: UIView) -> UIView {
        let gapView = UIView()
        addSubview(gapView)
        gapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gapView.heightAnchor.constraint(equalToConstant: 1.0),
            gapView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gapView.widthAnchor.constraint( equalTo: widthAnchor, multiplier: barGap),
            gapView.leftAnchor.constraint(equalTo: lastBar.rightAnchor)
        ])
        return gapView
    }

    @objc
    private func handleBarTap() {
        if let hitView = tapRecognizer.view {
            let loc = tapRecognizer.location(in: self)
            if let barViewTapped = hitView.hitTest(loc, with: nil) {
                for barView in subviews where barView.tag >= TAG {
                    barView.backgroundColor = barView.tag == barViewTapped.tag ? barColor.withAlphaComponent(0.4) : barColor
                    delegate?.barClicked(barIndex: barView.tag - TAG)
                }
            }
        }
    }

    func setData(_ dataPoints: [Chart]) {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBarTap))
        addGestureRecognizer(tapRecognizer)
        backgroundColor = UIColor.clear
        self.data = dataPoints
        clearViews()
        guard maxY > 0.0 else { return }
        createChart()
    }
}
