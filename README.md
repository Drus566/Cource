# Get cource, set cource
Rails app, that can get cource and set cource (dollar to ruble rate)
  
### Install
`make build` — build project and install the necessary dependencies
### Test
`make test` — run tests
### Use
`make run`

request 'localhost:3000/' - the cource page, that get cource
request 'localhost:3000/admin' - the admin page, that set cource:
* Value - cource value 
* Time  - time until which the cource will be set
* Date  - date until which the cource will be set

### Software:
* ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
* Rails 6.0.2.1
* Ubuntu 18.04.3 LTS

### Gems:
* rspec 
* foreman 

### JavaScript frameworks:
* Stimulus
* Flatpickr

### CSS frameworks:
* Spectre.css
