pip_setup:
  salt.function:
    - tgt: 'docker*'
    - name: cmd.run
    - arg:
      - wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

docker_setup:
  salt.state:
    - tgt: 'docker*'
    - sls: dock_apache.docker
    - require:
      - salt: pip_setup

docker_apache:
  salt.state:
    - tgt: 'docker*'
    - sls: dock_apache.dock_apache
    - require:
      - salt: docker_setup

haproxy_setup:
  salt.state:
    - tgt: 'haproxy*'
    - sls: haproxy-docker.haproxy.config
    - require:
      - salt: docker_apache

haproxy_ip:
  salt.function:
    - tgt: 'haproxy'
    - name: cmd.run
    - arg:
      - "/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'"
    - require:
      - salt: haproxy_setup
