### **This is my KarateDSL Project**

* Table of Contents
  - [Shakeout Automation Suite](#shakeout-automation-test-suite)
    - [Framework](#the-shakeout-suite-explained)
    - [Report is TBD](#)
  - [Progression and Regression Automation Suite](#progression-and-regression-automation-test-suite)
    - [Framework](#the-progression-and-regression-suite-explained)
    - [Report is TBD](#)

### **Shakeout Automation Test Suite**
This is test suite that runs in multiple environment to quickly test individual APIs in processing a single happy path scenario. The test has to be triggered via jenkins, so an awesome email could be triggered each build in order to provide immediate feedback to whole development team.

### **The Shakeout Suite Explained**
* All the scenarios are consolidated in single feature logically grouped by environment.
* All the pre-requisites are placed in background such as token generation, headers, common utilities, and configs. The [callonce](https://github.com/intuite/karate#callonce) will be adapted to cache test data for reusability purpose.
* There's no strict guidelines in naming the scenario, but it is a must that they be clear and concise.
* Each scenario must be tagged with:

| Tags          | Comment                                                                                                   | 
|---------------|-----------------------------------------------------------------------------------------------------------|
| @00_Shakeout  | All the scenarios should have this                                                                        |
| @01_Dev       | Along with @00_Shakeout, this will be added in all of the **dev** related scenarios.                      |
| @01_ST        | Along with @00_Shakeout, this will be added in all of the **sytem test** related scenarios.               |
| @01_SIT       | Along with @00_Shakeout, this will be added in all of the **system integration test** related scenarios.  |

### **Progression and Regression Automation Test Suite**
This is a test suite that can should be able to run in multiple environment to test all positive and negative scenarios.

### **The Progression and Regression Suite Explained**
* It is extremely necessary to parameterise test data and configurations in multi environment automation.
* All the pre-requisites are placed in background such as token generation, headers, common utilities, and configs. The [callonce](https://github.com/intuite/karate#callonce) will be adapted to cache test data for reusability purpose.
* There's no strict guidelines in naming the scenario, but it is a must that they be clear and concise, and must be unique especially if using a test [data driven](https://github.com/karate#data-driven-tests) approach in writing scenario.
* Each scenario must be tagged with:

| Tags            | Comment                                                               | 
|---------------  |-----------------------------------------------------------------------|
| @01_Regression  | Collection of automated test for **already working code**             |
| @02_Progression | Collection of automated test for **carried over and in-sprint work**  |
| @03_Positive    | Collection of automated test for **positive** scenarios               |
| @04_Negative    | Collection of automated test for **negative** scenarios               |
| @05_{API}       | Collection of automated test for specific **API**
