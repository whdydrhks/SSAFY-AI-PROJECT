!git clone https://huggingface.co/spaces/fffiloni/spectrogram-to-music riffusion
!pip install -qq -U typing pydub diffusers transformers accelerate scipy gradio

####################################################################################
import gradio as gr
import torch
from PIL import Image
import numpy as np
from diffusers import StableDiffusionPipeline
from diffusers import StableDiffusionImg2ImgPipeline
from IPython.display import Audio

from riffusion.spectro import wav_bytes_from_spectrogram_image, image_from_spectrogram

########################################################################################
device = "cuda" if torch.cuda.is_available() else "cpu"
MODEL_ID = "riffusion/riffusion-model-v1"
pipe = StableDiffusionPipeline.from_pretrained(MODEL_ID, torch_dtype=torch.float16)
pipe = pipe.to(device)

#########################################################################################
prompt = "Eminem style anger hiphop"
negative_prompt = "slow"
duration = 10 # T4에서는 10초 정도가 한계
width_duration = 512 + ((int(duration) - 5) * 128)
spec = pipe(prompt, negative_prompt=negative_prompt, height=512, width=width_duration).images[0]
spec

#########################################################################################
wav = wav_bytes_from_spectrogram_image(spec)
with open("output.wav", "wb") as f:
    f.write(wav[0].getbuffer())
Audio("output.wav")
