Feature: R365_API

  Background:
    * def token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiIwM2ZhZjhkYi1hYjhiLTRjYzctOTliYS05ZjUzNjcyYjE4M2EiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9jMGNiNmY1ZS1iZDA2LTQwYjYtYWQzYy0xMjg1MzU0NWMxMmIvIiwiaWF0IjoxNjEyNDE3ODc4LCJuYmYiOjE2MTI0MTc4NzgsImV4cCI6MTYxMjQyMTc3OCwiYWlvIjoiRTJaZ1lQZ2RablAyeGsydmVWOSs2VFA0VDIrVWJWRHpudGNxczhWamljbGZ3ZlRBbEJjQSIsImFtciI6WyJwd2QiXSwiZmFtaWx5X25hbWUiOiJUd28iLCJnaXZlbl9uYW1lIjoiVXNlciIsImlwYWRkciI6IjExMi4xNDEuMTYxLjEyOSIsIm5hbWUiOiJVc2VyMiIsIm5vbmNlIjoiMzlhNWJlMzktMjY3OC00ZTdiLTg2NTktYWU0MTQyOTU4N2Q2Iiwib2lkIjoiNjNmYzU0YTEtNDQ5NC00NGYyLTg2ZGQtNjk1MjlhMjAwNDMxIiwicmgiOiIwLkFBQUFYbV9Md0FhOXRrQ3RQQktGTlVYQks5djQtZ09McThkTW1icWZVMmNyR0RwQ0FFUS4iLCJyb2xlcyI6WyJSZWNvcmRzTWFuYWdlciJdLCJzdWIiOiJPendObHZCM2ZVeERCT0JRNG5HX2pYdXVwM3Bkc3ZMeGY2cFFWSTd6TElrIiwidGlkIjoiYzBjYjZmNWUtYmQwNi00MGI2LWFkM2MtMTI4NTM1NDVjMTJiIiwidW5pcXVlX25hbWUiOiJ1c2VyMkBtMzY1eDg4NjU1OC5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJ1c2VyMkBtMzY1eDg4NjU1OC5vbm1pY3Jvc29mdC5jb20iLCJ1dGkiOiJmZTRvdXNRdEIweUVWOVlNQUJaREFBIiwidmVyIjoiMS4wIn0.FKDS_fr-hGNkOFE1jHhmog-gzlVrOIzDluPxLq-xzBh7Iz5XAoyNFq4yDtoQgiUsp-3znmMqzhalxQI4tqrKuUhENCTfmLYX5ItK2rpWtQepbYlQ2Zf-5rtfOnoz8vmt0YcZV1n15nmsX9uFuZta3gExT02D9aSYzbPnJlGgMXDTOF57LtbgqaQyxk7IE84sN06Tlb2ITYkkBJ4tCSg7sUJU3T9NEqSSA067XOmw5eA4glixq4MBrzglalboajkUbEer13-prBAV72WV_m8yV4CRZvmckeCE12-3J6vr7C_p4uL8TS7HFlY3FdxBBwU3LfJMYFae_fSg_FHAua1m3g'

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

    Given url 'https://management-aue.records365.com.au/api/Item/GetDisposalDetailsByItemNumber?itemNumber=' + myItemNumber[0]
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    * def disposalClass = karate.jsonPath(response, "$.coreProperties[?(@.displayName =='RecordCategoryID')].value")
    * print disposalClass[0]
    * def connectorType = karate.jsonPath(response, "$.coreProperties[?(@.displayName =='RecordCategoryID')].connectorTypeName")
    * print connectorType[0]
    * match disposalClass[0] == '<retentionClasses>'
    * match connectorType[0] == '<connectorType>'

    Examples:
      | Scenario  | fileName              | retentionClasses                                                                                  | connectorType               |
      | FileName1 | FAQ.desktop           | NAB AUv3.2 - 2.11.1 - CORPORATE GOVERNANCE - Establishment - Entity management:Retain Permanently | Records Management Platform |
      | FileName2 | Records365Labels.docx |                                                                                                   |                             |
      | FileName3 | Hello World.docx      |                                                                                                   |                             |
