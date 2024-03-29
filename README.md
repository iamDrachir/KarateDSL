### **This is my KarateDSL Project**


* Table of Contents
  - [Important Links](#important-links)
  - [Shakeout Automation Suite](#shakeout-automation-test-suite)
    - [Approach](#the-shakeout-suite-explained)
    - [Report is TBD](#)
  - [Progression and Regression Automation Suite](#progression-and-regression-automation-test-suite)
    - [Approach](#the-progression-and-regression-suite-explained)
    - [Report is TBD](#)

### **Important Links**
| Topic          | Links                                                                                                   | Youtube |
|---------------|-----------------------------------------------------------------------------------------------------------|--------|
| **Karate Documentation** | [API](https://github.com/intuit/karate) • [UI/Mobile](https://github.com/intuit/karate/tree/master/karate-core) • [Performance](https://github.com/intuit/karate/tree/master/karate-gatling) • [Desktop](https://github.com/intuit/karate/tree/master/karate-robot) | [Video Summary](https://www.youtube.com/watch?v=yu3uupBZyxc) |

### **Continuous Testing**
![alt text](https://github.com/iamDrachir/KarateDSL/blob/master/src/test/java/services/continuous_testing.jpg)

### **Shakeout Automation Test Suite**
This is test suite that runs in multiple environment to quickly test individual APIs in processing a single happy path scenario. The test has to be triggered via jenkins, so an awesome email could be triggered each build in order to provide immediate feedback to whole development team.

### **The Shakeout Suite Explained**
* All the scenarios are consolidated in single feature logically grouped by environment.
* All the pre-requisites are placed in background such as token generation, headers, common utilities, and configs. The [callonce](https://github.com/intuit/karate#callonce) will be adapted to cache test data for reusability purpose.
* There's no strict guidelines in naming the scenario, but it is a must that they be clear and concise.
* Each scenario must be tagged with:

| Tags          | Comment                                                                                                   | 
|---------------|-----------------------------------------------------------------------------------------------------------|
| @00_Shakeout  | All the scenarios should have this                                                                        |
| @01_Dev       | Along with @00_Shakeout, this will be added in all of the **dev** related scenarios.                      |
| @02_ST        | Along with @00_Shakeout, this will be added in all of the **sytem test** related scenarios.               |
| @03_SIT       | Along with @00_Shakeout, this will be added in all of the **system integration test** related scenarios.  |

### **Progression and Regression Automation Test Suite**
This is a test suite that can should be able to run in multiple environment to test all positive and negative scenarios.

### **The Progression and Regression Suite Explained**
* It is extremely necessary to parameterise test data and configurations in multi environment automation.
* All the pre-requisites are placed in background such as token generation, headers, common utilities, and configs. The [callonce](https://github.com/intuit/karate#callonce) will be adapted to cache test data for reusability purpose.
* There's no strict guidelines in naming the scenario, but it is a must that they be clear and concise, and must be unique especially if using a test [data driven](https://github.com/intuit/karate#data-driven-tests) approach in writing scenario.
* Each scenario must be tagged with:

| Tags            | Comment                                                               | 
|---------------  |-----------------------------------------------------------------------|
| @01_Regression  | Collection of automated test for **already working code**             |
| @02_Progression | Collection of automated test for **carried over and in-sprint work**  |
| @03_Positive    | Collection of automated test for **positive** scenarios               |
| @04_Negative    | Collection of automated test for **negative** scenarios               |
| @05_{API}       | Collection of automated test for specific **API**


### **Test Data Driven Testing (API Only)**
![alt text](https://github.com/iamDrachir/KarateDSL/blob/master/src/test/java/services/test_data_driven.jpeg)

### **Test Data Driven Testing (API & PDF Document)**
![alt text](https://github.com/iamDrachir/KarateDSL/blob/master/src/test/java/services/test_data_driven_api_and_pdf.jpg)

### **Run Commands**
* API or UI: mvn test "-Dkarate.env = dev" -Dkarate.options="--tags @00_Shakeout classpath:A_API.google.search.feature" -Dtest=TestRunner
* NFT: mvn clean test-compile galing:test -Dgatling.simulationClass=D_Performance.userSimulations.scala
