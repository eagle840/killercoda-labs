# Step 3: Run the Model and Execute a Query

Now let's run the model and perform a simple query directly from the command line.

**Note:** You can find documentation and details for the `tinyllama` model at: https://ollama.com/library/tinyllama

### Task
1. **Run the `tinyllama` model**:
   ```bash
   ollama run tinyllama
   ```{{exec interrupt}}
   *You should now see the `>>>` prompt.*

2. **Interact with the model**:
   Once inside the interactive prompt, you can ask a question:
   ```bash
   What is the capital of France?
   ```

3. **Explore interactive commands**:
   - Get help:
     ```bash
     /?
     ```
   - Check system info:
     ```bash
     /show system
     ```
   - Exit the interactive mode:
     ```bash
     /bye
     ```

4. **Run a query directly**:
   You can also run a query from the command line without entering the interactive mode:
   ```bash
   ollama run tinyllama "What is the capital of France?"
   ```{{exec}}
