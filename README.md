# CS-1632 - DELIVERABLE 4: Performance Testing
Spring Semester 2019

## Deliverable 4

In this deliverable, you and a partner will write software to verify if a simple blockchain is valid.

Under _no_ circumstances should the program crash or should the user see an exception or stack trace directly.  You should handle all edge cases that might be thrown at you, such as a non-existent file, no arguments, different failure modes, etc.

The program shall accept one argument, which is the name of a file which should contain a valid Billcoin blockchain (see billcoin.md in this directory for the rules of Billcoin).  Your program will read in and either determine if it is valid (in which case you should print out all of the address which have billcoins and how many), or invalid (in which case you should print out what the error is).

The program shall be called `verifier.rb`.  Your repository shall be named D4.  This program must be written in Ruby and use minitest for the unit tests.  This program must use rubocop with the attached `.rubocop.yml` configuration and SimpleCov as described in class.

You should work on making this program execute as quickly as possible (i.e., minimize real execution time).  You may use all computing resources available to you.  This will be run on a four-core system with sixteen gigabytes of RAM.  No other programs will be running at the time.

You will use the flamegraph gem to determine execution "hot spots".

You will use the `time` command (or Measure-Command in Windows) to determine total execution time.
