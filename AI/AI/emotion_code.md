## 💡 **감정 분석**

::: warning

- BERT의 장점인 사전 학습된 언어 모델의 지식을 활용하여 자연어 처리 태스크를 수행합니다. 

- BERT는 다양한 자연어 처리 태스크에 대한 사전 학습이 가능하므로, 적은 양의 데이터로도 높은 성능을 발휘할 수 있는 장점이 있습니다.
:::

### ✏️**process**
1. **입력 데이터 전처리**
- 입력 문장을 토큰화하여 토큰 ID로 변환합니다.
문장의 실제 길이를 나타내는 마스크를 생성합니다.
문장 쌍의 경우, 문장 간 구분을 나타내는 세그먼트 ID를 생성합니다.
2. **BERT 모델 적용**
- 전처리된 입력 데이터를 BERT 모델에 입력하여 출력값을 얻습니다.
- BERT 모델은 입력 토큰을 임베딩하고, 어텐션 메커니즘을 사용하여 각 토큰의 의미를 파악합니다.
- 출력값은 BERT의 출력 차원 크기인 768차원으로 나옵니다.
3. **출력값 변환**
- BERT 모델의 출력값 중 문장을 대표하는 pooler를 사용하여 768차원 벡터를 얻습니다.
- 벡터를 선형 레이어를 사용하여 클래스 레이블에 대한 로짓으로 변환합니다.
- 로짓은 각 클래스에 대한 점수를 의미합니다.
4. **손실 함수 및 최적화**
- logit과 실제 클래스 레이블 간의 차이를 측정하는 교차 엔트로피 손실 함수를 사용하여 학습합니다.
- 학습에는 확률적 경사 하강법(Stochastic Gradient Descent)의 변형 중 하나인 AdamW 옵티마이저를 사용합니다.
- 학습률과 학습 스케줄링 등을 조정하여 학습을 진행합니다.

### 🛠 Requirement packege
```diff
!pip install gluonnlp pandas tqdm   
!pip install mxnet
!pip install sentencepiece
!pip install transformers
!pip install torch
!pip install 'git+https://github.com/SKTBrain/KoBERT.git#egg=kobert_tokenizer&subdirectory=kobert_hf'
```

### ⚾️ Import
```python
import torch
from torch import nn
import torch.nn.functional as F
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import gluonnlp as nlp
import numpy as np
from tqdm import tqdm, tqdm_notebook
import pandas as pd
from sklearn.model_selection import train_test_split
from kobert_tokenizer import KoBERTTokenizer
from transformers import BertModel
from transformers import AdamW
from transformers.optimization import get_cosine_schedule_with_warmup

from google.colab import drive
drive.mount('/content/drive')
```
- **torch**
- **nn, optim, F, Dataset, DataLoader :** 파이토치 라이브러리의 하위 모듈, 신경망 모델, 최적화 알고리즘, 함수, 데이터셋 및 데이터 로더
- **gluonnlp :** MXNet 프레임 워크에서 사용되는 자연어 처리 라이브러리
- **numpy :** 다차원 행렬 관련 
- **pandas :** 데이터 처리 
- **KoBERTTokenizer :** KoBERT의 토크나이저
- **BertModel**
- **AdamW :** AdamW 최적화
- **get_cosine_schedule_with_warmup :** learning rate 스케줄링 적용 함수
- **drive.mount('/content/drive/') :** 구글 드라이브를 Colab에 동기화

- **device = torch.device("cuda:0") :** GPU 사용


### 🎾 파라미터
```python
# Setting parameters
max_len = 64
batch_size = 64
warmup_ratio = 0.1
num_epochs = 20
max_grad_norm = 1
log_interval = 200
learning_rate =  5e-5
```
__*파라미터 셋팅*__
- **max_len** 문장 최대 길이
- **batch_size**
- **num_epochs :** 전체 학습 데이터 학습 횟수
- **learning_rate :** 학습률


### 🧚‍♀️ BERT Dataset
```python
class BERTDataset(Dataset):
    def __init__(self, dataset, sent_idx, label_idx, bert_tokenizer,vocab, max_len,
                 pad, pair):
   
        transform = nlp.data.BERTSentenceTransform(
            bert_tokenizer, max_seq_length=max_len,vocab=vocab, pad=pad, pair=pair)
        
        self.sentences = [transform([i[sent_idx]]) for i in dataset]
        self.labels = [np.int32(i[label_idx]) for i in dataset]

    def __getitem__(self, i):
        return (self.sentences[i] + (self.labels[i], ))
         
    def __len__(self):
        return (len(self.labels))
```
- gluonnlp의 BERTSentenceTransform을 사용하여 입력 문장을 BERT 입력 형식에 맞게 변환합니다.
-transform 메서드를 사용하여 각 문장을 BERT 입력 형식에 맞게 변환

### 🧚‍♂️ BERT Classifier
```python 
class BERTClassifier(nn.Module):
    def __init__(self,
                 bert,
                 hidden_size = 768,
                 num_classes=6,
                 dr_rate=None,
                 params=None):
        super(BERTClassifier, self).__init__()
        self.bert = bert
        self.dr_rate = dr_rate
                 
        self.classifier = nn.Linear(hidden_size , num_classes)
        if dr_rate:
            self.dropout = nn.Dropout(p=dr_rate)
    
    def gen_attention_mask(self, token_ids, valid_length):
        attention_mask = torch.zeros_like(token_ids)
        for i, v in enumerate(valid_length):
            attention_mask[i][:v] = 1
        return attention_mask.float()

    def forward(self, token_ids, valid_length, segment_ids):
        attention_mask = self.gen_attention_mask(token_ids, valid_length)
        
        _, pooler = self.bert(input_ids = token_ids, token_type_ids = segment_ids.long(), attention_mask = attention_mask.float().to(token_ids.device))
        if self.dr_rate:
            out = self.dropout(pooler)
        return self.classifier(out)
```
- 입력 데이터의 패딩 부분을 제외하고, 실제 입력에 대한 어텐션 마스크를 생성하는 함수입니다.
- token_ids는 입력 문장을 토큰화한 결과
- gen_attention_mask 메서드를 사용하여 어텐션 마스크를 생성
- BERT 모델에 입력을 전달하여 출력을 계산합니다.


### 🔫 토크 나이저 / 모델 정의

```python
tokenizer = KoBERTTokenizer.from_pretrained('skt/kobert-base-v1')
bertmodel = BertModel.from_pretrained('skt/kobert-base-v1', return_dict=False)
vocab = nlp.vocab.BERTVocab.from_sentencepiece(tokenizer.vocab_file, padding_token='[PAD]')
tok = tokenizer.tokenize
```
- skt/kobert-base-v1 모델의 **사전 학습된 가중치** 로드
- BERTVocab 객체에 tokenizer.vocab_file 사전(vocab) 로드

### 💿 데이터 로드/ 전처리

```python
train_set = pd.read_csv('/content/drive/MyDrive/Colab Notebooks/감정분석dataset.csv', encoding='cp949')
validation_set = pd.read_csv('/content/drive/MyDrive/Colab Notebooks/감성대화말뭉치(최종데이터)_Validation.csv',encoding='cp949')
train_set = train_set.loc[:, ['sentiment', 'user']]
validation_set = validation_set.loc[:, ['감정_대분류', '사람문장1']]

train_set.dropna(inplace=True)
validation_set.dropna(inplace=True)
train_set.columns = ['label', 'data']
validation_set.columns = ['label', 'data']

train_set.loc[(train_set['label'] == '일상'), 'label'] = 0
train_set.loc[(train_set['label'] == '분노'), 'label'] = 1
train_set.loc[(train_set['label'] == '불안'), 'label'] = 2
train_set.loc[(train_set['label'] == '슬픔'), 'label'] = 3
train_set.loc[(train_set['label'] == '기쁨'), 'label'] = 4
train_set.loc[(train_set['label'] == '우울'), 'label'] = 5

validation_set.loc[(validation_set['label'] == '일상'), 'label'] = 0                    
validation_set.loc[(validation_set['label'] == '분노'), 'label'] = 1                   
validation_set.loc[(validation_set['label'] == '불안'), 'label'] = 2                    
validation_set.loc[(validation_set['label'] == '슬픔'), 'label'] = 3                    
validation_set.loc[(validation_set['label'] == '기쁨'), 'label'] = 4                    
validation_set.loc[(validation_set['label'] == '우울'), 'label'] = 5 
 
train_set_data = [[i, str(j)] for i, j in zip(train_set['data'], train_set['label'])]

# validation_set_data = [[i, str(j)] for i, j in zip(validation_set['data'], validation_set['label'])]

train_set_data, test_set_data = train_test_split(train_set_data, test_size = 0.2, random_state=4)
train_set_data = BERTDataset(train_set_data, 0, 1, tok, vocab, max_len, True, False)
test_set_data = BERTDataset(test_set_data, 0, 1, tok, vocab, max_len, True, False)
train_dataloader = torch.utils.data.DataLoader(train_set_data, batch_size=batch_size, num_workers=2)
test_dataloader = torch.utils.data.DataLoader(test_set_data, batch_size=batch_size, num_workers=2)
```

### 🧸 모델 학습
```python
model = BERTClassifier(bertmodel, dr_rate=0.5).to(device)
# Prepare optimizer and schedule (linear warmup and decay)
no_decay = ['bias', 'LayerNorm.weight']
optimizer_grouped_parameters = [
    {'params': [p for n, p in model.named_parameters() if not any(nd in n for nd in no_decay)], 'weight_decay': 0.01},
    {'params': [p for n, p in model.named_parameters() if any(nd in n for nd in no_decay)], 'weight_decay': 0.0}
]
optimizer = AdamW(optimizer_grouped_parameters, lr=learning_rate)
loss_fn = nn.CrossEntropyLoss()
t_total = len(train_dataloader) * num_epochs
warmup_step = int(t_total * warmup_ratio)
scheduler = get_cosine_schedule_with_warmup(optimizer, num_warmup_steps=warmup_step, num_training_steps=t_total)

for e in range(num_epochs):
    train_acc = 0.0
    test_acc = 0.0
    model.train()
    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(tqdm_notebook(train_dataloader)):
        optimizer.zero_grad()
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)
        valid_length= valid_length
        label = label.long().to(device)
        out = model(token_ids, valid_length, segment_ids)
        loss = loss_fn(out, label)
        loss.backward()
        torch.nn.utils.clip_grad_norm_(model.parameters(), max_grad_norm)
        optimizer.step()
        scheduler.step()  # Update learning rate schedule
        train_acc += calc_accuracy(out, label)
        if batch_id % log_interval == 0:
            print("epoch {} batch id {} loss {} train acc {}".format(e+1, batch_id+1, loss.data.cpu().numpy(), train_acc / (batch_id+1)))
    print("epoch {} train acc {}".format(e+1, train_acc / (batch_id+1)))
    model.eval()
    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(tqdm_notebook(test_dataloader)):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)
        valid_length= valid_length
        label = label.long().to(device)
        out = model(token_ids, valid_length, segment_ids)
        test_acc += calc_accuracy(out, label)
    print("epoch {} test acc {}".format(e+1, test_acc / (batch_id+1)))
```
**train 과 validation 진행**
#### **설정**
- BERTClassifier 클래스를 사용하여 모델 객체를 생성합니다.
- 모델은 BERT 모델과 클래스 분류를 위한 선형 레이어로 구성
- AdamW 옵티마이저를 사용하여 학습을 진행합니다.
- 가중치 감쇠(weight decay)를 적용하여 과적합을 방지합니다.
- 가중치 감쇠를 적용하지 않는 파라미터와 적용하는 파라미터를 구분하여 옵티마이저를 설정
- CrossEntropyLoss 함수를 사용하여 손실값을 계산합니다.
#### **학습 (for ~)**
- 모델을 학습 모드로 변경합니다.
- token_ids, segment_ids, valid_length, label 값을 GPU 올리고, model에 input -> out 
- out 값과 label 값을 사용하여 Cross Entropy Loss를 계산합니다.
- loss.backward() 함수를 호출해 모델의 각 파라미터에 대한 그래디언트를 계산
- optimizer.step() 함수를 호출하여 그래디언트 값을 사용하여 파라미터를 업데이트
- CosineAnnealingWarmRestarts 스케줄러 사용, 학습률을 조정
- 현재 배치의 학습 정확도 train_acc에 누적
- 현재 epoch의 학습 정확도를 출력
#### **평가**
- 모델 평가 모드
- 위와 마찬가지. 정확도 출력
### 📤 Predict
```python
def calc_accuracy(X,Y):
    max_vals, max_indices = torch.max(X, 1)
    train_acc = (max_indices == Y).sum().data.cpu().numpy()/max_indices.size()[0]
    return train_acc
def predict(sentence):
    dataset = [[sentence, '0']]
    test = BERTDataset(dataset, 0, 1, tok, vocab, max_len, True, False)
    test_dataloader = torch.utils.data.DataLoader(test, batch_size=batch_size, num_workers=2)
    model.eval()
    answer = 0
    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(test_dataloader):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)
        valid_length= valid_length
        label = label.long().to(device)
        out = model(token_ids, valid_length, segment_ids)
        for logits in out:
            logits = logits.detach().cpu().numpy()
            answer = np.argmax(logits)
    return answer
```
- predict 함수는 입력 문장을 입력 받아 해당 문장 감정 예측하는 함수
- 입력 문장을 dataset에 추가하여 BERTDataset 객체를 생성
- 모델 평가 모드(model.eval())
- DataLoader에서 배치 단위로 입력 데이터를 가져와 모델에 입력하여 예측 값을 얻습니다.
- 모델 출력 값에서 가장 큰 값에 해당하는 인덱스를 예측 값으로 반환
### 📩 OUT
```python
sentence = "오늘 갑자기 날씨가 추워져서 놀랐어"
predict(sentence) # 0 -> 일상
```