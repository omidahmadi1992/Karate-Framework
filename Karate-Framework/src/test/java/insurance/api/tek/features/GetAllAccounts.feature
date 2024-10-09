@Regression
Feature: TEK Insurance GET Account API

  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue

  @GetAllAccounts
  Scenario: Get ALL Accounts
    Given path '/api/accounts/get-all-accounts'
    When method get
    Then status 200
    And print response