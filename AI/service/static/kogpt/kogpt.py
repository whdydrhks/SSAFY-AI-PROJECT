import torch
from transformers import PreTrainedTokenizerFast, GPT2LMHeadModel

Q_TKN = "<usr>"
A_TKN = "<sys>"
BOS = '</s>'
EOS = '</s>'
MASK = '<unused0>'
SENT = '<unused1>'
PAD = '<pad>'

model = GPT2LMHeadModel.from_pretrained('skt/kogpt2-base-v2')

koGPT2_TOKENIZER = PreTrainedTokenizerFast.from_pretrained("skt/kogpt2-base-v2",
            bos_token=BOS, eos_token=EOS, unk_token='<unk>',
            pad_token=PAD, mask_token=MASK)

model = torch.load('service/static/kogpt/kogpt_chatbot_model_happy_50epoch.pt', map_location=torch.device('cpu'))
model.eval()

def kogpt(input_text):
    q = input_text
    a = ""
    sent = ""
    while True:
        input_ids = torch.LongTensor(koGPT2_TOKENIZER.encode(Q_TKN + q + SENT + sent + A_TKN + a)).unsqueeze(dim=0)
        pred = model(input_ids)
        pred = pred.logits
        gen = koGPT2_TOKENIZER.convert_ids_to_tokens(torch.argmax(pred, dim=-1).squeeze().tolist())[-1]
        if gen == EOS:
            break
        a += gen.replace("▁", " ")
    return a
