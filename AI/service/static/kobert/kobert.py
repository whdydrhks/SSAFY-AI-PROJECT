import torch
import torch.nn as nn
import random
import sys
sys.path.append('service/static/kobert')
from kobert_transformers import get_tokenizer

def load_wellness_answer():
    # root_path = "."
    category_path = "service/static/kobert/data/wellness_dialog_category.txt"
    answer_path = "service/static/kobert/data/wellness_dialog_answer.txt"
    
    with open(category_path, 'r', encoding='UTF8') as c_f:
        category_lines = c_f.readlines()
    a_f = open(answer_path, 'r', encoding='UTF8')

    answer_lines = a_f.readlines()

    category = {}
    answer = {}
    for line_num, line_data in enumerate(category_lines):
        data = line_data.split('    ')
        category[data[1][:-1]] = data[0]

    for line_num, line_data in enumerate(answer_lines):
        data = line_data.split('    ')
        keys = answer.keys()
        if (data[0] in keys):
            answer[data[0]] += [data[1][:-1]]
        else:
            answer[data[0]] = [data[1][:-1]]

    return category, answer


def kobert_input(tokenizer, str, device=None, max_seq_len=512):
    index_of_words = tokenizer.encode(str)
    token_type_ids = [0] * len(index_of_words)
    attention_mask = [1] * len(index_of_words)

    # Padding Length
    padding_length = max_seq_len - len(index_of_words)

    # Zero Padding
    index_of_words += [0] * padding_length
    token_type_ids += [0] * padding_length
    attention_mask += [0] * padding_length

    data = {
        'input_ids': torch.tensor([index_of_words]).to(device),
        'token_type_ids': torch.tensor([token_type_ids]).to(device),
        'attention_mask': torch.tensor([attention_mask]).to(device),
    }
    return data

# 답변과 카테고리 불러오기
category, answer = load_wellness_answer()

# 모델 준비
device = torch.device("cpu")
model = torch.load('service/static/kobert/kobert_chatbot_model_epoch60.pt', map_location=torch.device('cpu'))
model.to("cpu")
model.eval()
tokenizer = get_tokenizer()


def kobert(input_text):
    sent = input_text
    data = kobert_input(tokenizer, sent, device, 512)
    output = model(**data)
    logit = output[0]
    softmax_logit = torch.softmax(logit, dim=-1)
    softmax_logit = softmax_logit.squeeze()
    max_index = torch.argmax(softmax_logit).item()
    max_index_value = softmax_logit[torch.argmax(softmax_logit)].item()
    answer_list = answer[category[str(max_index)]]
    answer_len = len(answer_list) - 1
    answer_index = random.randint(0, answer_len)
    
    return answer_list[answer_index]