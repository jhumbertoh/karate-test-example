package examples.outline;

import com.intuit.karate.junit5.Karate;

class DynamicRunner {
    
    @Karate.Test
    Karate testUsers() {
        return new Karate().feature("dynamic-csv").relativeTo(getClass());
    }    

}
