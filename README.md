# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.


---

## File System Project (Create, See, Edit and Destroy Folders/Subfolders. Create, See and Destroy Files)

Dependencies:
* Ruby 2.7.2
* Rails 6.1.0
* Node.js 14.15.1

### Getting Started

* Clone the repository:
```
git clone git@github.com:pedRo-shd/ruby-dev-test-1.git
```

* Go to the project
```
cd ruby-dev-test-1
```

* Run the commands below, after installing Dependencies:
```
bundle install
```
```
bundle exec rails webpacker:install
```
```
yarn install
```
```
bundle exec rails db:create db:migrate
```
```
bundle exec rspec
```
```
bundle exec rails s
```
