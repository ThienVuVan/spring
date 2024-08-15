package com.docker.dockerspringboot;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.Builder;
import lombok.Getter;

@Entity
@Table(name = "account")
@Getter
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String name;

    public Account(String name) {
        this.name = name;
    }

    public Account() {

    }
}
