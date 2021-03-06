% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_edges_from_table.R
\name{add_edges_from_table}
\alias{add_edges_from_table}
\title{Add edges and attributes to graph from a table}
\usage{
add_edges_from_table(graph, table, from_col, to_col, ndf_mapping,
  rel_col = NULL, set_rel = NULL, drop_cols = NULL)
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph}.}

\item{table}{either a path to a CSV file, or, a data
frame object.}

\item{from_col}{the name of the table column from
which edges originate.}

\item{to_col}{the name of the table column to
which edges terminate.}

\item{ndf_mapping}{a single character value for
the mapping of the \code{from} and \code{to} columns
in the external table (supplied as \code{from_col}
and \code{to_col}, respectively) to a column in the
graph's internal node data frame (ndf).}

\item{rel_col}{an option to apply a column of data
in the table as \code{rel} attribute values.}

\item{set_rel}{an optional string to apply a
\code{rel} attribute to all edges created from the
table records.}

\item{drop_cols}{an optional character vector for
dropping columns from the incoming data.}
}
\value{
a graph object of class \code{dgr_graph}.
}
\description{
Add edges and their attributes to an
existing graph object from data in a CSV file or a
data frame.
}
\examples{
\dontrun{
# Create an empty graph and then add
# nodes to it from a CSV file; in this case
# we are using the `currencies` CSV file
# that's available in the package
graph <-
  create_graph() \%>\%
  add_nodes_from_table(
    system.file("extdata", "currencies.csv",
                package = "DiagrammeR"))

# Now we want to add edges to the graph
# using a similar CSV file that contains
# exchange rates between several currencies;
# the common attribute is the ISO-4217
# currency code
graph_1 <-
  graph \%>\%
  add_edges_from_table(
    system.file("extdata", "usd_exchange_rates.csv",
                package = "DiagrammeR"),
    from_col = "from_currency",
    to_col = "to_currency",
    ndf_mapping = "iso_4217_code")

# View part of the graph's internal edge data
# frame (edf) using `get_edge_df()`
graph_1 \%>\% get_edge_df() \%>\% head()
#>   id from to  rel cost_unit
#> 1  1  148  1 <NA>  0.272300
#> 2  2  148  2 <NA>  0.015210
#> 3  3  148  3 <NA>  0.008055
#> 4  4  148  4 <NA>  0.002107
#> 5  5  148  5 <NA>  0.565000
#> 6  6  148  6 <NA>  0.006058

# If you would like to assign any of the table's
# columns as `rel` attribute, this can done with
# the `rel_col` argument; to set a static `rel`
# attribute for all edges, use `set_rel`
graph_2 <-
  graph \%>\%
  add_edges_from_table(
    system.file("extdata", "usd_exchange_rates.csv",
                package = "DiagrammeR"),
    from_col = "from_currency",
    to_col = "to_currency",
    ndf_mapping = "iso_4217_code",
    set_rel = "from_usd")

# View part of the graph's internal edge data
# frame (edf) using `get_edge_df()`
graph_2 \%>\% get_edge_df() \%>\% head()
#>   id from to      rel cost_unit
#> 1  1  148  1 from_usd  0.272300
#> 2  2  148  2 from_usd  0.015210
#> 3  3  148  3 from_usd  0.008055
#> 4  4  148  4 from_usd  0.002107
#> 5  5  148  5 from_usd  0.565000
#> 6  6  148  6 from_usd  0.006058
}
}
