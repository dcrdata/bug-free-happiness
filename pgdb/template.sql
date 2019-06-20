\connect _DATABASE \\
DROP TABLE IF EXISTS test_addresses, test_agenda_votes, test_agendas, test_block_chain, test_misses, test_votes, test_vouts,  test_blocks, test_transactions, test_vins, test_tickets, test_meta;
CREATE TABLE test_addresses AS SELECT addresses.* FROM addresses JOIN transactions ON addresses.tx_hash = transactions.tx_hash WHERE transactions.block_height >= _START AND transactions.block_height <= _END;
CREATE TABLE test_agenda_votes AS SELECT * FROM agenda_votes ORDER BY RANDOM() LIMIT _COUNT;
CREATE TABLE test_agendas AS SELECT * FROM agendas;
CREATE TABLE test_block_chain AS SELECT block_chain.* FROM block_chain JOIN blocks ON blocks.id = block_chain.block_db_id WHERE blocks.height >= _START AND blocks.height <= _END;
CREATE TABLE test_blocks AS SELECT * FROM blocks WHERE height >= _START AND height <= _END;
CREATE TABLE test_misses AS SELECT * FROM misses WHERE height >= _START AND height <= _END;
CREATE TABLE test_tickets AS SELECT * FROM tickets WHERE block_height >= _START AND block_height <= _END;
CREATE TABLE test_transactions AS SELECT * FROM transactions WHERE block_height >= _START AND block_height <= _END;
CREATE TABLE test_vins AS SELECT vins.* FROM vins JOIN transactions ON vins.tx_hash = transactions.tx_hash WHERE transactions.block_height >= _START AND transactions.block_height <= _END;
CREATE TABLE test_votes AS SELECT votes.* FROM votes JOIN transactions ON votes.tx_hash = transactions.tx_hash WHERE transactions.block_height >= _START AND transactions.block_height <= _END;
CREATE TABLE test_vouts AS SELECT vouts.* FROM vouts JOIN transactions ON vouts.tx_hash = transactions.tx_hash WHERE transactions.block_height >= _START AND transactions.block_height <= _END;
CREATE TABLE test_meta AS SELECT * FROM meta;
