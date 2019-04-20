//
//  WeatherSearchTests.swift
//  WeatherSearchTests
//
//  Created by Colin Masters on 02/03/2019.
//  Copyright © 2019 Colin Masters. All rights reserved.
//

import XCTest
@testable import WeatherSearch

class WeatherSearchTests: XCTestCase {
    
    var goodData = "{\r\n    \"cod\": \"200\",\r\n    \"message\": 0.0073,\r\n    \"cnt\": 40,\r\n    \"list\": [\r\n        {\r\n            \"dt\": 1554530400,\r\n            \"main\": {\r\n                \"temp\": 8.92,\r\n                \"temp_min\": 8.92,\r\n                \"temp_max\": 8.92,\r\n                \"pressure\": 1001.53,\r\n                \"sea_level\": 1001.53,\r\n                \"grnd_level\": 983.25,\r\n                \"humidity\": 97,\r\n                \"temp_kf\": 0\r\n            },\r\n            \"weather\": [\r\n                {\r\n                    \"id\": 501,\r\n                    \"main\": \"Rain\",\r\n                    \"description\": \"moderate rain\",\r\n                    \"icon\": \"10n\"\r\n                }\r\n            ],\r\n            \"clouds\": {\r\n                \"all\": 92\r\n            },\r\n            \"wind\": {\r\n                \"speed\": 2.76,\r\n                \"deg\": 77.5016\r\n            },\r\n            \"rain\": {\r\n                \"3h\": 4.27\r\n            },\r\n            \"sys\": {\r\n                \"pod\": \"n\"\r\n            },\r\n            \"dt_txt\": \"2019-04-06 06:00:00\"\r\n        },\r\n\r\n        {\r\n            \"dt\": 1554649200,\r\n            \"main\": {\r\n                \"temp\": 8.51,\r\n                \"temp_min\": 8.51,\r\n                \"temp_max\": 8.51,\r\n                \"pressure\": 1009.34,\r\n                \"sea_level\": 1009.34,\r\n                \"grnd_level\": 991,\r\n                \"humidity\": 97,\r\n                \"temp_kf\": 0\r\n            },\r\n            \"weather\": [\r\n                {\r\n                    \"id\": 500,\r\n                    \"main\": \"Rain\",\r\n                    \"description\": \"light rain\",\r\n                    \"icon\": \"10d\"\r\n                }\r\n            ],\r\n            \"clouds\": {\r\n                \"all\": 44\r\n            },\r\n            \"wind\": {\r\n                \"speed\": 3.66,\r\n                \"deg\": 210.504\r\n            },\r\n            \"rain\": {\r\n                \"3h\": 1.72\r\n            },\r\n            \"sys\": {\r\n                \"pod\": \"d\"\r\n            },\r\n            \"dt_txt\": \"2019-04-07 15:00:00\"\r\n        }\r\n    ],\r\n    \"city\": {\r\n        \"id\": 6173331,\r\n        \"name\": \"Vancouver\",\r\n        \"coord\": {\r\n            \"lat\": 49.2624,\r\n            \"lon\": -123.1156\r\n        },\r\n        \"country\": \"CA\",\r\n        \"population\": 1837969\r\n    }\r\n}".data(using: .utf8)
    
    // Good data, with random bits removed
    var badData = "{\r\n    \"cod\": \"200\",\r\n    \"message\": 0.0073,\r\n    \"cnt\": 40,\r\n    \"list\": [\r\n        {\r\n            \"dt\": 1554530400,\r\n            \"main\": {\r\n                \"temp\": 8.92,\r\n                \"temp_min\": 8.92,\r\n                \"temp_max\": 8.92,\r\n                \"pressure\": 1001.53,\r\n                \"sea_level\": 1001.53,\r\n                \"grnd_level\": 983.25,\r\n                \"humidity\": 97,\r\n                \"temp_kf\": 0\r\n            },\r\n            \"weather\": [\r\n                {\r\n                    \"i                  \"main\": \"Rain\",\r\n                    \"description\": \"moderate rain\",\r\n                    \"icon\": \"10n\"\r\n                }\r\n            ],\r\n            \"clouds\": {\r\n                \"all\": 92\r\n            },\r\n            \"wind\": {\r\n                \"speed\": 2.76,\r\n                \"deg\": 77.5016\r\n            },\r\n            \"rain\": {\r\n                \"3h\": 4.27\r\n            },\r\n            \"sys\": {\r\n                \"po            },\r\n            \"dt_txt\": \"2019-04-06 06:00:00\"\r\n        },\r\n\r\n        {\r\n            \"dt\": 1554649200,\r\n            \"main\": {\r\n                \"temp\": 8.51,\r\n                \"temp_min\": 8.51,\r\n                \"temp_max\": 8.51,\r\n                \"pressure\": 1009.34,\r\n                \"sea_level\": 1009.34,\r\n                     \"humidity\": 97,\r\n                \"temp_kf\": 0\r\n            },\r\n            \"weather\": [\r\n                {\r\n                    \"id\": 500,\r\n                    \"main\": \"Rain\",\r\n                    \"description\": \"light rain\",\r\n                    \"icon\": \"10d\"\r\n                }\r\n            ],\r\n            \"clouds\": {\r\n                \"all\": 44\r\n            },\r\n            \"wind\": {\r\n                \"speed\": 3.66,\r\n                \"deg\": 210.504\r\n            },\r\n            \"rain\": {\r\n                \"3h\": 1.72\r\n            },\r\n            \"sys\": {\r\n                \"pod\": \"d\"\r\n            },\r\n            \"dt_txt\": \"2019-04-07 15:00:00\"\r\n        }\r\n    ],\r\n    \"city\": {\r\n        \"id\": 6173331,\r\n        \"name\": \"Vancouver\",\r\n        \"coord\": {\r\n            \"lat\": 49.2624,\r\n            \"lon\": -123.1156\r\n        },\r\n        \"country\": \"CA\",\r\n        \"population\": 1837969\r\n    }\r\n}".data(using: .utf8)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForecastDecoding() {
        let goodForecast = try? JSONDecoder().decode(Forecast.self, from: goodData!)
        XCTAssert(goodForecast != nil)
        
        let badForecast = try? JSONDecoder().decode(Forecast.self, from: badData!)
        XCTAssert(badForecast == nil)
    }

    func testPerformanceExample() {
        self.measure {
            let _ = try? JSONDecoder().decode(Forecast.self, from: goodData!)
        }
    }

}
