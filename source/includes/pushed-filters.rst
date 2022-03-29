.. note::

   When using filters with DataFrames or Datasets, the
   underlying MongoDB Connector code constructs an :manual:`aggregation
   pipeline </core/aggregation-pipeline/>` to filter the data in
   MongoDB before sending it to Spark. This improves Spark performance 
   by retrieving and processing only the data you need.

   The following filters are pushed down to an aggregation pipeline:

   - And
   - EqualNullSafe
   - EqualTo
   - GreaterThan
   - GreaterThanOrEqual
   - In
   - IsNull
   - LessThan
   - LessThanOrEqual
   - Not
   - Or
   - StringContains
   - StringEndsWith
   - StringStartsWith
