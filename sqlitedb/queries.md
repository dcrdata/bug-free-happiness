#### The SQlite db dump file was generated from testnet data as below:

- Login into the SQlite3 CLI shell by:
```Shell
    $ cd /path/to/testnet3/sqlite/db

    $ sqlite3
```

- While in the sqlite3 shell connect to the testnet db.
```Shell
   .open dcrdata.sqlt.db

   CREATE TABLE test_dcrdata_block_summary AS SELECT * FROM dcrdata_block_summary WHERE height < 200;
   CREATE TABLE test_dcrdata_stakeinfo_extended AS SELECT * FROM dcrdata_stakeinfo_extended WHERE height < 200;
```

- Create dump files with the newly created tables' data and dump data into `data_1.sql` and `data_2.sql` as shown.
```Shell
    .output data_1.sql
    .dump test_dcrdata_block_summary

    .output data_2.sql
    .dump test_dcrdata_stakeinfo_extended;
```

- Delete the newly created tests tables with prefix **test_** from the testnet3 db.
```Shell
    DROP TABLE test_dcrdata_stakeinfo_extended;
    DROP TABLE test_dcrdata_block_summary
```

- Exit the sqlite shell to join the two files `data_1.sql` and `data_2.sql` into `sqlite_dump.sql`.
```Shell
    $ cat data_1.sql data_2.sql > sqlite_dump.sql
```

- Compress the `sqlite_dump.sql` file dump and upload it.
