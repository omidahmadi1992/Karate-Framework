@Regression
Feature: TEK Insurance GET Primary Person Account API

  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'
    When def tokenGenerator = call read('GenerateToken.feature@GenerateToken')
    Then def tokenValue = tokenGenerator.response.token
    And header Authorization = 'Bearer ' + tokenValue

  @GetPrimaryPersonAccount
  Scenario: Get Primary Person Account
    Given path '/api/accounts/get-primary-account'
    When param primaryPersonId = 2498
    When method get
    Then status 200
    And print response
    And match response.firstName == 'Jawid'
    And match response.lastName == 'Jawid'
    And match response.title == 'Mr.'
    And match response.gender == 'MALE'
    And match response.id == 2498
    And match response.employmentStatus == 'Engineer'
    And match response.email == 'jawid90@gmail.com'
    And match response.maritalStatus == 'MARRIED'