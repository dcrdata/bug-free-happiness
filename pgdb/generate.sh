#!/usr/bin/env bash

# Usage
# /generate.sh database start end [agenda-votes]

# Generates a .sql for a subset of the desired dcrdata `database`, with blocks in
# the range `start` to `end`. An optional parameter, `agenda-votes`, will set
# the number of random agenda votes selected. If not set, the number of votes
# will be set to the number of blocks in the range.

TEMPLATE=`cat template.sql`

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then
    echo "At least three arguments needed"
    echo "example: ./generate.sh database start end [agenda-votes]"
    exit 1
fi

DATABASE=$1
START=$2
END=$3
COUNT=`expr "$END" - "$START"`
if [ "$4" != "" ]; then
  COUNT=$3
fi

TEMPLATE=`echo "$TEMPLATE" | sed "s/_DATABASE/$DATABASE/g"`
TEMPLATE=`echo "$TEMPLATE" | sed "s/_START/$START/g"`
TEMPLATE=`echo "$TEMPLATE" | sed "s/_END/$END/g"`
SQL=`echo "$TEMPLATE" | sed "s/_COUNT/$COUNT/g"`

OPFILE="pgsql_$START-$END"

echo "$SQL" | psql -U postgres

pg_dump -t test_addresses -t test_agenda_votes -t test_agendas -t \
        test_block_chain -t test_misses -t test_votes -t test_vouts  -t test_blocks -t test_transactions \
        -t test_vins -t test_tickets -t test_meta --column-inserts -U postgres "$DATABASE" > ./"$OPFILE".sql

tar -cJf "$OPFILE".tar.xz "$OPFILE".sql

zip "$OPFILE".zip "$OPFILE".sql

rm "$OPFILE".sql
