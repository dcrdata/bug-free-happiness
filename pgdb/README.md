### Test Data for Blocks, Vins, Tickets and Transactions tables in Dcrdata

#### The Postgresql db dump was generated from testnet data as below:

- Login into the Postgres CLI shell by:
```Shell
    psql -U postgres
```

- While in the psql shell connect to the dcrdata testnet db (or any other source data db of your choice).
```Shell
    \c testnet_dcrdata
```
- Executes the following commands while in the postgres CLI shell. The commands will create new tables with the required data.

```Shell
    CREATE TABLE test_blocks AS SELECT * FROM blocks WHERE height > 131800 LIMIT 100;
    CREATE TABLE test_vins AS SELECT * FROM vins WHERE time > '2019-02-17 03:23:23+03' LIMIT 100;
    CREATE TABLE test_transactions AS SELECT * FROM transactions WHERE block_height > 131800 LIMIT 100;
    CREATE TABLE test_tickets AS SELECT * FROM tickets WHERE block_height > 131800 LIMIT 100;
```

- Exit the postgres shell and create a dump file with the newly created tables's data.
```Shell
    bug-free-happiness git:(master) ✗ pg_dump -t tests_blocks -t tests_transactions as transactions -t tests_vins -t tests_tickets --no-comments --column-inserts -U postgres t_dcrdata > pgdb/data.sql
```

- In *.sql dump file delete "tests_" prefix from the various table names.

- Drop the new created tables test_**:
```Shell
    psql -U postgres
    \c testnet_dcrdata

    drop table test_blocks, test_vins, test_transactions, test_tickets;
```

- Compress the *.sql file dump and delete the original version.