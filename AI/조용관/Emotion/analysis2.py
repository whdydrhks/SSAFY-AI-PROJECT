pip install -q transformers
pip install translate
#################################################

data = [ 
    "벽에 머리를 부딪히는 느낌이야",
    "허리가 아파서 움직임이 어렵네ㅠㅠ",
    "집중력도 떨어지고 기분이 좋지 않아",
    "나는 화가 통제가 안돼!",
    "히잉?",
    "나 자해 할거야 ",
    "팔다리가 너무 저려",
    "방에만 있고 싶어",
    "스트레스 너무 많이 받아서 잠이 안와",
    "난바부야 기억을 하나두 못하겠어",
    "다이어트 하고싶은데 맘처럼 안되네",
    "요즘은 이상한 생각이 많이 들어",
    "부정적인 생각이 많이 드네",
    "사고 휴유증이 있는걸까",
    "체력이 떨어져서 문제야",
    "으악! 꽥!",
    "요즘 비둘기 무서워",
    "감정이 왔다갔다해요.",
    "화가 많이 날때는 감정 조절이 안되어여",
    "요즘 잠이 안와요",
    "입맛도 통 없구",
    "기분이 우울해서 큰일이야",
    "나는 아무것도 잘한게 없는걸?",
    "모든걸 내 마음대로 하고 싶을 때 있잖아",
    "무엇이 불안한지 잘 모르겠어"
    
]
############################################################

from translate import Translator

data2 = []
for d in data:
    translator = Translator(from_lang="ko", to_lang="en")
    translation = translator.translate(d)
    data2.append(translation)

data2
############################################################

from transformers import pipeline
sentiment_pipeline = pipeline("sentiment-analysis")
#data = ["I feel lonely today", "I'm happy today", "When I have concerns, I look up at the sky", "Today feels like an incredibly long day", "I want to scream out loud today"]

for d in data2:
    print(d)
    print(sentiment_pipeline(d))
    print()
#sentiment_pipeline(data2)
##############################################################

specific_model = pipeline(model="finiteautomata/bertweet-base-sentiment-analysis")
specific_model(data2)

for d in data2:
    print(d)
    print(specific_model(d))
    print()
