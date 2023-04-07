# 🗿 AI 🩺 사용 모델 : KoBERT / KoGPT2
---

## 🛹 KoBERT ?

- Bert 모델의 한국어 버전으로, SKT에서  구글의 BERT 모델을 바탕으로 개발하였습니다. 

- 자연어 처리(NLP)가 가능한 사전 학습된 언어 모델입니다.

- 한국어 문장 분류, 개체명 인식, 문장 유사도를 파악할 수 있습니다.

- 네이버에서 공개한 한글 위키피디아 데이터를 사전 학습하였습니다.

- [KoBERT 깃허브](https://github.com/SKTBrain/KoBERT)

--- 
## 🛶 BERT?
- BERT는 "Bidirectional Encoder Representations from Transformers"의 약어로, 구글에서 개발한 사전 학습된 언어 모델입니다. 
- BERT의 장점인 사전 학습된 언어 모델의 지식을 활용하여 문장 분류, 문장 유사도, 질문 응답 등의 자연어 처리 태스크를 수행합니다.
- 적은 양의 데이터로도 높은 성능을 발휘할 수 있는 장점이 있습니다.

- Transformer라는 모델 구조를 사용합니다. 
    * Transformer는 Attention mechanism을 사용하여 입력된 단어들 사이의 의존 관계를 찾아내는 모델입니다.
- [BERT 깃허브](https://github.com/google-research/bert)

---

## 🛫 KoGPT2 ?

- KoGPT2는 SKT에서 개발한 한국어 자연어 처리를 위한 GPT 모델입니다. GPT는 Generative Pre-trained Transformer의 약자로, 트랜스포머(Transformer) 모델을 이용하여 텍스트 생성에 대한 학습을 수행합니다.

- KoGPT2는 한국어 문장에 대한 토큰화(tokenization), 임베딩(embedding), GPT 모델 학습 및 텍스트 생성을 수행할 수 있는 모듈들을 제공합니다. 이를 이용하여 다양한 한국어 자연어 처리 태스크에 활용할 수 있습니다. 
- KoGPT2를 이용하여 자연어 처리 태스크를 수행하려면, 먼저 문장을 토큰화하고 KoGPT 모델에 입력으로 넣어 예측값을 얻을 수 있습니다. 이후, 얻은 예측값을 이용하여 다양한 자연어 처리 태스크를 수행할 수 있습니다.
- [KoGPT2 깃허브](https://github.com/SKT-AI/KoGPT2)
---

## ⛵ GPT2
- GPT-2 (Generative Pre-trained Transformer 2)는 OpenAI에서 개발한 자연어 처리를 위한 인공지능 모델입니다. 
- GPT-2는 Transformer 아키텍처를 사용하며, 텍스트 생성, 기계 번역, 질의 응답, 요약, 감성 분석 등 다양한 자연어 처리 작업에 대해 높은 성능을 보입니다.

- [GPT-2 깃허브](https://github.com/openai/gpt-2)

---

## 💡 **감정 분석 👉 KoBERT**

### ✏️ **Process**

1. **입력 데이터 전 처리**
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

### 🧾 Dataset
![감정분석](https://user-images.githubusercontent.com/109534450/229683701-ceb7d12e-81bc-478a-8efb-519c14c7ad9c.PNG)
- [AI Hub 감성 대화 말뭉치 데이터 셋](https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=realm&dataSetSn=86)
- 추가 데이터 생성 및 학습

### 🛠 Requirements

```
!pip install gluonnlp pandas tqdm
!pip install mxnet
!pip install sentencepiece
!pip install transformers
!pip install torch
!pip install 'git+https://github.com/SKTBrain/KoBERT.git#egg=kobert_tokenizer&subdirectory=kobert_hf'

```

### ⚾️ Import

```
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

### 🎾 Hyper Parameter

```
# Setting parameters
max_len = 64
batch_size = 64
warmup_ratio = 0.1
num_epochs = 50
max_grad_norm = 1
log_interval = 200
learning_rate =  5e-5
```

***하이퍼 파라미터 셋팅***

- **max_len** 문장 최대 길이
- **batch_size** 한 번의 batch마다 주는 데이터 샘플의 size. 
- **num_epochs :** 전체 학습 데이터 학습 횟수
- **learning_rate :** 학습률

### 🧚‍♀️ BERT Dataset

```
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

```
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

```
tokenizer = KoBERTTokenizer.from_pretrained('skt/kobert-base-v1')
bertmodel = BertModel.from_pretrained('skt/kobert-base-v1', return_dict=False)
vocab = nlp.vocab.BERTVocab.from_sentencepiece(tokenizer.vocab_file, padding_token='[PAD]')
tok = tokenizer.tokenize
```

- skt/kobert-base-v1 모델의 **사전 학습된 가중치** 로드
- BERTVocab 객체에 tokenizer.vocab_file 사전(vocab) 로드

### 💿 데이터 로드/ 전처리

```
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

```
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

### **학습 설정값**

- BERTClassifier 클래스를 사용하여 모델 객체를 생성합니다.
- 모델은 BERT 모델과 클래스 분류를 위한 선형 레이어로 구성
- AdamW 옵티마이저를 사용하여 학습을 진행합니다.
- 가중치 감쇠(weight decay)를 적용하여 과적합을 방지합니다.
- 가중치 감쇠를 적용하지 않는 파라미터와 적용하는 파라미터를 구분하여 옵티마이저를 설정
- CrossEntropyLoss 함수를 사용하여 손실값을 계산합니다.

### **학습 동작과정 (for ~)**

- 모델을 학습 모드로 변경합니다.
- token_ids, segment_ids, valid_length, label 값을 GPU 올리고, model에 input -> out
- out 값과 label 값을 사용하여 Cross Entropy Loss를 계산합니다.
- loss.backward() 함수를 호출해 모델의 각 파라미터에 대한 그래디언트를 계산
- optimizer.step() 함수를 호출하여 그래디언트 값을 사용하여 파라미터를 업데이트
- CosineAnnealingWarmRestarts 스케줄러 사용, 학습률을 조정
- 현재 배치의 학습 정확도 train_acc에 누적
- 현재 epoch의 학습 정확도를 출력

### **🧬 감정**
**😀일상 - 0 😊기쁨 -1 😧불안 - 2 😭슬픔 - 3 😡분노 - 4 😥우울 - 5**

<img src = "https://user-images.githubusercontent.com/109534450/229018209-f9fb7af0-0800-47f8-981b-3ea3e13d2e9d.png" width="55%" height="55%">


### 📤 Predict

```
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

### 📩 **OUT**
<img src = "https://user-images.githubusercontent.com/109534450/229065068-57d1e4f1-b9f1-461c-a0d2-d8a1d966d20f.png" width="55%" height="55%">

### ✨ 결과물
**Loss**
- CrossEntropyLoss() - 교차 엔트로피 오차
- <img src = "https://user-images.githubusercontent.com/109534450/229016538-98df19eb-1bd3-4f78-8aff-abf498ca8759.png" width="35%" height="35%">
- 두 확률 분포의 차이를 구하기 위해서 사용됩니다.
- 실제 데이터의 확률 분포와, 학습된 모델이 계산한 확률 분포의 차이를 구하는데 사용된다.

<img src = "https://user-images.githubusercontent.com/109534450/229390889-8b9a2114-675f-4529-aacf-29a2fbd19055.png" width="55%" height="55%">



**Accuracy**


<img src = "https://user-images.githubusercontent.com/109534450/229020020-d61be612-8721-4348-9961-390a18955766.png" width="55%" height="55%">


**Confusion Matrix**


<img src = "https://user-images.githubusercontent.com/109534450/229709741-e4cbb9bd-9d79-4d3c-8180-ae4e9e5bed35.png" width="55%" height="55%">


---

---
## 💡 **감성 챗봇 👉 KoGPT2**
### ✏️ **Process**

1. 데이터 전처리

- 대화 문장을 토큰화하여 토큰 ID로 변환합니다.
질문과 대답 간 구분을 나타내는 토큰을 추가합니다.
문장 쌍의 경우, 문장 간 구분을 나타내는 토큰을 추가합니다.
문장의 길이가 최대 길이를 초과하는 경우, 최대 길이에 맞게 잘라냅니다.
2. koGPT 모델 적용

- 전처리된 입력 데이터를 KoGPT2 모델에 입력하여 출력값을 얻습니다.
KoGPT2 모델은 입력 토큰을 임베딩하고, 어텐션 메커니즘을 사용하여 각 토큰의 의미를 파악합니다.
출력값은 KoGPT2 모델의 출력 차원 크기와 동일한 크기의 로짓으로 나옵니다.
3. 손실 함수 및 최적화

- logit과 실제 레이블 간의 차이를 측정하는 교차 엔트로피 손실 함수를 사용하여 학습합니다.
학습에는 Adam 옵티마이저를 사용합니다.
학습률과 학습 스케줄링 등을 조정하여 학습을 진행합니다.
4. Predict

- KoGPT2 모델을 활용하여 입력된 질문에 대한 대답을 생성합니다.
인코딩된 input_ids를 모델에 입력으로 넣어 예측 결과를 생성합니다.
예측 결과에서 가장 확률이 높은 토큰을 선택하여 대답을 생성합니다.

### 🧾 **Dataset**
![bert_챗봇](https://user-images.githubusercontent.com/109534450/229683525-159091de-309a-417f-8749-5754cffc37a1.PNG)
- [감성 대화 말뭉치 데이터 셋 (AI Hub)](https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=realm&dataSetSn=86)
- 추가 데이터 생성 및 학습

### 🛠 **Requirements**
```
! pip install transformers
! pip install pytorch-lightning
! pip install torch
```

### ⚾️ **Import**

```
import numpy as np
import pandas as pd
import torch
from pytorch_lightning import Trainer
from pytorch_lightning.callbacks import ModelCheckpoint
from pytorch_lightning import LightningModule
from torch.utils.data import DataLoader, Dataset
from transformers.optimization import AdamW, get_cosine_schedule_with_warmup
from transformers import PreTrainedTokenizerFast, GPT2LMHeadModel
import re

```
### **🥌 토큰**
```python
Q_TKN = "<usr>"
A_TKN = "<sys>"
BOS = '</s>'
EOS = '</s>'
MASK = '<unused0>'
SENT = '<unused1>'
PAD = '<pad>
```
- Q_TKN = "<usr>" : 질문 유저 토큰
- A_TKN = "<sys>" : 대답 시스템 토큰
- BOS = '</s>' : 문장의 시작
- EOS = '</s>' : 문장의 끝을
- MASK = '<unused0>' : 마스크 처리
- SENT = '<unused1>' : 문장 처리
- PAD = '<pad>' : 패딩 

### 🎾 **Hyper Parameter**

```
# Setting parameters
learning_rate = 3e-5
criterion = torch.nn.CrossEntropyLoss(reduction="mean")
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
epoch = 70
Sneg = -1e18
```

***하이퍼 파라미터 셋팅***
- criterion :  CrossEntropyLoss 
- optimizer : Adam 

### 🧚‍♀️ **KoGPT2 Chatbot Dataset**

```python 
class ChatbotDataset(Dataset):
    def __init__(self, chats, max_len=100):  # 데이터셋의 전처리를 해주는 부분
        self._data = chats
        self.max_len = max_len
        self.q_token = Q_TKN
        self.a_token = A_TKN
        self.sent_token = SENT
        self.eos = EOS
        self.mask = MASK
        self.tokenizer = koGPT2_TOKENIZER

    def __len__(self):  # chatbotdata 의 길이를 리턴한다.
        return len(self._data)

    def __getitem__(self, idx):  # 로드한 챗봇 데이터를 차례차례 DataLoader로 넘겨주는 메서드
        turn = self._data.iloc[idx]
        q = turn["사람문장1"]  # 질문을 가져온다.
        q = re.sub(r"([?.!,])", r" ", q)  # 구둣점들을 제거한다.

        a = turn["시스템문장1"]  # 답변을 가져온다.
        a = re.sub(r"([?.!,])", r" ", a)  # 구둣점들을 제거한다.

        q_toked = self.tokenizer.tokenize(self.q_token + q + self.sent_token)
        q_len = len(q_toked)

        a_toked = self.tokenizer.tokenize(self.a_token + a + self.eos)
        a_len = len(a_toked)

        #질문의 길이가 최대길이보다 크면
        if q_len > self.max_len:
            a_len = self.max_len - q_len        #답변의 길이를 최대길이 - 질문길이
            if a_len <= 0:       #질문의 길이가 너무 길어 질문만으로 최대 길이를 초과 한다면
                q_toked = q_toked[-(int(self.max_len / 2)) :]   #질문길이를 최대길이의 반으로 
                q_len = len(q_toked)
                a_len = self.max_len - q_len              #답변의 길이를 최대길이 - 질문길이
            a_toked = a_toked[:a_len]
            a_len = len(a_toked)

        #질문의 길이 + 답변의 길이가 최대길이보다 크면
        if q_len + a_len > self.max_len:
            a_len = self.max_len - q_len        #답변의 길이를 최대길이 - 질문길이
            if a_len <= 0:       #질문의 길이가 너무 길어 질문만으로 최대 길이를 초과 한다면
                q_toked = q_toked[-(int(self.max_len / 2)) :]   #질문길이를 최대길이의 반으로 
                q_len = len(q_toked)
                a_len = self.max_len - q_len              #답변의 길이를 최대길이 - 질문길이
            a_toked = a_toked[:a_len]
            a_len = len(a_toked)

        # 답변 labels = [mask, mask, ...., mask, ..., <bos>,..답변.. <eos>, <pad>....]
        labels = [self.mask,] * q_len + a_toked[1:]

        # mask = 질문길이 0 + 답변길이 1 + 나머지 0
        mask = [0] * q_len + [1] * a_len + [0] * (self.max_len - q_len - a_len)
        # 답변 labels을 index 로 만든다.
        labels_ids = self.tokenizer.convert_tokens_to_ids(labels)
        # 최대길이만큼 PADDING
        while len(labels_ids) < self.max_len:
            labels_ids += [self.tokenizer.pad_token_id]

        # 질문 + 답변을 index 로 만든다.    
        token_ids = self.tokenizer.convert_tokens_to_ids(q_toked + a_toked)
        # 최대길이만큼 PADDING
        while len(token_ids) < self.max_len:
            token_ids += [self.tokenizer.pad_token_id]

        #질문+답변, 마스크, 답변
        return (token_ids, np.array(mask), labels_ids)

def collate_batch(batch):
    data = [item[0] for item in batch]
    mask = [item[1] for item in batch]
    label = [item[2] for item in batch]
    return torch.LongTensor(data), torch.LongTensor(mask), torch.LongTensor(label)
```


### 🔫 **토크 나이저 / 모델 정의**

```python
koGPT2_TOKENIZER = PreTrainedTokenizerFast.from_pretrained("skt/kogpt2-base-v2",
            bos_token=BOS, eos_token=EOS, unk_token='<unk>',
            pad_token=PAD, mask_token=MASK) 
model = GPT2LMHeadModel.from_pretrained('skt/kogpt2-base-v2')
```

- skt/kogpt2-base-v2 모델에 대한 토크나이저 로드
- GPT2LMHeadModel은 GPT-2 모델 로드, 'skt/kogpt2-base-v2' 모델

### 💿 **데이터 로드/ 전처리**

```python
import urllib.request

Chatbot_Data = pd.read_csv("./data/감성대화말뭉치(최종데이터)_Training.csv", encoding="cp949")
Chatbot_Data = Chatbot_Data[:51629]
Chatbot_Data.head()
train_set = ChatbotDataset(Chatbot_Data, max_len=100)
train_dataloader = DataLoader(train_set, batch_size=32, num_workers=0, shuffle=True, collate_fn=collate_batch,)
```

### 🧸 **모델 학습**

```python
import matplotlib.pyplot as plt

losses = []
X = []
Y = []
print("start")
for epoch in range(epoch):
    print(epoch)
    X.append(epoch)
    for batch_idx, samples in enumerate(train_dataloader):
        optimizer.zero_grad()
        token_ids, mask, label = samples
        token_ids = token_ids.to(device)
        mask = mask.to(device)
        label = label.to(device)
        out = model(token_ids)        
        out = out.logits.to(device)
        
        mask_3d = mask.unsqueeze(dim=2).repeat_interleave(repeats=out.shape[2], dim=2).to(device)
        mask_out = torch.where(mask_3d == 1, out, Sneg * torch.ones_like(out)).to(device)
        loss = criterion(mask_out.transpose(2, 1), label).to(device)
        
        avg_loss = loss.sum() / mask.sum()
        avg_loss.backward()
        optimizer.step()
    Y.append(loss.data.cpu().numpy())
print("end")

```
- train_dataloader에서 token_ids, mask, label 값을 할당

- optimizer를 초기화하고, 모델의 출력 값 out을 계산, logits 메서드를 이용하여 로짓 값을 계산

- mask 값을 3차원으로 확장, out과 동일한 크기로 반복하여 mask_3d를 생성.
- torch.where 메서드를 이용하여 mask가 1인 위치는 out 값을, 0인 위치는 Negative infinity 값을 가지는 텐서를 생성하여 mask_out 변수에 할당

- 손실 함수(criterion)를 계산하고, loss 값을 이용하여 현재 손실 값을 구합니다. 이때, 손실 값의 평균을 구하기 위해 avg_loss 변수를 계산

- backward 메서드를 이용하여 그라디언트를 계산하고, step 메서드를 이용하여 파라미터를 업데이트

### 📤 **Predict**

```python
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
```

-  koGPT2 모델을 활용하여 입력된 질문에 대한 대답을 생성하는 함수
- 인코딩된 input_ids를 모델에 입력으로 넣어 pred 변수에 예측 결과를 저장
- torch.argmax 함수를 이용하여 가장 확률이 높은 토큰을 선택하고, 이를 gen 변수에 저장, 이때 convert_ids_to_tokens 함수를 이용하여 선택된 토큰을 문자열로 변환

- gen 변수가 EOS인 경우, 생성 과정을 마침. 그렇지 않은 경우 gen에 대한 값을 a에 추가

### 📩 **OUT**

```
input_text = "오늘 갑자기 날씨가 추워져서 놀랐어"
kogpt(sentence) # "날씨가 많이 추워졌군요"
```



## 💡 **감성 챗봇 👉 KoBERT**



### 🧾 **데이터 셋**
![bert_챗봇대화](https://user-images.githubusercontent.com/109534450/229684303-4779a711-26b8-41ac-bcb2-cc60e2470555.PNG)
- AI Hub 제공, 웰니스 대화 스크립트 데이터셋 (_현재 페이지 없음_)

### 📩 **OUT**
```
input_text = "요새 좀 우울하고 힘들더라고"
kobert(answer) # "이해해요. 아무 이유 없이 우울할 때가 있죠."
```



### ✨ 결과물
**Loss**
- CrossEntropyLoss() - 교차 엔트로피 오차
- <img src = "https://user-images.githubusercontent.com/109534450/229016538-98df19eb-1bd3-4f78-8aff-abf498ca8759.png" width="35%" height="35%">
- 두 확률 분포의 차이를 구하기 위해서 사용됩니다.
- 실제 데이터의 확률 분포와, 학습된 모델이 계산한 확률 분포의 차이를 구하는데 사용된다.

<img src = "https://user-images.githubusercontent.com/109534450/229391092-b4e0e45c-8d9d-4ff4-b7b3-c1716b6b945f.png" width="55%" height="55%">


### **🔧 개발 환경**
- Google Colab
- Jupyter Hub
