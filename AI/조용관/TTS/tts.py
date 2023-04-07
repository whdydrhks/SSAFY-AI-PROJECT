pip install gTTS
pip install playsound==1.2.2
###############################################
from gtts import gTTS
from playsound import playsound
import os

text = '안녕하세요. 반갑습니다. 여러분의 상담사 김미영 팀장입니다.'
lang = 'ko'
filename='TextToSpeech.mp3'

tts = gTTS(text=text, lang=lang)
tts.save(filename)
playsound(filename)
os.remove(filename)
###################################
# 버전 확인
pip show playsound
ls
