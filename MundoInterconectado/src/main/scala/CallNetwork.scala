/* Call Network */

import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import org.apache.spark.graphx._
import org.apache.spark.rdd.RDD

object CallNetwork {

  def main(args: Array[String]) {

    // Get Spark Context
    val conf = new SparkConf().setAppName("Call Network")
    val sc = new SparkContext(conf)

    // Create TECI graph
    val alumns: RDD[(VertexId, (String, String))] =
      sc.parallelize {
        Array(
          (1L, ("Isabel García", "student")),
          (2L, ("Elena Castilla", "student")),
          (3L, ("Adan Rodríguez", "student")),
          (4L, ("Diego Fernández", "student")),
          (5L, ("Jaime Magro", "student")),
          (6L, ("Estíbaliz Gómez", "student")),
          (7L, ("Victor Aceña", "student")),
          (8L, ("Alejandro Morales", "student")),
          (9L, ("Paula Nacenta", "student")),
          (10L, ("David Díaz", "student")),
          (11L, ("Laura Palomo", "student")),
          (12L, ("Laura Muñoz", "student")),
          (13L, ("Rosa Rodriguez", "student")),
          (14L, ("Federico Alfaro", "student")),
          (15L, ("Rodrigo Cañas", "student")),
          (16L, ("Marina Fernandez", "student")),
          (17L, ("Roberto Morales", "student")),
          (18L, ("Santiago Dobon", "student")))
      }

    // Create an RDD for edges
    val relationships: RDD[Edge[String]] =
      sc.parallelize(
        Array(
          Edge(7L, 3L, "colleague"), Edge(7L, 18L, "colleague"),
          Edge(8L, 2L, "colleague"), Edge(8L, 11L, "colleague"),
          Edge(2L, 8L, "colleague"), Edge(2L, 11L, "colleague"),
          Edge(14L, 3L, "colleague"), Edge(14L, 18L, "colleague"),
          Edge(6L, 8L, "colleague"), Edge(6L, 3L, "colleague"),
          Edge(5L, 3L, "colleague"), Edge(5L, 18L, "colleague"),
          Edge(10L, 3L, "colleague"), Edge(10L, 5L, "colleague"),
          Edge(3L, 6L, "colleague"), Edge(3L, 5L, "colleague"),
          Edge(11L, 18L, "colleague"), Edge(11L, 8L, "colleague"),
          Edge(1L, 8L, "colleague"), Edge(1L, 18L, "colleague"),
          Edge(18L, 2L, "colleague"), Edge(18L, 5L, "colleague"),
          Edge(12L, 14L, "colleague"), Edge(12L, 2L, "colleague"),
          Edge(13L, 3L, "colleague"), Edge(13L, 11L, "colleague"),
          Edge(9L, 14L, "colleague"), Edge(9L, 18L, "colleague"),
          Edge(4L, 3L, "colleague"), Edge(4L, 18L, "colleague"),
          Edge(16L, 3L, "colleague"), Edge(16L, 18L, "colleague"),
          Edge(15L, 13L, "colleague"), Edge(15L, 18L, "colleague")))


    // Define a default user in case there are relationship with missing user
    val defaultUser = ("John Doe", "Missing")

    // Build the initial Graph
    val graph = Graph(alumns, relationships, defaultUser)

    // Calculate PageRank
    val prGraph = graph.pageRank(0.1)
    print("The page rank is: " + prGraph)
    prGraph.vertices.foreach(v => println(v))

    val titleAndPrGraph = graph.outerJoinVertices(prGraph.vertices) {
      (v, title, rank) => (rank.getOrElse(0.0), title)
    }

    titleAndPrGraph.vertices.top(10) {
      Ordering.by((entry: (VertexId, (Double, (String, String)))) => entry._2._1)
    }.foreach(t => println(t._2._2 + ": " + t._2._1))
  }
}