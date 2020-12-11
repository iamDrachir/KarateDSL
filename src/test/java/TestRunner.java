import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;
import static org.junit.Assert.assertTrue;

public class TestRunner {
    @Test
    public void testParallel(){
        Results results = Runner.parallel(getClass(), 5, "target/surefire-reports");
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
}
