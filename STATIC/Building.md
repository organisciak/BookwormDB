# Building a Bookworm

## System/software Requirements

#### Operating System:

Bookworm installations are best tuned for recent versions of Ubuntu. Development versions are also maintained on Mac OS X. Other Unixes should be usable without much trouble: some files for configuring CentOS are included in the distribution, although they may be out of date. Windows is out of the queston.

#### Software Dependencies:
* MySQL 5.6 or later.
    * MySQL 5.5 will work in most cases, but will not be supported going forward and make break with future updates.
* Python 2.7, with certain modules:
    * regex
    * nltk
    *
* GNU parallel
* Apache2 (or another web server of your choice.)

## Hardware requirements

### RAM

Bookworm queries run fast because large amounts of memory is stored in memory. With some tweaking, one can create a disk-based Bookworm; these are not supported by default because they tend to be signficantly slower. (Some benchmarks are XXX available on the Presidio repository's description page).

### Hard Drive space

The other reason for Bookworm's speed at present is a number of B-tree indexes on every possible phrase that a user might search for. This is a very disk-consuming sort of storage, so bookworms frequently take up significantly more space than the texts fed into them.

Intermediate creation take up quite a bit of space in most Bookworm repos, though less than in earlier versions.

## Understanding the Workflow.

All jobs are dispatched through the Makefile--if you can read through the dependency chain to see how it's put together, you'll understand all the elements.
