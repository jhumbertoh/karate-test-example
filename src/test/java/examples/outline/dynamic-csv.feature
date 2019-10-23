Feature: scenario outline using a dynamic table
  from a csv file

  Scenario Outline: Name: <name>
    Given url 'http://jsonplaceholder.typicode.com/users'
    #And request read('user.json')
    And request {"name":<name>,"username":<username>,"email":<email>,"address":{"street":<street>,"suite":<suite>,"city": <city>,"zipcode":<zipcode>}}
    When method post
    Then status 201
    #And match response == { id: '#number', name: '<name>' }
    And match response.name == '<name>'
    And match response.id == ~~'<id>'

    # the single cell can be any valid karate expression
    # and even reference a variable defined ,in the Background
    Examples:
      | read('kittens.csv') |