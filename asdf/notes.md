# notes


### getting postgresel 13+

cd rails-template/
   33  pg_config --version
   34  sudo apt install postgresql-13 postgresql-client-13
   35  sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
   36  curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
   37  echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
   38  sudo apt update
   39  sudo apt install postgresql-13 postgresql-client-13
   40  pg_config --version

   apt install libreadline-dev

   git clone https://github.com/DFE-Digital/rails-template

   NEED an unprivelged user to run the following:

   ```bash
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
  ```