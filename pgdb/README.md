# PostgreSQL test database generation

### Using the script

A script, `generate.sh`, is provided for generating simple subsets of most tables
for a designated range of block heights. To generate a dump from the dcrdata
database for the blocks with height from 0 to 8191 (inclusive), you would invoke
the generator script with

`./generate.sh dcrdata 0 8191`

This results in two compressed files with names `pgsql_0-8191.tar.xz` and
`pgsql_0-8191.zip`.

### Manual Generation

To generate files manually, you can follow these steps.

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
    DROP TABLE IF EXISTS test_addresses, test_agenda_votes, test_agendas, test_block_chain, test_misses, test_votes, test_vouts,  test_blocks, test_transactions, test_vins, test_tickets, test_meta;
    CREATE TABLE test_addresses AS SELECT addresses.* FROM addresses JOIN transactions ON addresses.tx_hash = transactions.tx_hash WHERE transactions.block_height <= 200;
    CREATE TABLE test_agenda_votes AS SELECT * FROM agenda_votes ORDER BY RANDOM() LIMIT 200;
    CREATE TABLE test_agendas AS SELECT * FROM agendas;
    CREATE TABLE test_block_chain AS SELECT block_chain.* FROM block_chain JOIN blocks ON blocks.id = block_chain.block_db_id WHERE blocks.height <= 200;
    CREATE TABLE test_blocks AS SELECT * FROM blocks WHERE height <= 200;
    CREATE TABLE test_misses AS SELECT * FROM misses WHERE height <= 200;
    CREATE TABLE test_tickets AS SELECT * FROM tickets WHERE block_height <= 200;
    CREATE TABLE test_transactions AS SELECT * FROM transactions WHERE block_height <= 200;
    CREATE TABLE test_vins AS SELECT vins.* FROM vins JOIN transactions ON vins.tx_hash = transactions.tx_hash WHERE transactions.block_height <= 200;
    CREATE TABLE test_votes AS SELECT votes.* FROM votes JOIN transactions ON votes.tx_hash = transactions.tx_hash WHERE transactions.block_height <= 200;
    CREATE TABLE test_vouts AS SELECT vouts.* FROM vouts JOIN transactions ON vouts.tx_hash = transactions.tx_hash WHERE transactions.block_height <= 200;
    CREATE TABLE test_meta AS SELECT * FROM meta;
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
