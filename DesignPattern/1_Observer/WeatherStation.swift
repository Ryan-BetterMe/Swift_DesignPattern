//
//  WeatherStation.swift
//  DesignPattern
//
//  Created by 向辉 on 2023/12/10.
//

import Foundation

protocol Subject {
    func registerObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObserver()
}

// 设计问题：
// 1、需要将全部数据传递给观察者吗？
// 2、如何保证视图的可拓展性？
// 3、在这个例子中 View 有没有必要持有 WeatherStation
protocol Observer: AnyObject {
    func update(temp: Double, humidity: Double, pressure: Double)
}

protocol Display: AnyObject {
    func display()
}

class WeatherStation: Subject {
    private var observers: [Observer] = []
    private var temperature: Double = 0.0
    private var humidity: Double = 0.0
    private var pressure: Double = 0.0
    
    
    func registerObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    func notifyObserver() {
        observers.forEach {
            $0.update(temp: self.temperature, humidity: self.humidity, pressure: self.pressure)
        }
    }
    
    func measurementsChanged() {
        notifyObserver()
    }
    
    func receiveDataChanged(temp: Double, humidity: Double, pressure: Double) {
        self.humidity = humidity
        self.temperature = temp
        self.pressure = pressure
        
        measurementsChanged()
    }
}

class CurrentConditionDisplay: Observer, Display {
    private var temperature: Double = 0
    
    func update(temp: Double, humidity: Double, pressure: Double) {
        self.temperature = temp
        display()
    }
    
    func display() {
        print("CurrentConditionDisplay : temperature_\(temperature)")
    }
}

class StatisticDisplay: Observer, Display {
    private var humidity: Double = 0
    
    func update(temp: Double, humidity: Double, pressure: Double) {
        self.humidity = humidity
        display()
    }
    
    func display() {
        print("StatisticDisplay : humidity_\(humidity)")
    }
}

class ForecastDisplay: Observer, Display {
    private var pressure: Double = 0
    private var humidity: Double = 0
    
    func update(temp: Double, humidity: Double, pressure: Double) {
        self.pressure = pressure
        self.humidity = humidity
        
        display()
    }
    
    func display() {
        print("ForecastDisplay : pressure_\(pressure), humidity_\(humidity)")
    }
}

