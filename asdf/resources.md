
https://www.youtube.com/watch?v=j7Qh-wIo5Zc

git clone https://github.com/DFE-Digital/rails-template.git



$ ruby --version
ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [arm64-darwin22]

$ rails --version
Rails 7.0.4

$ node --version
v18.1.0

$ yarn --version
1.22.19

$ foreman --version
0.87.2

$ pg_config --version
PostgreSQL 13.5


wip  gem install foreman

Use 'bundle install'  ! there is no gem file!

gem install foreman

rails new \
  --database=postgresql \
  --skip-bundle \
  --skip-git \
  --skip-jbuilder \
  --skip-hotwire \
  --skip-action-mailbox \
  --skip-action-mailer \
  --skip-action-text \
  --asset-pipeline=propshaft \
  --javascript=esbuild \
  --css=sass \
  -m https://raw.githubusercontent.com/DFE-Digital/rails-template/main/template.rb \
  apply-for-a-juggling-licence