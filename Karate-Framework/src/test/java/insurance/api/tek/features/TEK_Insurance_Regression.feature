@Regression
Feature: TEK Insurance Regression Suite

  Background:
    Given  url appUrl
    * def tokenGenerator = callonce read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue


    # Scenario: Post an account
  Scenario: Post an account - Primary Person
    * def generator = Java.type('insurance.api.tek.utility.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def title = generator.getTitle()
    * def employmentStatus = generator.getEmploymentStatus()
    * def dateOfBirth = generator.getDateOfBirth()
    * def maritalStatus = generator.getMaritalStatus()
    * def gender = generator.getGender()
    * path '/api/accounts/add-primary-account'
    * request
  """
  {
  "id": 0,
  "email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "#(title)",
  "gender": "#(gender)",
  "maritalStatus": "#(maritalStatus)",
  "employmentStatus": "#(employmentStatus)",
  "dateOfBirth": "#(dateOfBirth)",
  "new": true
}
  """
    * method post
    * status 201
    * match response.email == email
    * print response
    * karate.write(response, 'RegressionCreatedAccount.json')

  @postCar
  Scenario: Post a car - Primary Person Account
    * path '/api/accounts/add-account-car'
    * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
    * param primaryPersonId = primaryPersonIdValue.id
    * request
  """
  {
  "make": "BMW",
  "model": "XM",
  "year": "2024",
  "licensePlate": "Raptors124"
}
  """
    * method post
    * status 201
    * print response
    * match response.licensePlate == 'Raptors124'
    * karate.write(response, 'RegressionPostCar.json')


  Scenario: put (Update) a car - Primary Person Account
    * path '/api/accounts/update-account-car'
    * def extractCarId = read('file:./target/RegressionPostCar.json')
    * def carIdValue = extractCarId.id
    * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
    * param primaryPersonId = primaryPersonIdValue.id
    * request
      """
      {
  "id": #(carIdValue),
  "make": "Audi",
  "model": "Q7",
  "year": "2024",
  "licensePlate": "Raptors-Cali2024"
}
      """
    * method put
    * status 202
    * print response
    * karate.write(response, 'RegressionUpdatedCar.json')


  Scenario: Delete a car - Primary Person
    * path '/api/accounts/delete-car'
    * def extractCarId = read('file:./target/RegressionPostCar.json')
    * def carIdValue = extractCarId.id
    * param carId = carIdValue
    * method delete
    * status 202
    * print response
    * match response.message contains 'had been deleted'
    * karate.write(response, 'RegressionDeleteCar.json')


  Scenario: Post an Address - Primary Person Account
    * path '/api/accounts/add-account-address'
    * def primaryPersonIdValue = read('file:./target/RegressionCreatedAccount.json')
    * param primaryPersonId = primaryPersonIdValue.id
    * request
  """
{
  "addressType": "Office",
  "addressLine1": "4141 Palm Ave",
  "city": "SFO",
  "state": "CA",
  "postalCode": "95842",
  "countryCode": "005",
  "current": true
}
  """
    * method post
    * status 201
    * print response
    * karate.write(response, 'RegressionPostAddress.json')