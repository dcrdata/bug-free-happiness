# The Sqlite db was generated from testnet data as below:

- Login into the sqlite3 CLI shell by:
```Shell
    cd /path/to/testnet3/sqlite/db

    sqlite3
```

- While in the sqlite3 shell connect to the testnet db.
```Shell
   .open dcrdata.sqlt.db

    create table test_dcrdata_block_summary as select * from dcrdata_block_summary where height > 131800 LIMIT 200;
    create table test_dcrdata_stakeinfo_extended as select * from dcrdata_stakeinfo_extended where height > 131800 LIMIT 200;
```

- While in the sqlite shell create a dump file with the newly created tables's data.
Dump data into  `data_1.sql` and `data_2.sql` as shown.
```Shell
    .output data_1.sql
    .dump test_dcrdata_block_summary;

    .output data_2.sql
    .dump test_dcrdata_stakeinfo_extended;
```

- Delete the newly created tables from the testnet3 db.
```Shell
    drop table test_dcrdata_stakeinfo_extended;
    drop table test_dcrdata_block_summary;
```

- Join the two files `data_1.sql` and `data_2.sql` into a single file with name `sqlite_dump.sql`.
```Shell
    cat data_1.sql data_2.sql >> sqlite_dump.sql
```