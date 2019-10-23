package examples

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class ExamplesKarateSimulation extends Simulation {

  //MockUtils.startServer()

  //val feeder = Iterator.continually(Map("catName" -> MockUtils.getNextCatName))

  /*val protocol = karateProtocol(
    "/cats/{id}" -> Nil,
    "/cats" -> pauseFor("get" -> 15, "post" -> 25)
  )*/

  val protocol = karateProtocol(
    "/users" -> Nil
  )

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val create = scenario("dynamic").exec(karateFeature("classpath:examples/outline/dynamic-csv.feature"))
  //val create = scenario("create").feed(feeder).exec(karateFeature("classpath:mock/cats-create.feature"))
  //val delete = scenario("delete").exec(karateFeature("classpath:mock/cats-delete.feature@name=delete"))
  //val custom = scenario("custom").exec(karateFeature("classpath:mock/custom-rpc.feature"))

  setUp(
    create.inject(rampUsers(2) during (5 seconds)).protocols(protocol)
    //create.inject(rampUsers(10) during (5 seconds)).protocols(protocol),
    //delete.inject(rampUsers(5) during (5 seconds)).protocols(protocol)
    //custom.inject(rampUsers(10) during (5 seconds)).protocols(protocol)
  )
}
