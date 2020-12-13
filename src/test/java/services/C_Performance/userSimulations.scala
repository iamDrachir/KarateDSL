package services.C_Performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class userSimulations extends Simulation {
  val getSingleUser = scenario("This is to test search api for").during(120 seconds) {
    exec(karateFeature("classpath:services/A_API/google/search.feature"))
  }
  setUp(
    getSingleUser.inject(
      rampUsers(2) during (1 seconds)
    )
  )
}