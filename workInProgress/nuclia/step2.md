# Using Nuclia


`pip install nucliadb_sdk`{{exec}}

`pip install sentence_transformers`{{exec}}


got the following error

```
Collecting mpmath>=0.19
  Downloading mpmath-1.3.0-py3-none-any.whl (536 kB)
     |████████████████████████████████| 536 kB 25.8 MB/s 
Building wheels for collected packages: sentence-transformers
  Building wheel for sentence-transformers (setup.py) ... done
  Created wheel for sentence-transformers: filename=sentence_transformers-2.2.2-py3-none-any.whl size=125922 sha256=16c6bf0a0d3b874007619b348cacac610ca889a84fd3f9328ab489e99c094ac1
  Stored in directory: /root/.cache/pip/wheels/5e/6f/8c/d88aec621f3f542d26fac0342bef5e693335d125f4e54aeffe
Successfully built sentence-transformers
Installing collected packages: packaging, fsspec, tqdm, filelock, huggingface-hub, joblib, regex, nltk, numpy, threadpoolctl, scipy, scikit-learn, sentencepiece, nvidia-nvjitlink-cu12, nvidia-cusparse-cu12, nvidia-cublas-cu12, nvidia-cusolver-cu12, nvidia-cuda-runtime-cu12, nvidia-curand-cu12, networkx, triton, mpmath, sympy, nvidia-cudnn-cu12, nvidia-nccl-cu12, nvidia-cuda-cupti-cu12, nvidia-cufft-cu12, nvidia-cuda-nvrtc-cu12, nvidia-nvtx-cu12, torch, pillow, torchvision, tokenizers, safetensors, transformers, sentence-transformers
ERROR: Could not install packages due to an EnvironmentError: [Errno 28] No space left on device: '/tmp/pip-unpacked-wheel-4wskyhuq/nvidia/cudnn/lib/libcudnn_cnn_train.so.8' -> '/usr/local/lib/python3.8/dist-packages/nvidia/cudnn/lib/libcudnn_cnn_train.so.8'
```

```
from nucliadb_sdk.client import Environment, NucliaDBClient
from nucliadb_sdk import KnowledgeBox
from sentence_transformers import SentenceTransformer
from nucliadb_sdk import create_knowledge_box, delete_kb

encoder = SentenceTransformer("all-MiniLM-L6-v2")
documents = [
    "In 2023, it appears that we are on the cusp of artificial general intelligence",
    "Neural networks are getting really smart in recent days!",
    "Rust is a really nice programming language!",
    "The sky is blue."
]

# delete_kb("my_new_kb")
my_kb = create_knowledge_box("my_new_kb")

vectorset_name = "all-MiniLM-L6-v2"

for i in range(0, len(documents)):
    document = documents[i]
    vectors = encoder.encode([document])
    resource_id = my_kb.upload(
        key='mykey' + str(i),
        text=document,
        labels=['programming/things'],
        vectors={vectorset_name: vectors[0]}
    )
```

`nano populardb.py`{{exec}}





```
vectorset_name = "all-MiniLM-L6-v2"
search_str = "Brains have axons and dendrites."
query_vectors = encoder. encode([search_str])
results = my_kb.search(
    vector = query_vectors[0],
    filter = ['programming/things'],
    vectorset=vectorset_name
)

for result in results:
    print(f"Text: {result.text}")
    print(f"Labels: {result. labels}")
    print(f"Score: {result.score}")
    print(f"Key: {result.key}")
    print(f"Score Type: {result.score_type}")
```

`nano querydb.py`{{exec}}