Feature: R365_API

  Background:
    * def token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiIwM2ZhZjhkYi1hYjhiLTRjYzctOTliYS05ZjUzNjcyYjE4M2EiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9jMGNiNmY1ZS1iZDA2LTQwYjYtYWQzYy0xMjg1MzU0NWMxMmIvIiwiaWF0IjoxNjEzMzU2Mzg1LCJuYmYiOjE2MTMzNTYzODUsImV4cCI6MTYxMzM2MDI4NSwiYWlvIjoiRTJaZ1lGaGJJT1FYYkxOQzh0UDFmVmNaTnZrZEt6cndrcGROVHRSS1FmYUlpbkw5NXJjQSIsImFtciI6WyJwd2QiXSwiZmFtaWx5X25hbWUiOiJUd28iLCJnaXZlbl9uYW1lIjoiVXNlciIsImlwYWRkciI6IjExMi4xNDEuMTYxLjEyOSIsIm5hbWUiOiJVc2VyMiIsIm5vbmNlIjoiNmVmM2VlNTQtOGIzNS00ZTg5LTk3M2EtYjk5NGQ5NjdlY2U5Iiwib2lkIjoiNjNmYzU0YTEtNDQ5NC00NGYyLTg2ZGQtNjk1MjlhMjAwNDMxIiwicmgiOiIwLkFVSUFYbV9Md0FhOXRrQ3RQQktGTlVYQks5djQtZ09McThkTW1icWZVMmNyR0RwQ0FFUS4iLCJyb2xlcyI6WyJSZWNvcmRzTWFuYWdlciJdLCJzdWIiOiJPendObHZCM2ZVeERCT0JRNG5HX2pYdXVwM3Bkc3ZMeGY2cFFWSTd6TElrIiwidGlkIjoiYzBjYjZmNWUtYmQwNi00MGI2LWFkM2MtMTI4NTM1NDVjMTJiIiwidW5pcXVlX25hbWUiOiJ1c2VyMkBtMzY1eDg4NjU1OC5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJ1c2VyMkBtMzY1eDg4NjU1OC5vbm1pY3Jvc29mdC5jb20iLCJ1dGkiOiJNRU1IOE9qa3JrNmFNeEFiZmZfSkFBIiwidmVyIjoiMS4wIn0.XWaeWoaPNPgg4OIgovQ37zKKqM535LDL2KnwoXX3hxbG4t-8aahuzEBzH_fz4QGCPPGFENHNQ0_05-mcZcmqx6nI7V-oegAH6qWaMw3whJW35T9xLnCQN81zImKMPrJjpCRGkedSGAqd7_pQ-rZVS57TQXrcofh7NPmlsmj7Ut6XW6GfCsZgSfUZkQkK2vNn4uU43f_EGs6GgqeSftf_IL6uI-UsqLNutjsp1Vlfjg3gxBY6N88Zx8rleLYFO_YWfwreObDqhvFYxi-ULPkgoWx20wNuCsqiu_ct_HRaQDycZrexSVg4vcU1Zo1-T81uGykMmMnNDyMOHf_4byY-hA'
    * def iRules = callonce read('classpath:services/E_RecordManagement/Rules.feature')

  @ERMSite
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
    * def connectorTypeName = karate.jsonPath(response, "$.sourceProperties[?(@.displayName =='ListUrl')].connectorTypeName")
    * print connectorTypeName[0]
    * match connectorTypeName[0] == '<connectorTypeName>'

    Given url 'https://management-aue.records365.com.au/api/Item/GetDisposalDetailsByItemNumber?itemNumber=' + myItemNumber[0]
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    * def disposalClass = karate.jsonPath(response, "$.coreProperties[?(@.displayName =='RecordCategoryID')].value")
    * print disposalClass[0]
    * def dispositionAuthority = karate.jsonPath(response, "$.coreProperties[?(@.displayName =='DispositionAuthority')].value")
    * print dispositionAuthority[0]
    * match disposalClass[0] == <retentionClasses>
    * match dispositionAuthority[0] == <dispositionAuthority>
    * def disposalClassRule = karate.jsonPath(iRules, "$.[?(@.FieldValue=='business case' || @.Value=='<retentionClasses>')]")
    * print disposalClassRule

    Examples:
      | Scenario  | fileName             | connectorTypeName | dispositionAuthority             | retentionClasses                                                                                                                                                        |
      | FileName1 | FAQ.desktop          | SharePoint Online | 'NAB AUv3.2'                     | 'NAB AUv3.2 - 2.11.1 - CORPORATE GOVERNANCE - Establishment - Entity management:Retain Permanently'                                                                     |
      | FileName2 | second document.docx | SharePoint Online | 'NAB AUv3.2'                     | 'NAB AUv3.2 - 1.1.4 - BANKING OPERATIONS - Administration - Suspense accounts:Destroy 7 years after end of the financial year in which the transactions were completed' |
      | FileName3 | 1142622077           | SharePoint Online | 'Normal Administrative Practice' | 'Normal Administrative Practice'                                                                                                                                        |

  @ERMProgram
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
    * def connectorTypeName = karate.jsonPath(response, "$.sourceProperties[?(@.displayName =='ListUrl')].connectorTypeName")
    * print connectorTypeName[0]
    * match connectorTypeName[0] == '<connectorTypeName>'

    Given url 'https://management-aue.records365.com.au/api/Item/GetDisposalDetailsByItemNumber?itemNumber=' + myItemNumber[0]
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method GET
    Then status 200
    * def disposalClass = karate.jsonPath(response, "$.coreProperties[?(@.displayName =='RecordCategoryID')].value")
    * print disposalClass[0]
    * def dispositionAuthority = karate.jsonPath(response, "$.coreProperties[?(@.displayName =='DispositionAuthority')].value")
    * print dispositionAuthority[0]
    * match disposalClass[0] == <retentionClasses>
    * match dispositionAuthority[0] == <dispositionAuthority>

    Examples:
      | Scenario  | fileName             | connectorTypeName | dispositionAuthority             | retentionClasses                                                                                                                                                        |
      | FileName1 | FAQ.desktop          | SharePoint Online | 'NAB AUv3.2'                     | 'NAB AUv3.2 - 2.11.1 - CORPORATE GOVERNANCE - Establishment - Entity management:Retain Permanently'                                                                     |
      | FileName2 | second document.docx | SharePoint Online | 'NAB AUv3.2'                     | 'NAB AUv3.2 - 1.1.4 - BANKING OPERATIONS - Administration - Suspense accounts:Destroy 7 years after end of the financial year in which the transactions were completed' |
      | FileName3 | 1142622077           | SharePoint Online | 'Normal Administrative Practice' | 'Normal Administrative Practice'                                                                                                                                        |
