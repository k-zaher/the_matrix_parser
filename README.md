# TheMatrix

When the Matrix was first built there was a man born inside that had the ability to write Ruby code the way he wanted, to remake RSpecs and business requirements as he saw fit.  It was this man that freed the first of us and taught us the secret SOA design skills; control Git and you control the future.

The Oracle at the temple of Zion prophesied his return. That is why there are those of us that have spent our entire lives searching the Matrix, looking for him.

To we use this code to parse the matrix

## Usage

Run the executable file in the root folder:

```ruby
./bin/the_matrix
```
Run the tests using:

```ruby
rspec
```
## Requirment:

1- Each route has an array of paths. 
2- Each path has a start_node and an end_node.
3- The Sentinels data "routes.csv" doesn't guarantee the order of nodes.
4- Any missing data should be ignored and reported as a warning.

## TODO

1- Parse each line in the csv or json separately instead of loading the entire file in memory (this should be done if there is a huge amount of data).

2- Use a data store as Mongo or even Redis to avoid storing all outputs in Memory, which can also decrease the memory overhead.
