Feature: browser automation 2
    #Record and Information Management
    #Functions
      # 1. FOI
      # 2. Legal
      # 3. Record Disposal

  # Roles:
    # Record Visitor - specific security profile for them on what they can access at R365.
    # Record Manager - can do everything. Can't play around with connector settings.
    # Application Administrator - can do everything, Can play around with connector settings to determine which record goes to R365.
    # Default Access


  #ST Out of Scope
  #R365 Administrator Profile Testing

  Background:
    * configure driver = { type: 'chrome' }

  @SOL
  Scenario: Open_R365
    Given driver 'https://aue.records365.com.au/'
    And input('input[name=loginfmt]', 'User 1')
    And
    When click('{}Disposal')
    Then delay(10000)