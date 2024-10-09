package insurance.api.tek.runner;

import com.intuit.karate.junit5.Karate;

public class Runner {

    @Karate.Test
    Karate testTags() {
        return Karate.run("classpath:insurance/api/tek/features").tags("@Regression").relativeTo(getClass());
    }

}
