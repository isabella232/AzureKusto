% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tbl.R
\name{compute.tbl_kusto}
\alias{compute.tbl_kusto}
\title{Execute the query, store the results in a table, and return a reference to the new table}
\usage{
\method{compute}{tbl_kusto}(tbl, name = generate_table_name(), ...)
}
\arguments{
\item{tbl}{An instance of class tbl_kusto representing a Kusto table}

\item{name}{The name for the Kusto table to be created.
If name is omitted, the table will be named Rtbl_ + 8 random lowercase letters}

\item{...}{other parameters passed to the query}
}
\description{
Execute the query, store the results in a table, and return a reference to the new table
}
