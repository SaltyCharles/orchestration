minion_setup:
  salt.function:
    - tgt: 'salt-ent'
    - name: cmd.run
    - arg:
      - salt-run cloud.profile prof=u14_512 instances=docker01,docker02,haproxy
