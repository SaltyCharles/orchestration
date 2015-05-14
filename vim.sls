{% if grains['os_family'] == 'RedHat' %}
{% set vim = 'vim-enhanced' %}
{% else %}
{% set vim = 'vim' %}
{% endif %}
{{ vim }}:
  pkg:
    - installed

emacs:
  pkg:
    - installed
  
nano:
  pkg:
    - removed

/root/.vimrc:
  file:
    - managed
    - source: salt://vim/vimrc
    - require:
      - pkg: vim
