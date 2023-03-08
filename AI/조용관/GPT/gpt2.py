pip install transformers
###################################################
import torch
from transformers import GPT2LMHeadModel, GPT2Tokenizer
#########################################################
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
model = GPT2LMHeadModel.from_pretrained('gpt2')
########################################################
sequence = ("Every time I see them, my heart races and I can't help but smile.",
            "I find myself daydreaming about them, imagining scenarios where we are together.",
            "Their every gesture and word leaves a deep impression on me, making me feel as if I'm under a spell")
#########################################################
inputs = tokenizer.encode(sequence, return_tensors='pt')
#########################################################
outputs = model.generate(inputs, max_length=200, do_sample=True, temperature=1, top_k=50)
#########################################################
text = tokenizer.decode(outputs[0], skip_special_tokens=True)
print(text)
