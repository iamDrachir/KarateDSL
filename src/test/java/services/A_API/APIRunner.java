package services.A_API;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;
import static org.junit.Assert.assertTrue;

public class APIRunner {
    @Test
    public void testParallel(){
        Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
}
