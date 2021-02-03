Feature: android test

  Background: App Preset
    * configure driver = { type: 'android', webDriverPath : "/wd/hub", start: true, httpConfig : { readTimeout: 120000 }}

  Scenario: launch chrome in appium
    * def desiredConfig =
"""
{
   "newCommandTimeout" : 300,
   "platformVersion" : "9.0",
   "platformName" : "Android",
   "connectHardwareKeyboard" : true,
   "deviceName" : "emulator-5554",
   "avd" : "Pixel2",
   "automationName" : "UiAutomator2",
   "browserName" : "Chrome"
  }
"""
    * driver { webDriverSession: { desiredCapabilities : "#(desiredConfig)"} }
    * driver 'http://google.com'
    * driver.input("//input[@name='q']", 'karate dsl')