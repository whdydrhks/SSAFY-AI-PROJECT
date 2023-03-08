pip install transformers
###########################################

from transformers import pipeline
generator = pipeline('text-generation', model='EleutherAI/gpt-neo-1.3B')
###########################################
text = 'What would be a good question to ask?'

###########################################
result = generator(text, max_length=100, do_sample=True, temperature=0.9)

###########################################
print(result[0]['generated_text'])

###########################################
str = result[0]['generated_text']
for s in str:
  if s=='.': print('.')
  else: print(s, end="")
