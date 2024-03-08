//
//  BoxChartView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import SwiftUI
import DGCharts

struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = DGCharts.LineChartView
    
    @Binding var chartEntries: [DGCharts.ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> DGCharts.LineChartView {
        let lineChartView = DGCharts.LineChartView()
        
        setupLineChartView(chartView: lineChartView)
        
        return lineChartView
    }
    
    func updateUIView(_ uiView: DGCharts.LineChartView, context: Context) {
        
    }
    
    private func setupLineChartView(chartView: DGCharts.LineChartView) {
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.xAxis.granularity = 1
        chartView.xAxis.labelPosition = .bottom
        chartView.rightAxis.enabled = false
        chartView.xAxis.valueFormatter = DateAxesValueFormatter(dates: dates)
        chartView.leftAxis.axisLineColor = .orange
        chartView.animate(yAxisDuration: 1.0)
        chartView.data = addData()
    }
    
    private func addData() -> DGCharts.LineChartData {
        let dataSet = DGCharts.LineChartDataSet(entries: chartEntries, label: "Xablau Graph")
        
        setupDataSet(dataSet)
        
        let dataSetArray: [ChartDataSetProtocol] = [dataSet]
        
        return DGCharts.LineChartData(dataSets: dataSetArray)
    }
    
    private func setupDataSet(_ dataSet: LineChartDataSet) {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let colorLocations: [CGFloat] = [0.0, 0.1]
        
        let gradientToFill = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        )
        
        if dataSet.isDrawLineWithGradientEnabled {
            dataSet.lineDashLengths = nil
            dataSet.highlightLineDashLengths = nil
            dataSet.setColors(.black, .red, .white)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = [0, 40, 100]
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = nil
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        } else {
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColor(.orange)
            dataSet.setCircleColor(.orange)
            dataSet.gradientPositions = nil
            dataSet.lineWidth = 2
            dataSet.circleRadius = 4
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
            dataSet.mode = .cubicBezier
            dataSet.drawFilledEnabled = true
            dataSet.drawHorizontalHighlightIndicatorEnabled = false
            if let gradient = gradientToFill {
                dataSet.fill = DGCharts.LinearGradientFill(gradient: gradient, angle: 90.0)
            }
        }
    }
}

class DateAxesValueFormatter: IndexAxisValueFormatter {
    
    let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
        super.init()
    }
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        
        if position > 0 && position < dates.count {
            let dateFormatter = getDateFormatter(pattern: Date.DatesPatterns.YYYYMMDDTHHMMSS)
            
            let date = dateFormatter.date(from: dates[position])
            
            guard let date = date else {
                return ""
            }
            
            let dateFormatterResumed = getDateFormatter(pattern: Date.DatesPatterns.DDMM)
            return dateFormatterResumed.string(from: date)
        } else {
            return  ""
        }
    }
    
}

struct BoxChartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            BoxChartView(
                chartEntries:
                        .constant([
                            ChartDataEntry(x: 1.0, y: 1.0),
                            ChartDataEntry(x: 2.0, y: 4.0),
                            ChartDataEntry(x: 3.0, y: 2.4)
                        ]
                                 ),
                dates:
                        .constant([
                            "01/03/2024",
                            "02/03/2024",
                            "03/03/2024"
                        ]
                                 )
            )
            .frame(maxWidth: .infinity, maxHeight: 350)
            .preferredColorScheme($0)
        }
    }
}
