# Dependancy checking 

## pip-tools

`pip install pip-tools`{{execute}}

this installs 2 tools

`pip-compile -h`{{execute}}

When you run `pip install <pkg>` it installs the latest package, which may break a module/program. 

create `common.in` with the packages you need

`echo click > common.in`{{}}

and run `pip-compile common.in`{{execute}} against it, and it will show you the present packages and versions. It also produces a common.txt file

You can the output that into requirements in order to get an exacte pakage inventory.

`pip-sync -h`{{execute}}

Using Pip sync in virtual environments installs only and just the items in the supplied file, so  it is different for pip install -r.  CHECK THIS

`pip install pip`{{execute}} 

## pipdeptree

`pip install pipdeptree`{{execute}}

`pipdeptree -h`{{execute}}



# downloading and installing

setup new folder and requirements.txt

`cd ~`{{execute}}

`mkdir dwn; cd dwn`{{execute}}

```
numpy>=1.8.2,<2.0.0
matplotlib>=1.3.1,<2.0.0
scipy>=0.14.0,<1.0.0
astroML>=0.2,<1.0
scikit-learn>=0.14.1,<1.0.0
rpy2>=2.4.3,<3.0.0
```

`pip install --download=/tmp -r requirements.txt`{{execute}}

`pip install --user --no-index --find-links=/tmp -r requirements.txt`{{execute}}


pulled from: https://stackoverflow.com/questions/32302379/could-not-find-a-version-that-satisfies-the-requirement-package

The above appears incorrect, used the following

mkdir tmp1

cd tmp1/

pip download jsmin==2.2.2

ls

tar -zxvf jsmin-2.2.2.tar.gz 

 ls

pip install jsmin-2.2.2

pip install jsmin-2.2.2.tar.gz 

 tree

ls

python -V

python3 setup.py install

 cd jsmin-2.2.2/

ls

python3 setup.py install

pip freeze 

# goto pipy.org and get the specific version file

wget https://files.pythonhosted.org/packages/17/73/615d1267a82ed26cd7c124108c3c61169d8e40c36d393883eaee3a561852/jsmin-2.2.2.tar.gz
  