Feature: test has a shell redirection in it
  Scenario: try running a container with redirection
    Given container is started with command bash
    Then run sh -c '/usr/local/s2i/run > /tmp/boot.log 2>&1' in container and detach
    And  file /tmp/boot.log should contain java
