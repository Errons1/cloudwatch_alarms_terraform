package com.example.demo;

import io.micrometer.core.annotation.Timed;
import io.micrometer.core.instrument.MeterRegistry;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@AllArgsConstructor
@RestController
public class AppController {
    
    private MeterRegistry meterRegistry;
    private static int postCounter;
    
    @Timed
    @GetMapping("/")
    public ResponseEntity<String> helloWorld() {
        log.info("GET helloWorld");  
        meterRegistry.counter("get_hello_world").increment();
        return new ResponseEntity<>("Hello World", HttpStatus.OK);
    }
    
    @Timed
    @PostMapping("/{amount}")
    public ResponseEntity<Object> counter(@PathVariable int amount) {
        if (amount == 5) {
//            return HttpStatus.valueOf(400);
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        
        log.info("POST counter");
        postCounter += amount;
        meterRegistry.gauge("counter", postCounter);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
