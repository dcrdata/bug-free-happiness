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
    CREATE TABLE test_addresses AS SELECT * FROM addresses WHERE block_time > '2019-02-17 03:23:23+03' LIMIT 200;
    CREATE TABLE test_agenda_votes AS SELECT * FROM agenda_votes LIMIT 200;
    CREATE TABLE test_agendas AS SELECT * FROM agendas;
    CREATE TABLE test_block_chain AS SELECT * FROM block_chain LIMIT 200;
    CREATE TABLE test_blocks AS SELECT * FROM blocks WHERE height > 131800 LIMIT 200;
    CREATE TABLE test_misses AS SELECT * FROM misses WHERE height > 131800 LIMIT 200;
    CREATE TABLE test_tickets AS SELECT * FROM tickets WHERE block_height > 131800 LIMIT 200;
    CREATE TABLE test_transactions AS SELECT * FROM transactions WHERE block_height > 131800 LIMIT 200;
    CREATE TABLE test_vins AS SELECT * FROM vins WHERE block_time > '2019-02-17 03:23:23+03' LIMIT 200;
    CREATE TABLE test_votes AS SELECT * FROM votes WHERE height > 131800 LIMIT 200;
    CREATE TABLE test_vouts AS SELECT * FROM vouts LIMIT 200;
```

- Exit the postgres shell and create a dump file with the newly created tables's data.
```Shell
    bug-free-happiness git:(master) ✗ pg_dump -t test_addresses -t test_agenda_votes -t test_agendas -t \
            test_block_chain -t test_misses -t test_votes -t test_vouts  -t test_blocks -t test_transactions \
            -t test_vins -t test_tickets --no-comments --column-inserts -U postgres t_dcrdata > pgdb/pgsql_dump.sql;
```

- Drop the new created tables test_**:
```Shell
    psql -U postgres
    \c testnet_dcrdata

    drop table if exists test_addresses, test_agenda_votes, test_agendas, test_block_chain, test_misses,\
     test_votes, test_vouts,  test_blocks, test_transactions, test_vins, test_tickets;
```

- Compress the *.sql file dump and delete the original version.