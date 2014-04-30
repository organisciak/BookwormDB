# Configuring your system for Bookworm


## Apache setup
Apache setup is pretty easy: there are any number of sources for configuring your default apache installation to work.

Bookworm requires files in a web directory: for convenience, it's much easier if you name that folder the same as the name of the database. (So `http://benschmidt.org/SOTU` maps to the SOTU database). If using the D3 web interface, that should be sufficient to get you started (although the default search may need to be changed); if using the polish highcharts setup, some additional work may be necessary.

## MySQL setup
Bookworm uses a heavily customized my.cnf file for MySQL, though, in order to facilitate the creation of large b-tree indexes. This mostly involves things like allowing obscenely large temporary tables which makes index creation an order of magnitude faster. (Although still quite slow on a large Bookworm). We do not know of any substantial performance hits for this file. (For instance, MySQL is still quite snappy as a wordpress host).

There are some scripts located in `setup/MySQLsetup/` that rewrite your configuration file to include the specifications; back up your old my.cnf file first, because it will be rewritten. (And you'll lose things like comments). You can also make the changes by hand.




