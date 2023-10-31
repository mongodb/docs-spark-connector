Specifying Properties in ``connection.uri``
-------------------------------------------

If you use :ref:`SparkConf <spark-conf>` to specify any of the previous settings, you
can either list them individually or include them in the ``connection.uri`` setting.

The following code example shows how to specify the ``connection.uri``,
``database``, ``collection``, and ``readPreference`` settings individually in a
``SparkConf`` configuration file:

.. code:: cfg

   spark.mongodb.read.connection.uri=mongodb://127.0.0.1/
   spark.mongodb.read.database=test
   spark.mongodb.read.collection=myCollection
   spark.mongodb.read.readPreference.name=primaryPreferred

Instead, you can specify these settings in the value of ``connection.uri``:

.. code:: cfg

  spark.mongodb.read.connection.uri=mongodb://127.0.0.1/test.myCollection?readPreference=primaryPreferred

.. important::

   If you specify a setting in both the ``connection.uri`` and on its own line,
   the ``connection.uri`` setting takes precedence.
   For example, in the following configuration, the connection
   database is ``foobar``:

   .. code:: cfg

      spark.mongodb.read.connection.uri=mongodb://127.0.0.1/foobar
      spark.mongodb.read.database=bar
