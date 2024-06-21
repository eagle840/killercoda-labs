Step 4




https://www.gradio.app/guides/gradio-lite#additional-requirements


WIP this appears to be fot micropip?
https://huggingface.co/docs/transformers.js/index


use https://huggingface.co/docs/transformers.js/en/index#quick-tour



```python
from transformers import pipeline
import gradio as gr

pipe = pipeline('sentiment-analysis')

def classify(text):
	return pipe(text)

demo = gr.Interface(classify, "textbox", "json")
demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

WIP getting

```
ImportError: cannot import name 'TypeAliasType' from 'typing_extensions' (/usr/local/lib/python3.8/dist-packages/typing_extensions.py)
```

`python app.py`{{exec}}

{{TRAFFIC_HOST1_8080}}
