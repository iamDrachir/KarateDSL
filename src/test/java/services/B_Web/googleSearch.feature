Feature: browser automation 2

  Background:
    * configure driver = { type: 'chrome' }

  @Google
  Scenario: google search, land on the karate github page, and search for a file
    Given driver 'https://google.com'
    And input('input[name=q]', 'karate dsl')
    When click('input[name=btnI]')
    Then waitForUrl('https://github.com/intuit/karate')

    When click('{a}Go to file')
    And def searchField = waitFor('input[name=query]')
    Then match driver.url == 'https://github.com/intuit/karate/find/master'

    When searchField.input('karate-logo.png')
    And def innerText = function(locator){ return scriptAll(locator, '_.innerText') }
    And def searchFunction =
      """
      function() {
        var results = innerText('.js-tree-browser-result-path');
        return results.size() == 2 ? results : null;
      }
      """
    And def searchResults = waitUntil(searchFunction)
    Then match searchResults contains 'karate-core/src/main/resources/res/karate-logo.png'

  @Delta
  Scenario: Login at Delta Airlines
    * driver 'https://www.delta.com'
    * screenshot()
    * waitFor('{}Log in').click()
    * screenshot()
    * click('{}SkyMiles Number Or Username').input('9060651578')
    * screenshot()
    * click('{}Password').input('Charlotte123')
    * screenshot()
    * mouse('#loginButton').click()
    * screenshot()
    * delay(10000)