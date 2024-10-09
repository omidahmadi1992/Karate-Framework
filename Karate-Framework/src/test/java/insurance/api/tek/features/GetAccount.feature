@Regression
Feature: TEK Insurance Get Account API

  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'
    When def tokenGenerator = call read('GenerateToken.feature@GenerateToken')
    Then def tokenValue = tokenGenerator.response.token
    And header Authorization = 'Bearer ' + tokenValue

  @GetAccount
  Scenario: Get account
    Given path '/api/accounts/get-primary-account'
    When param primaryPersonId = 2498
    When method get
    Then status 200
    And print response