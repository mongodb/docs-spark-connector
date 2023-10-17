* - ``connection.uri``
  - | **Required.**
    | The connection string configuration key.
    |
    | **Default:** ``mongodb://localhost:27017/``

* - ``database``
  - | **Required.**
    | The database name configuration.

* - ``collection``
  - | **Required.**
    | The collection name configuration.

* - ``comment``
  - | The comment to append to the write operation. Comments appear in the 
      :manual:`output of the Database Profiler. </reference/database-profiler>`
    |
    | **Default:** None 

* - ``mongoClientFactory``
  - | MongoClientFactory configuration key.
    | You can specify a custom implementation that must implement the
      ``com.mongodb.spark.sql.connector.connection.MongoClientFactory``
      interface.
    |
    | **Default:** ``com.mongodb.spark.sql.connector.connection.DefaultMongoClientFactory``
