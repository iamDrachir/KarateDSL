Feature: R365_API

  Background:
    * def token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiIwM2ZhZjhkYi1hYjhiLTRjYzctOTliYS05ZjUzNjcyYjE4M2EiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9jMGNiNmY1ZS1iZDA2LTQwYjYtYWQzYy0xMjg1MzU0NWMxMmIvIiwiaWF0IjoxNjEyNDA5NzQ1LCJuYmYiOjE2MTI0MDk3NDUsImV4cCI6MTYxMjQxMzY0NSwiYWlvIjoiRTJaZ1lMaTVpemRzai85TDdTdmVNZjRONGZuVHhDZGs4OWhWQjFjc1hEbjlCZk9KWjljQSIsImFtciI6WyJwd2QiXSwiZmFtaWx5X25hbWUiOiJUd28iLCJnaXZlbl9uYW1lIjoiVXNlciIsImlwYWRkciI6IjExMi4xNDEuMTYxLjEyOSIsIm5hbWUiOiJVc2VyMiIsIm5vbmNlIjoiODYwOGI0MTEtY2U5OC00YjIzLThiY2QtYTA4ZWNlNzZmODNiIiwib2lkIjoiNjNmYzU0YTEtNDQ5NC00NGYyLTg2ZGQtNjk1MjlhMjAwNDMxIiwicmgiOiIwLkFBQUFYbV9Md0FhOXRrQ3RQQktGTlVYQks5djQtZ09McThkTW1icWZVMmNyR0RwQ0FFUS4iLCJyb2xlcyI6WyJSZWNvcmRzTWFuYWdlciJdLCJzdWIiOiJPendObHZCM2ZVeERCT0JRNG5HX2pYdXVwM3Bkc3ZMeGY2cFFWSTd6TElrIiwidGlkIjoiYzBjYjZmNWUtYmQwNi00MGI2LWFkM2MtMTI4NTM1NDVjMTJiIiwidW5pcXVlX25hbWUiOiJ1c2VyMkBtMzY1eDg4NjU1OC5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJ1c2VyMkBtMzY1eDg4NjU1OC5vbm1pY3Jvc29mdC5jb20iLCJ1dGkiOiJLblNHSjlnT1ZrR0JoSnpubkRJNkFBIiwidmVyIjoiMS4wIn0.YJZtF7y5zeEweYJOMzBD1XqyDbsYMHnz2uVJpIMo3Lf9cnuOMCYVE8JpzbOZoJUXDYTkjmys0vgvmTebEqi0uheGPWAOu-1r44x1SOwHMm_nwQOTMYAcA-mGUk9XRQDJShqd6vI0UGnva3iY9zTB2iC3uGYGlWjr7gboym9tHO0wZUQBtBkLdBCBEfcIlAxS1aSAOz0PqbG45SXJSyCB8LR55HV7IuFRThExE3oIwhI9FDnL5vZHqVA6DNcsI4w0bL9gMR1glTL_DIYLvh-BsjFtzUrTWPnV5hrs9pGiYjkmQSw2M1FNDDreItM_8ILRUFrsa6-0ed76mE6S_GQGVg'

  @SOL1
  Scenario: This is to test R365_API(GetAll)
    Given url 'https://management-aue.records365.com.au/api/ItemCategory/GetAll'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    * print response

  @SOL2
  Scenario: This is to test R365_API(GetItemByItemNumber)
    Given url 'https://management-aue.records365.com.au/api/Item/GetItemByItemNumber'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    And param itemNumber = 'R0000000005'
    When method GET
    Then status 200
    * print response

  @SOL3
  Scenario Outline: This is scenario for R365_API(SimpleSearch) to test <fileName>
    Given url 'https://management-aue.records365.com.au/api/Item/SimpleSearch'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    And param queryText = '<fileName>'
    When method GET
    Then status 200
    * def myItemNumber = karate.jsonPath(response, "$.items[0].[?(@.key=='ItemNumber')].value")
    * print myItemNumber[0]

    Given url 'https://management-aue.records365.com.au/api/Item/GetItemByItemNumber?itemNumber=' + myItemNumber[0]
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    * print response

    Examples:
      | Scenario  | fileName              |
      | FileName1 | FAQ.desktop           |
      | FileName2 | Records365Labels.docx |
      | FileName3 | Hello World.docx      |
