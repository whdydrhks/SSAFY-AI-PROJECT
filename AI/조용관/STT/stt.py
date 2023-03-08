# 사전 환경 설정 및 확인 요소
pip install SpeechRecognition
pip install pyaudio
pwd

# 코드
import speech_recognition as sr

#  ----- 1. 마이크로 인식 -----
r = sr.Recognizer()
with sr.Microphone() as source:
    print('듣고 있습니다.')
    audio = r.listen(source)


try:
    #  구글 API로 인식 (하루 50회)
    # 영어
    #text = r.recognize_google(audio, language='en-US')
    # 한국어
    #text = r.recognize_google(audio, language='ko')
    #print(text)
    
except sr.UnknownValueError:
    print('인식 실패') # 음성 인식 실패한 경우
except sr.RequestError:
    print('요청 실패 : {0}'.format(e)) # API Key 오튜, 네트워크 단절 등    


#  ----- 2. 음성파일로 인식 -----
# 파일로부터 음성 불러오기 (wav, aiff, flac 가능 / mp3는 불가)
r = sr.Recognizer()
with sr.AudioFile('sample2.wav') as source :
    audio = r.record(source)

try:
    text = r.recognize_google(audio, language='ko')
    print(text)
except sr.UnknownValueError:
    print('인식 실패') # 음성 인식 실패한 경우
except sr.RequestError:
    print('요청 실패 : {0}'.format(e)) # API Key 오튜, 네트워크 단절 등   