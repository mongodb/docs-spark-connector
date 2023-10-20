You must specify the following configuration settings to write to MongoDB:
         
.. list-table::
   :header-rows: 1
   :stub-columns: 1
   :widths: 10 40
         
   * - Setting
     - Description
         
   * - ``writeStream.format()``
     - Specifies the format of the underlying output data source. Use ``mongodb``
       to write to MongoDB.
         
   * - ``writeStream.option()``
     - Specifies stream settings, including the
       MongoDB deployment
       :manual:`connection string </reference/connection-string/>`,
       MongoDB database and collection, and checkpoint directory.

       For a list of write stream configuration options, see
       the :ref:`spark-streaming-write-conf` guide.

   * - ``writeStream.outputMode()``
     - Specifies how data of a streaming DataFrame is 
       written to a streaming sink. To view a list of all 
       supported output modes, see `the Java outputMode documentation <https://spark.apache.org/docs/latest/api/java/org/apache/spark/sql/streaming/DataStreamWriter.html#outputMode-java.lang.String->`__.
 
   * - ``writeStream.trigger()``
     - Specifies how often results should be written to the streaming sink. 
                
       To use continuous processing, pass ``Trigger.Continuous(<time value>)`` 
       as an argument, where ``<time value>`` is how often the Spark Connector 
       should asynchronously checkpoint. If you 
       pass any other static method of the ``Trigger`` class, or if you don't 
       call ``writeStream.trigger()``, the Spark connector will use 
       micro-batch processing instead. 
  
       To view a list of all supported processing policies, see `the Java 
       trigger documentation <https://spark.apache.org/docs/latest/api/java/org/apache/spark/sql/streaming/Trigger.html>`__.

       .. include:: /includes/note-trigger-method


   * - ``readStream.option()``
     - Specifies stream settings, including the MongoDB deployment
       :manual:`connection string </reference/connection-string/>`,
       MongoDB database and collection, and aggregation pipeline stages.

       For a list of read stream configuration options, see
       the :ref:`spark-streaming-read-conf` guide.
        
   * - ``readStream.schema()``
     - Specifies the input schema.