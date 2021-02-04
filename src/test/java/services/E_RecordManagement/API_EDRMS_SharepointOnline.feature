Feature: R365_API

  Background:
    * def token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiIwM2ZhZjhkYi1hYjhiLTRjYzctOTliYS05ZjUzNjcyYjE4M2EiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9jMGNiNmY1ZS1iZDA2LTQwYjYtYWQzYy0xMjg1MzU0NWMxMmIvIiwiaWF0IjoxNjEyNDIyMjk4LCJuYmYiOjE2MTI0MjIyOTgsImV4cCI6MTYxMjQyNjE5OCwiYWlvIjoiQVNRQTIvOFRBQUFBaGVUeWVlVmNKaFFONnhxU0dEQzZUYk9pSGIvMVRaOGEyY0hWQmd1d3JWST0iLCJhbXIiOlsicHdkIl0sImZhbWlseV9uYW1lIjoiVHdvIiwiZ2l2ZW5fbmFtZSI6IlVzZXIiLCJpcGFkZHIiOiIxMTIuMTQxLjE2MS4xMjkiLCJuYW1lIjoiVXNlcjIiLCJub25jZSI6IjcxZmZhNjYxLTc5ZGYtNGM4NS1iY2FjLThhN2MxZDFiZTgwNSIsIm9pZCI6IjYzZmM1NGExLTQ0OTQtNDRmMi04NmRkLTY5NTI5YTIwMDQzMSIsInJoIjoiMC5BQUFBWG1fTHdBYTl0a0N0UEJLRk5VWEJLOXY0LWdPTHE4ZE1tYnFmVTJjckdEcENBRVEuIiwicm9sZXMiOlsiUmVjb3Jkc01hbmFnZXIiXSwic3ViIjoiT3p3Tmx2QjNmVXhEQk9CUTRuR19qWHV1cDNwZHN2THhmNnBRVkk3ekxJayIsInRpZCI6ImMwY2I2ZjVlLWJkMDYtNDBiNi1hZDNjLTEyODUzNTQ1YzEyYiIsInVuaXF1ZV9uYW1lIjoidXNlcjJAbTM2NXg4ODY1NTgub25taWNyb3NvZnQuY29tIiwidXBuIjoidXNlcjJAbTM2NXg4ODY1NTgub25taWNyb3NvZnQuY29tIiwidXRpIjoiel83Nmd5blhfRUdmS25rajBzTk5BQSIsInZlciI6IjEuMCJ9.PBM1YR0L9g0V4wEqzupYZ8Yxc-uPdqZf-ootQeSIt2BtmLEo6lUv-HjtqeZAS0QqscXzH382hPHi38iFleoSWslVoyf7vYMS-ZQQFvMIAwqb3W8-_0n1iohvExnnyknUAmKc3Em9EyfqAQhwVLYTXToQhlguTw82SMet0PRiaf4gC9x02ZDcoQEceLiMHNFmOiH6iaMqnNRKE12Xx5NerB04MDOPQaxkDPsRqlBYg4WQBgrOsrPJrPOnT-10cPTt_KZfO7E8k2fnb4eRECO455ci6ikP1rJTTNFzpK_iQL-zZL9Gr14Wj_tyPsVBGKen2MC8d_b3dc_gtYZh6NdT6Q'

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
    * match disposalClass[0] == '<retentionClasses>'
    * match dispositionAuthority[0] == '<dispositionAuthority>'

    Examples:
      | Scenario  | fileName              | connectorTypeName |retentionClasses                                                                                  | dispositionAuthority |
      | FileName1 | FAQ.desktop           | SharePoint Online |NAB AUv3.2 - 2.11.1 - CORPORATE GOVERNANCE - Establishment - Entity management:Retain Permanently | NAB AUv3.2           |
      | FileName2 | Records365Labels.docx | SharePoint Online |                                                                                                  |                      |
      | FileName3 | Hello World.docx      | SharePoint Online |                                                                                                  |                      |
