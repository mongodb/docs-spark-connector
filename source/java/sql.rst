.. _java-sql:

.. include:: /includes/scala-java-sql-register-table.rst

.. code-block:: java

   implicitDS.createOrReplaceTempView("characters");
   Dataset<Row> centenarians = spark.sql("SELECT name, age FROM characters WHERE age >= 100");
   centenarians.show();

``centenarians.show()`` outputs the following:

.. code-block:: sh

   { "name" : "Gandalf", "age" : 1000 }
   { "name" : "Thorin", "age" : 195 }
   { "name" : "Balin", "age" : 178 }
   { "name" : "Dwalin", "age" : 169 }
   { "name" : "Óin", "age" : 167 }
   { "name" : "Glóin", "age" : 158 }
