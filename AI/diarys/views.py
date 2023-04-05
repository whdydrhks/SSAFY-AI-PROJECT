
from rest_framework.decorators import api_view
from django.http import JsonResponse
from service.static.kogpt.kogpt import kogpt
from service.static.kobert.kobert import kobert
from service.static.emotion.emotion import emotion_bert
import json

@api_view(['POST',])
def answer(request):
    body_unicode = request.body.decode('utf-8')
    body = json.loads(body_unicode)
    input_text = body.get('text')
    if len(input_text) < 7:
        context ={
        'emotion': 0,
        'return_text': "듣고 있답니다.(끄덕 끄덕) 더 말씀 주세요.^3^/"
        }
        return JsonResponse(context)
    emotion = int(emotion_bert(input_text))
    print(kogpt(input_text))
    try:
        if emotion == 0 or emotion == 1:
            return_text_kogpt = kogpt(input_text)
            return_text = return_text_kogpt + "!"
        else:
            return_text_kogbert = kobert(input_text)
            return_text = return_text_kogbert + ".."
    except:
        return_text = "그러셨군요(끄덕끄덕)."
    context ={
        'emotion': emotion,
        'return_text': return_text
    }
    return JsonResponse(context)