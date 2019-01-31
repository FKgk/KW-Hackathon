import random
import telegram
from django.template.loader import render_to_string
from dialogflow.models import User, Festival
from dialogflow.dataApi import getWeather, getFestival
#from .bus import get_bus, status_change, set_start_number


#def bus_search(start, terminate, number, chat_id):
#    return get_bus(start, terminate, number, chat_id)

#def bus_cancel(telegram_chat_id):
#    return status_change(telegram_chat_id)

#def alarm_search(telegram_chat_id, terminate):
#    return set_start_number(telegram_chat_id, terminate)

my_token = ''
bot = telegram.Bot(token = my_token)

def start_store_database(telegram_chat_id, name, gender, locate):
    User(chat_id = telegram_chat_id, name = name, gender = gender, locate = locate).save()
    print(name + " 사용자의 값을 데이터베이스에 저장했습니다!")
    bot.sendMessage(chat_id = telegram_chat_id, text ="사용자 정보가 입력되었습니다. 매일 9시에 어머니의 마음으로 알림을 보내드립니다.")
    return None

def message():
    # send msg to user
    chat_id = User.objects.values_list('chat_id', flat = True)
    user_name = User.objects.values_list('name', flat = True)
    gender = User.objects.values_list('gender', flat = True)
    user_locate = User.objects.values_list('locate', flat = True)
    
    fes_name = Festival.objects.values_list('name', flat = True)
    fes_locate = Festival.objects.values_list('locate', flat = True)
    fes_date = Festival.objects.values_list('date', flat = True)
    fes_img = Festival.objects.values_list('img', flat = True)
    
    october = ["후쿠오카", "네팔", "스위스", "스페인", "아이슬란드", "그린란드", "핀란드"]
    october_detail = ["최적의 가을날씨니까 돌아다니기 좋을꺼야.", "히말라야 트래킹하기 지금이 가장 좋은 날씨래. 우리 아들 운동 해야지~?", "겨울 스포츠 즐기기 좋은 계절이래. 우리 아들 운동 해야지~?", "지금 세일 기간이래~ 가서 옷 좀 사 입어.", "오로라 볼 수 있는 달 중 하나야. 엄마도 보구싶다~", "오로라 볼 수 있는 달 중 하나야. 엄마도 보구싶다~", "오로라 볼 수 있는 달 중 하나야. 엄마도 보구싶다~"]
    november = ["필리핀", "네팔", "핀란드", "아이슬란드", "그린란드", "터키", "뉴질랜드"]
    
    # 4개 데이터를 변수 저장해 (3개가 있어야 해)
    # message보내는 함수 
    # 인수 char_id, send_message
    
    october_ran = random.randint(0, len(october) - 1)
    num = random.randint(0, len(fes_name)-1)
    
    user_locations = user_locate # db에서 user 지역 가져오기
    print(user_locations)
    for user_location, id in zip(user_locations,chat_id):
        weather = getWeather(user_location)
        #pm 미세먼지, POP 강수 확률, temp 온도
        pm, POP, temp = weather.split("/")
        
        # 날씨 바꾸는거 잊지 말기!!
        if  not (int(pm) > 80 or int(POP) > 50 or int(temp) < 10):
            # 미세먼지 80이상, 강수 확률 50이상, 온도 10미만
            print("날씨가 좋지 않다.")
            send_message([id], "아들~ 오늘은 날씨가 좋지 않으니 집에서 푹 쉬어.")
            print(id)
            #날씨가 안 좋다고 메세지 보내기
            continue
        else:
            send_wea_msg = "일어났니~? 오늘은 " + str(temp) + "도로 날씨가 좋고 미세먼지도 없으니까 집에만 있지 말고 밖에 나가서 놀으렴! 엄마가 뭐 좀 찾아봤어."
            send_message(chat_id, send_wea_msg)
        
        
        
    send_fes_msg = "행사 이름 : " + fes_name[num] + "\n행사 위치 : " + fes_locate[num] + '\n날짜 : ' + fes_date[num]
    send_message_with_photo(chat_id, send_fes_msg, fes_img[num])
        # 헹사가 있다면 행사 추천
        # 행사 가져오기
    send_trip_msg = "여행 정보도 찾아봤어~ \n여행지 : " + october[october_ran] + "\n" + october_detail[october_ran]
    send_message(chat_id, send_trip_msg)
    return None


def send_message(chat_id, send_message):
    for i in chat_id:
        print(i)
        bot.sendMessage(chat_id = i, text = send_message)
    return None

def send_message_with_photo(chat_id, send_message, fes_img):
    for i in chat_id:
        print(i)
        bot.sendMessage(chat_id = i, text = send_message)
        print(fes_img)
        bot.sendPhoto(chat_id = i, photo = fes_img, caption = "축제 정보")
    return None