Specifying Properties in ``connection.uri``
-------------------------------------------

If you're using ``SparkConf``, you can specify all the previous settings either
individually or combined in the write ``connection.uri`` setting.

The following code examples show how to specify ``connection.uri``,
``database``, and ``collection`` settings both separately and in ``connection.uri``:

- Separately:

.. code:: cfg

   spark.mongodb.write.connection.uri=mongodb://127.0.0.1/
   spark.mongodb.write.database=test
   spark.mongodb.write.collection=myCollection

- In ``connection.uri``:

.. code:: cfg

  spark.mongodb.write.connection.uri=mongodb://127.0.0.1/test.myCollection

.. important:: connection.uri Takes Precedence

   If you specify a setting in both the ``connection.uri`` and on its own line,
   the ``connection.uri`` setting takes precedence.
   For example, in the following configuration, the connection
   database is ``foobar``:

   .. code:: cfg

      spark.mongodb.write.connection.uri=mongodb://127.0.0.1/foobar
      spark.mongodb.write.database=bar
