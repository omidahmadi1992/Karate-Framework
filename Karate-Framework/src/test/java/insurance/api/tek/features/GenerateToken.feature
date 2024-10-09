@Regression
Feature: Generate Access Token for TEK Insurance Application

  # url keyword is used to pass base url
  # path keyword is used to pass the endpoint of a service
  # request keyword is used to pass json body POST and PUT methods
  # method keyword is used to pass HTTP/HTTPS method Type (GET,POST,PUT,DELETE)
  # status keyword is used to Check Response status code
  # print keyword is used to print the response or variable into console
  # response is used to store response JSON body.
  # match contains keyword, It is Assertion keyword and matches against contains value.
  # !contains keyword used to check if a key-value-pair does not exist.
  # param keyword is used to pass parameter
  # header keyword used to send request header and authorization token
  # match header keyword is used to validate response header value.
  # Schema Validation is used to validate the structure of a given payload


  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'

  @GenerateToken
  Scenario: Generate Token
    Given path '/api/token'
    And request {"username":"supervisor","password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    When def tokenValue = response.token
    And print tokenValue

  @VerifyToken
  Scenario: Verify Token
    Given path '/api/token/verify'
    And def tokenGenerator = call read('GenerateToken.feature@GenerateToken')
    And def userValue = tokenGenerator.response.username
    And def getTokenValue = tokenGenerator.response.token
    When param username = userValue
    When param token = getTokenValue
    When method get
    Then status 200
    And print response