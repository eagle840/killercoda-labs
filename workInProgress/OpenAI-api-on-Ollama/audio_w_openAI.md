When dealing with Large Language Model (LLM) audio, OpenAI handles it in three distinct ways depending on the latency and workflow requirements: [1] (https://developers.openai.com/api/docs/guides/audio)
1. Native Multimodal Audio (Chat Completions API): The newest approach using GPT-4o. Instead of converting speech-to-text, reasoning, and converting text-to-speech with separate models, the neural network natively understands and generates audio tensors directly. [1] (https://openai.com/index/introducing-the-realtime-api/), [2] (https://developers.openai.com/api/docs/guides/audio), [3] (https://developers.openai.com/cookbook/examples/gpt4o/introduction_to_gpt4o)
2. Realtime API (WebSockets): Designed for bidirectional, ultra-low latency, full-duplex conversations (like ChatGPT’s Advanced Voice Mode) where user interruptions must be handled instantly. [1] (https://www.youtube.com/watch?v=lOypO-ngBJ8), [2] (https://openai.com/index/introducing-the-realtime-api/)
3. Legacy Pipeline (Whisper + TTS Models): The traditional approach using separate API endpoints for text-to-speech (tts-1) and speech-to-text (whisper-1). [1] (https://www.assemblyai.com/blog/python-voice-agent-tool-calling), [2] (https://github.com/openai/openai-python/blob/main/examples/audio.py)
Below are Python examples demonstrating how OpenAI handles these paradigms natively.

1. Native Audio Input & Output (GPT-4o Chat Completions)

With the gpt-4o-audio-preview model, you can feed a raw audio file directly to the model as an input modality, and instruct it to answer back with an audio file natively. [1] (https://developers.openai.com/api/docs/models/gpt-4o-audio-preview), [2] (https://developers.llamaindex.ai/python/framework/integrations/llm/openai/)
The audio returned from OpenAI is encoded in Base64 PCM16 or WAV bytes, which you can unwrap and save to disk. [1] (https://community.openai.com/t/gpt4-audio-preview-with-streaming-of-audio-output/1094301), [2] (https://developers.llamaindex.ai/python/framework/integrations/llm/openai/), [3] (https://medium.com/thedeephub/building-a-voice-enabled-python-fastapi-app-using-openais-realtime-api-bfdf2947c3e4)
python
import base64
from openai import OpenAI

client = OpenAI()

# Read a local audio file and encode it to base64
with open("user_question.wav", "rb") as audio_file:
    audio_base64 = base64.b64encode(audio_file.read()).decode("utf-8")

# Send to GPT-4o with audio modality enabled
response = client.chat.completions.create(
    model="gpt-4o-audio-preview",
    modalities=["text", "audio"],  # Instructs the model to reason and output both
    audio={"voice": "alloy", "format": "wav"}, # Choose preferred voice and format
    messages=[
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "Please answer this audio question."},
                {
                    "type": "input_audio",
                    "input_audio": {
                        "data": audio_base64,
                        "format": "wav"
                    }
                }
            ]
        }
    ]
)

# Extract the text transcript of what the LLM said
print("Transcript:", response.choices[0].message.audio.transcript)

# Extract and save the raw audio output file
audio_bytes = base64.b64decode(response.choices[0].message.audio.data)
with open("llm_response.wav", "wb") as f:
    f.write(audio_bytes)
Use code with caution.

2. The Realtime API (Low-Latency Voice)

For a dynamic voice application where you speak into a microphone and the AI can be interrupted mid-sentence, standard HTTP requests are too slow. OpenAI uses WebSockets for this. [1] (https://www.assemblyai.com/blog/python-voice-agent-tool-calling), [2] (https://www.youtube.com/watch?v=lOypO-ngBJ8)
Because the Python SDK handles standard endpoints natively, developer pipelines often connect to the Realtime API endpoint (wss://://openai.com) using Python's websockets or asyncio libraries. [1] (https://www.youtube.com/watch?v=rw3S7BbKh0o&t=104), [2] (https://www.youtube.com/watch?v=lOypO-ngBJ8)
• Input: Client continuously streams raw 24kHz audio chunks (NumPy arrays turned to Base64) to the server every few milliseconds.
• Output: The server streams audio chunks back to the client.
• Interruption Handling: If the client transmits data while the server is talking, the server fires a response.cancel event, truncates the audio queue, and stops talking immediately. [1] (https://www.youtube.com/watch?v=xMkbcSiS47o&t=381), [2] (https://www.youtube.com/watch?v=lOypO-ngBJ8), [3] (https://www.assemblyai.com/blog/python-voice-agent-tool-calling)

3. Traditional Sequential Pipeline (Whisper + TTS)

If you don't need the model to understand tone, inflection, or emotion, you can use the standalone audio microservices. This splits the billing and compute cleanly into separate steps. [1] (https://developers.openai.com/api/docs/guides/audio), [2] (https://www.assemblyai.com/blog/python-voice-agent-tool-calling)
python
from pathlib import Path
from openai import OpenAI

client = OpenAI()

# Step 1: Transcribe user speech to text using Whisper
transcription = client.audio.transcriptions.create(
    model="whisper-1", 
    file=open("input_voice.mp3", "rb")
)
user_text = transcription.text

# Step 2: Pass text to standard LLM
completion = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": user_text}]
)
reply_text = completion.choices[0].message.content

# Step 3: Convert text reply back into an audio file
speech_file_path = Path(__file__).parent / "speech.mp3"
with client.audio.speech.with_streaming_response.create(
    model="tts-1",
    voice="alloy",
    input=reply_text
) as response:
    response.stream_to_file(speech_file_path)
Use code with caution.

Summary of Differences

• Token Costs: Native audio passes audio tokens natively, which are more expensive than text tokens but cheaper than separate Whisper/TTS steps for short audio loops. [1] (https://www.youtube.com/watch?v=7MWBkdzeyJ4)
• Emotion Preservation: The traditional pipeline loses tone. If you scream happily into Whisper, it just reads out the plain text to the LLM. GPT-4o native audio actually hears the scream and can respond with an equally excited tone.
Are you considering building an interactive voice agent that handles real-time audio streams, or are you looking to process pre-recorded audio files asynchronously?
