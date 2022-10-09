#!/usr/bin/expect
while {1} {
    expect "a" {send "hello"}\
           "b" {break}\
           "i" {puts "you are right"}
       }
