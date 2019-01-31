from pprint import pprint
from django.conf import settings
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from . import actions
# from .models import Pizza
import json
import telegram
from dialogflow.dataApi import getWeather, getFestival, saveFestival
from datetime import datetime
import time
from dialogflow.models import User, Festival

my_token = ''
bot = telegram.Bot(token = my_token)


def index(request):
    return render(request, 'dialogflow/index.html', {
        'WEB_DEMO_URL': settings.DIALOGFLOW['WEB_DEMO_URL'],
    })

@csrf_exempt
@require_POST
def fulfillment(request):
    # request.JSON: intent에서 먼저 처리한 내역
    action_name = request.JSON['result']['action'].replace('-', '_')
    params = request.JSON['result']['parameters']
    cnt = 0
    print("fulfillment")
    print(type(request))
    print(request.read().decode('utf8'))
    try:
        telegram_chat_id = request.JSON['result']['contexts'][0]['parameters']['telegram_chat_id']
        print(request.JSON['result']['contexts'][0])
    except:
        try:
            telegram_chat_id = request.JSON['result']['contexts'][1]['parameters']['telegram_chat_id']
            print(request.JSON['result']['contexts'][1])
            #print('telegram_chat_id 잘 가져왔습니다.')
        except:
            try:
                telegram_chat_id = request.JSON['result']['contexts'][2]['parameters']['telegram_chat_id']
                print(request.JSON['result']['contexts'][2])
            except:
                #print('telegram_chat_id [2] key 에러')
                return request.JSON['result']['contexts']
            
    
    if action_name == "start":
        # getFestival()
        name = params['name']
        gender = params['gender']
        locate = params['locate']
        
        print(telegram_chat_id)
        print(name)
        print(gender)
        print(locate)
        
        actions.start_store_database(telegram_chat_id, name, gender, locate)
        return None
        

    '''
    if action_name == "alarm_search":
        terminate = params['terminate']
        actions.alarm_search(telegram_chat_id, terminate)
        return str(0)
    elif action_name == "cancel":    #취소 입력시
        actions.bus_cancel(telegram_chat_id)
        return str(0)
        
    try:
        if params['start']:    # 값이 없는 것에 대한 처리 미흡(key error)
            start = params['start']
            terminate = params['terminate']
            number = params['number']
            cnt = 1
    except:
        pass
    

    action = getattr(actions, action_name, None)
    '''
    '''
    return {
        'speech': params['start']
    }
    '''
    if cnt == 1:
        speech = action(start, terminate, number, telegram_chat_id)    
    elif callable(action):
        speech = action(**params)
    else:
        speech = '제가 처리할 수 없는 부분입니다.'
    
    return {
        'speech': speech,
    }

def timer(request):
    # 최초 서버 동작하면 실행되어 9시일 때 잠맘보 호출
    print("timer set!!!")
    current_hour = 8
    current_minutes = 2
    date = datetime.today()
    while not ( current_hour == date.hour and current_minutes == date.minute):
        print(current_hour, date.hour , current_minutes , date.minute)
        time.sleep(30)
        date = datetime.today()
    zammambo()
    
        
    
    return None

def zammambo():
    while(True):
        send_message()
        time.sleep(360*24)

def send_message():
    actions.message()
    return None



def apitest(request):
    #<WSGIRequest: GET '/dialogflow/apitest/?cityaa'>
    request = str(request)
    request = request[request.find("?")+1:-2]
    
    #print(request)
    #print("API request Sucess!")
    return getWeather(request)
    #return "string"
    
def GetFestival(request): # 행사 정보 가져오는 함수
    return getFestival()

def database(request):
    #fes_name = Festival.objects.values_list('name', flat = True)
    #fes_locate = Festival.objects.values_list('locate', flat = True)
    #fes_date = Festival.objects.values_list('date', flat = True)
    
    #for i in range(len(fes_date)):
    #    print(fes_date[i])
    saveFestival()
    return None
    