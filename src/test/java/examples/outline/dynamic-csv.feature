Feature: scenario outline using a dynamic table
  from a csv file

  Background:
  # use jdbc to validate
    * def config = { username: 'username', password: 'password', url: 'jdbc:sqlserver://LOCALHOST;instanceName=INSTANCE;databaseName=TEST', driverClassName: 'com.microsoft.sqlserver.jdbc.SQLServerDriver' }
    * def DbUtils = Java.type('com.polaristesting.karatetestexample.util.DbUtils')
    * def db = new DbUtils(config)

  # since the DbUtils returns a Java Map, it becomes normal JSON here !
  # which means that you can use the full power of Karate's 'match' syntax
    * def sql_query = db.readRows("select cCodUsu as 'name', cCodOfi as 'username', cCodApl as 'email', cEstado as 'street', tHorIni as 'suite', tHorFin as 'city', cTermId as 'zipcode', nCodSes as 'id' from table where ccodusu = 0000")
    #* print 'the value of sql_query is:', sql_query

  Scenario Outline: Name: <name>
    Given url 'http://jsonplaceholder.typicode.com/users'
    #And request read('user.json')
    And request {"name":<name>,"username":<username>,"email":<email>,"address":{"street":<street>,"suite":<suite>,"city": <city>,"zipcode":<zipcode>}}
    When method post
    Then status 201
    #And match response == { id: '#number', name: '<name>' }
    And match response.name == '<name>'
    And match response.id == ~~'<id>'
    #And match response == {name:'#ignore',username:'#regex [1-2]', email:'#ignore', address:'#ignore', id:'#ignore'}
    And match response.username ==  '#regex [1-2]'

    # the single cell can be any valid karate expression
    # and even reference a variable defined ,in the Background
    Examples:
      #| sql_query |
      | read('kittens.csv') |