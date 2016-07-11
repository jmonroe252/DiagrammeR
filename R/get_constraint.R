#' Get constraint scores for one or more graph nodes
#' @description Get the constraint scores (based on
#' Burt's Constraint Index) for one or more nodes in a
#' graph.
#' @param graph a graph object of class
#' \code{dgr_graph}.
#' @return a data frame with constraint scores for one
#' or more graph nodes.
#' @examples
#' \dontrun{
#' # Create a random graph
#' graph <-
#'   create_random_graph(
#'     10, 22, set_seed = 1)
#'
#' # Get the constaint scores for all nodes in
#' # the graph
#' get_constraint(graph)
#' #>    node constraint
#' #> 1     1  0.3536111
#' #> 2     2  0.4172222
#' #> 3     3  0.4933333
#' #> 4     4  0.4528472
#' #> 5     5  0.3711188
#' #> 6     6  0.4583333
#' #> 7     7  0.3735494
#' #> 8     8  0.3072222
#' #> 9     9  0.4479167
#' #> 10   10  0.4447222
#' }
#' @importFrom influenceR constraint
#' @export get_constraint

get_constraint <- function(graph,
                           nodes = NULL) {

  # Convert the graph to an igraph object
  ig_graph <- to_igraph(graph)

  # Get the constraint scores for each of the
  # graph's nodes
  constraint_scores <- influenceR::constraint(ig_graph)

  # Create df with betweenness scores
  constraint_scores_df <-
    data.frame(node = names(constraint_scores),
               constraint = constraint_scores,
               stringsAsFactors = FALSE)

  return(constraint_scores_df)
}