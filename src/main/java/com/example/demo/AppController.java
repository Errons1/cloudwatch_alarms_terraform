package com.example.demo;

import io.micrometer.core.annotation.Timed;
import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
public class AppController implements ApplicationListener<ApplicationReadyEvent> {
    
    private final MeterRegistry meterRegistry;
//    private static long counter;
    private final Map<String, Long> map = new HashMap<>();
    
    public AppController(MeterRegistry meterRegistry) {
        this.meterRegistry = meterRegistry;
        map.put("counter", 0L);
    }

    @Timed
    @GetMapping("/")
    public ResponseEntity<String> helloWorld() {
        log.info("GET helloWorld");  
        meterRegistry.counter("get_hello").increment();
        MultiValueMap<String, String> map = new HttpHeaders();
        map.add("Connection", "close");
        return new ResponseEntity<>("Hello World", map, HttpStatus.OK);
    }
    
    @Timed
    @PostMapping("/{amount}")
    public ResponseEntity<Object> counter(@PathVariable int amount) {
        if (amount == 5) {
//            return HttpStatus.valueOf(400);
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        
        log.info("POST counter");
        map.put("counter", map.get("counter"));
//        meterRegistry.gauge("post_hello", counter);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Override
    public void onApplicationEvent(ApplicationReadyEvent applicationReadyEvent) {
        // Verdi av total
        Gauge.builder("post_hello", map, m -> m.get("counter")).register(meterRegistry);
    }
    

}
