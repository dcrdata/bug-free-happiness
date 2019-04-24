#### The Postgresql db dump was generated from testnet data as below:

- Login into the Postgres CLI shell by:
```Shell
    psql -U postgres
```

- While in the psql shell, connect to the dcrdata testnet db (or any other source data db of your choice).
```Shell
    \c testnet_dcrdata
```

- Execute the following commands to create new tables with the required tests data.
```Shell
    CREATE TABLE test_addresses AS SELECT addresses.* FROM addresses JOIN transactions ON addresses.tx_hash = transactions.tx_hash WHERE transactions.block_height < 200;
    CREATE TABLE test_agenda_votes AS SELECT * FROM agenda_votes LIMIT 200;
    CREATE TABLE test_agendas AS SELECT * FROM agendas;
    CREATE TABLE test_block_chain AS SELECT * FROM block_chain LIMIT 200;
    CREATE TABLE test_blocks AS SELECT * FROM blocks WHERE height < 200;
    CREATE TABLE test_misses AS SELECT * FROM misses WHERE height < 200;
    CREATE TABLE test_tickets AS SELECT * FROM tickets WHERE block_height < 200;
    CREATE TABLE test_transactions AS SELECT * FROM transactions WHERE block_height < 200;
    CREATE TABLE test_vins AS SELECT vins.* FROM vins JOIN transactions ON vins.tx_hash = transactions.tx_hash WHERE transactions.block_height < 200;
    CREATE TABLE test_votes AS SELECT * FROM votes WHERE height > -1 LIMIT 200;
    CREATE TABLE test_vouts AS SELECT vouts.* FROM vouts JOIN transactions ON vouts.tx_hash = transactions.tx_hash WHERE transactions.block_height < 200;
```

- Exit the psql shell and create a dump file with the newly created tables' data.
```Shell
    $ pg_dump -t test_addresses -t test_agenda_votes -t test_agendas -t \
        test_block_chain -t test_misses -t test_votes -t test_vouts  -t test_blocks -t test_transactions \
        -t test_vins -t test_tickets --no-comments --column-inserts -U postgres t_dcrdata > ~/pgsql_dump.sql
```

- Drop the new created tables with prefix **test_**:
```Shell
    psql -U postgres
    \c testnet_dcrdata

    DROP TABLE IF EXISTS test_addresses, test_agenda_votes, test_agendas, test_block_chain, test_misses,\
        test_votes, test_vouts,  test_blocks, test_transactions, test_vins, test_tickets;
```

- Compress the `pgsql_dump.sql` file dump and upload it.
