**Why use it?** Ubuntu protects system Python, so direct `pip install` fails. Virtual environments give you an isolated sandbox to install freely.

**Setup**

```bash
python3 -m venv ~/myenv      # create
source ~/myenv/bin/activate  # activate
pip install numpy            # install packages
deactivate                   # exit when done
```

**Best practice:** Create the venv inside your project folder:

```bash
cd ~/myproject
python3 -m venv venv
source venv/bin/activate
```

**Don't move the venv folder** — paths inside it are hardcoded and it will break. Instead, delete and recreate it in the right location.