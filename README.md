Reporter
========================

Reporter is a simple reporting tool.  It currently works with MySQL.  This script runs a SQL script and emails the result as an attachment to a destination address.  It works well as a cron job.

Config Files
--------------------------------------

- my.cnf: Standard MySQL cnf file.
- from: Address you would like mail to be sent from.  Simply "Full Name <email@domain.com>" or just "email@domain.com"

Running a Report
--------------------------------------

To use, create a .sql file in catalog/.  Then pass that script name and recipient to report.sh:

```bash
report.sh my_script [email@domain.com]
```

Alternatively, you can specify comma-delimited recipients in a .to file in the catalog/ directory with the base filename the same as the report name and leave out the recipient parameter.

Simple as that.