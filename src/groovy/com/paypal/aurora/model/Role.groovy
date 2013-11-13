package com.paypal.aurora.model

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class Role {
    String name
    String id

    Role() {
    }

    Role(def role) {
        if(role && role.id && role.name) {
            name = role.name
            id = role.id
        }
    }

    @Override
    public String toString() {
        return "Role{" +
                "name='" + name + '\'' +
                ", id='" + id + '\'' +
                '}';
    }
}
