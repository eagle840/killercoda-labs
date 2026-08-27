# Step 2: Launch OpenCode and Connect a Free Model

Now that OpenCode is installed, let's launch the environment and connect to a free AI model.

### 1. Launch OpenCode

First lets create a folder to work in:

```bash
mkdir project; cd project
```{{exec}}

Simply run:

```bash
opencode
```{{exec}}

### 2.Using a free model

In the center window, notice opencode is in the 'build' mode, and then shows the AI model you're using and the provider.

You can use  `/models`{{copy}}  to select free models, and common paid services.

### 3. (Optional) Connect a Model

Open code allows you to connect to multiple different AI providers, with different authenication methods.
Inside the OpenCode terminal interface:
 
1. Initiate a connection session:
   ```bash
   /connect
   ```{{copy}}
2. Select the **OpenCode Zen** tier.
3. Choose a free model (e.g., **deepc4-flash-free**).

You are now ready to start AI-assisted development!
