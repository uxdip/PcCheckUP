//
//  GraphViewController.swift
//  PcCheckUP
//
//  Created by MD SAZID HASAN DIP on 23/3/22.
//

import Cocoa
import Charts
import TinyConstraints

class GraphViewController: NSViewController {
    
    internal static func instantiate() -> NSViewController {
        
        let vc = NSStoryboard(name: "Main", bundle: nil).instantiateController(identifier: NSStoryboard.SceneIdentifier("GraphViewController")) { coder in
            
            GraphViewController(coder: coder, text: GraphViewController.description())
        }
        
        return vc
    }
    
    private var isLoadButtonPressed:Bool?{
        didSet{
            chartTitle = isLoadButtonPressed! ? "AVERAGE LOAD" : "AVERAGE MATCH FACTOR"
        }
    }
    private var chartTitle:String?
    private var timer: Timer? = nil
    private var dataEntries = [ChartDataEntry]()
    
    private var xValue: Double = 8
    
    private lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        let yAxis = chartView.leftAxis
        
        yAxis.labelPosition = .outsideChart
        
        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    
    
    @IBOutlet weak var graphContainerView: NSView!
    
    init?(coder:   NSCoder,
          text:    String) { // receive here the injection information
        print(text) // use the injection information here
        super.init(coder: coder)
    }
    
    // Not used, but required
    required init?(coder:   NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear() {
        timer?.invalidate()
    }
    
    @IBAction func loadButtonPressed(_ sender: NSButton) {
        self.isLoadButtonPressed = true
        checkTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    

    
    @IBAction func matchFactorButtonPressed(_ sender: NSButton) {
        self.isLoadButtonPressed = false
        checkTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        
        var avg = 0.0
        if isLoadButtonPressed! {
            let loadAverage = System.loadAverage()
            avg = (loadAverage[0] + loadAverage[1]  + loadAverage[2] ) / 3
            
        } else {
            let loadAverage = System.machFactor()
            avg = (loadAverage[0] + loadAverage[1]  + loadAverage[2] ) / 3
        }
        print("avg: \(chartTitle)", avg)
        let newDataEntry = ChartDataEntry(x: xValue,
                                          y: avg)
        updateChartView(with: newDataEntry, dataEntries: &dataEntries)
        xValue += 1
    }
    
}

private extension GraphViewController {
    
    func setupInitialDataEntries() {
        (0..<Int(xValue)).forEach {
            let dataEntry = ChartDataEntry(x: Double($0), y: 0)
            dataEntries.append(dataEntry)
        }
    }
    
    func updateChartView(with newDataEntry: ChartDataEntry, dataEntries: inout [ChartDataEntry]) {
        // 1
        if let oldEntry = dataEntries.first {
            dataEntries.removeFirst()
            lineChartView.data?.removeEntry(oldEntry, dataSetIndex: 0)
        }
        
        // 2
        dataEntries.append(newDataEntry)
        lineChartView.data?.addEntry(newDataEntry, dataSetIndex: 0)
        
        // 3
        lineChartView.notifyDataSetChanged()
        lineChartView.moveViewToX(newDataEntry.x)
    }
    
    func checkTimer() {
        if timer != nil {
            timer?.invalidate()
            dataEntries.removeAll()
            xValue = 8
            self.setData()
            setupChartView()
            setupInitialDataEntries()
            
        }else {
            self.setData()
            setupChartView()
            setupInitialDataEntries()
        }
    }
    
    func setupChartView() {
        graphContainerView.addSubview(lineChartView)
        lineChartView.center(in: graphContainerView)
        //lineChartView.frame.size = chartContainerView.bounds.size
        lineChartView.width(to: graphContainerView)
        lineChartView.height(to: graphContainerView)
        
        
    }
    
    func setData() {
        
        let set1 = LineChartDataSet(entries: dataEntries, label: chartTitle)
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.red)
        let data = LineChartData(dataSet: set1)
        // data.setDrawValues(false)
        lineChartView.data = data
        lineChartView.xAxis.labelPosition = .bottom
    }
}
