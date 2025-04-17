# Gradio with Transformers




```python
from transformers import pipeline
import gradio as gr

pipe = pipeline('sentiment-analysis')

def classify(text):
	return pipe(text)

demo = gr.Interface(classify, "textbox", "json")

demo.launch(server_name="0.0.0.0", server_port=8080)
```{{copy}}

and run the app:

`python app.py`{{exec}}

{{TRAFFIC_HOST1_8080}}

and paste `We are very happy to introduce pipeline to the transformers repository.` into the text box.
