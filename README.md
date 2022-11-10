# Black Thursday

A business is only as smart as its data. Let’s build a system to manage our data and execute business intelligence queries against the data from a typical e-commerce business.

## Project Overview
### Learning Goals
* Use tests to drive both the design and implementation of code
* Decompose a large application into components
* Design a solution that is functional, readable, maintainable, and testable
* Learn an agile approach to building software
### Key Concepts
From a technical perspective, this project will emphasize:

* File I/O
* Database Operations (CRUD)
* Encapsulating Responsibilities
* Light data / analytics

____




**As a group, discuss and write your answers to the following questions. Include your responses as a section in your project README.**

What was the most challenging aspect of this project?
* The most challegining part of this project was developing the sales engine and collaboration with git.

What was the most exciting aspect of this project?
* It was exciting to collaborate as a group and navigate the complexity.

Describe the best choice enumerables you used in your project. Please include file names and line numbers.
* inject enumerable, sales_analyst.rb line 263, group_by enumerable, sales_analyst.rb line 221


Tell us about a module or superclass which helped you re-use code across repository classes. Why did you choose to use a superclass and/or a module?
* The repository superclasswas used to clean/dry up code due to the shared traits and behaviour between repository classes.


Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).
* sales_analyst_spec.rb line 180 best item for merchant


Is there anything else you would like instructors to know?
* We could have covered csv's a more, synchronously. Some of the language in the iterations could be more clear for expectations.

### Blog Post

The method most sold item for merchant was developed with TDD in 3 parts. First, the test was written with the result in mind. We wanted the return value to be an array containing a single item or items. There are many ways to achieve this general outcome, so to ensure we were receiving the right result, we identified a single merchant from the CSV data, documented the steps taken to find their most sold item, and made an assertion with that specific merchant. The steps taken are as follows:
1. given merchant, find all invoices
1. with all invoices per merchant, find all invoice items per merchant
1. with all invoice items per merchant, find units sold per item (combine item_id and quantity)
1. sort by most units sold
return the first item with highest quantity
These steps were translated to lines of code within the method.
The cases in which a merchant has multiple highest selling items was tested with a specific merchant as well.

### Questions
1. What is our biggest area of opportunity within our project/what would you have done differently?
1. What is the process for building a test(s) for the last two methods in iteration 4 (no spec_harness)?

