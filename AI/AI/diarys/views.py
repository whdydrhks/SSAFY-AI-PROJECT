
from django.shortcuts import render
from rest_framework.decorators import api_view
from django.http import JsonResponse
from service.static.kogpt.kogpt import kogpt
from service.static.kobert.kobert import kobert
from service.static.emotion.emotion import emotion_bert
import json


def index(request):
    return render(request, "diarys/index.html")

@api_view(['POST',])
def answer(request):
    print(request)
    body_unicode = request.body.decode('utf-8')
    body = json.loads(body_unicode)
    input_text = body.get('text')
    # emotion
    emotion = int(emotion_bert(input_text))
    print(emotion)
    # kogpt
    if input_text:
        return_text_kogpt = kogpt(input_text)
    else:
        return_text_kogpt = "그러시군요."
    print(return_text_kogpt)
    # kobert
    return_text_kogbert = kobert(input_text)
    #serialize
    context = {
        'emotion': emotion,
        'return_text': return_text_kogbert
    }
    return JsonResponse(context)