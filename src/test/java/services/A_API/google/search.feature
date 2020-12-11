Feature: Search Feature

  Background:
    * def myHeaders = read('classpath:services/A_API/google/Authorization/header.json')

  Scenario Outline: This is to test search api for <searchData>
    Given url 'https://www.googleapis.com/customsearch/v1?cx=017576662512468239146:omuauf_lfve&q=<searchData>'
    And param key = myHeaders.key
    When method GET
    Then status 200
    * print response

    Examples:
      | Scenario | searchData |
      | name     | Charlotte  |
      | name     | Richard    |
      | name     | Harieth    |
      | name     | Tyrah      |