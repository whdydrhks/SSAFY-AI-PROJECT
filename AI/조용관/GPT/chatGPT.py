import os
import openai

openai.api_key ="~~자신의 API키 넣기~~"
prompt = input("무엇을 Chat GPT에게 물어볼까요?")

response = openai.Completion.create(
    model = "text-davinci-003",
    prompt = prompt,
    temperature=1,
    max_tokens=4000
)

#print("==========================")
print(str(response["choices"][0]["text"]).strip())
result = str(response["choices"][0]["text"]).strip()
for res in result:
  if(res=='.'): print('.')
  else: print(res, end="")
#print("==========================")
