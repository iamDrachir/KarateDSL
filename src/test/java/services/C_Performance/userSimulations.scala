package services.C_Performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class userSimulations extends Simulation {
  val getSingleUser = scenario("google search, land on the karate github page, and search for a file").during(120 seconds) {
    exec(karateFeature("classpath:services/B_Web/googleSearch.feature"))
  }
  setUp(
    getSingleUser.inject(
      rampUsers(2) during (1 seconds)
    )
  )
}