package com.docker.dockerspringboot;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class AccountController {
    private final AccountRepository accountRepository;
    @GetMapping("/register")
    public ResponseEntity<?> Register(@RequestParam String name){
        Account account = new Account(name);
        accountRepository.save(account);
        return ResponseEntity.ok("register ok");
    }

    @GetMapping("/account")
    public ResponseEntity<?> GetAccount(@RequestParam String name){
        Account account = accountRepository.findAccountByName(name);
        return new ResponseEntity<>("ID: " + account.getId() + " Name: " + account.getName(), HttpStatus.OK);
    }
}
