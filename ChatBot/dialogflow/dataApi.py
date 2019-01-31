import urllib.request
from bs4 import BeautifulSoup
from datetime import datetime
from dialogflow.models import Festival
import random
url1 = "http://korean.visitkorea.or.kr/kor/bz15/where/festival/festival.jsp"
url2 = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureSidoLIst?serviceKey=&numOfRows=25&pageSize=25&pageNo=1&startPage=1&sidoName=%EC%84%9C%EC%9A%B8&searchCondition=DAILY"
url3 = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey="
city_location = {
   "종로구" : [60,127],
    "중구" : [60, 127],
    "용산구" : [60, 126],
    "성동구" : [61,127],
    "광진구" : [62,126],
    "동대문구" : [61,127],
    "중랑구" : [62,128],
    "성북구" : [61,127],
    "강북구" : [61,128],
    "도봉구" : [61,129],
    "노원구" : [61,129],
    "은평구" : [59,127],
    "서대문구" : [59,127],
    "마포구" : [59,127],
    "양천구" : [58,126],
    "강서구" : [58,126],
    "구로구" : [58,125],
    "금천구" : [59,124],
    "영등포구" : [58,126],
    "동작구" : [59,125],
    "관악구" : [59,125],
    "서초구" : [61,125],
    "강남구" : [61,126],
    "송파구" : [62,126],
    "강동구" : [62,126]
}
city_name={
    "nowon" :"노원구",
    "dobong" :"도봉구",
    "gangbuk":"강북구",
    "sungbuk":"성북구",
    "jungrang":"중랑구",
    "dongdaemun":"동대문구",
    "jongno":"종로구",
    "eunpyeong":"은평구",
    "seodaemun":"서대문구",
    "jungu":"중구구",
    "seongdong":"성동구",
    "gwangjin":"광진구",
    "gangdong":"강동구",
    "mapo":"마포구",
    "yongsan":"용산구",
    "gangseo":"강서구",
    "yangcheon":"양천구",
    "yeongdungpo":"영등포구",
    "guro":"구로구",
    "dongjak":"동작구",
    "geumcheon":"금천구",
    "gwanak":"관악구",
    "seocho":"서초구",
    "gangnam":"강남구"
}
def getFestival():
    # db에서 행사 정보 가져와서 리턴
    # 리턴 예시 올림픽/서울 올림픽대로/20181027
    fes_name = Festival.objects.values_list('name', flat = True)
    fes_locate = Festival.objects.values_list('locate', flat = True) # 행사 지역 가져오기
    fes_date = Festival.objects.values_list('date', flat = True) # 날짜 가져오기
    fes_img = Festival.objects.values_list('img', flat = True) # 이미지 주소 가져오기
    num = random.randint(0, 2) # 난수 생성
    for i in range(3):
        fes_name = "f" * (num)
        fes_locate = "l" * (num)
        fes_date = fes_date[num]
        fes_img = fes_img[num]
        break
    answer = fes_name + "/" + fes_locate + "/" + fes_date + "!" + fes_img # 지역/날짜/주소
    print(answer)
    return answer # 반환
    
def saveFestival():
    response = urllib.request.urlopen(url1)
    soup = BeautifulSoup(response, "html.parser")
    results = soup.select("div.news_list")
    results[0].select("span.city")
    for i in results:
        titles = i.select("h3")
        locations = i.select("span.city")
        dates = i.select("span.date")
        imgs = i.select("img")
    
    for t, l , d, img in zip(titles, locations, dates, imgs):
        img = str(img)
        print(t.text[:-1], l.text ,d.text[7:], img[img.find("src") + 5: img.find("\">/") - 2], sep="\t")
        #img[img.find("src") + 5: img.find("\">/") - 2]
        Festival(name = t.text[:-1], locate = l.text, date = d.text[7:], img = img[img.find("src") + 5: img.find("\">/") - 2] ).save()
    
    return 

        
def getWeather(locations):
    try : locations = city_name[locations]
    except : pass
    response = urllib.request.urlopen(url2)
    soup = BeautifulSoup(response, "html.parser")
    num = soup.find_all("cityname")
    pm10 = soup.find_all("pm10value")
    for i in range(len(num)):
        if num[i].text == locations:
            num = i
            break
    answer = str(pm10[num].text)
    #print(pm10[num].text)
    #print("-1")
    date = datetime.today()
    #print("-2")
    base_date = str(date.year) + str(date.month) + str(date.day)
    #print("-3")
    #if date.minute >= 40:
    #    base_time = str( (date.hour + 9) % 24) + "00"
    #else :
    #    base_time = str( (date.hour + 8) % 24) + "00"
    temp_hour = int(date.hour // 3) * 3 - 2
    if temp_hour < 0:
        temp_hour += 24
    base_time = str(temp_hour) + "00"
    
    if len(base_time) <= 3:
        base_time = "0" + base_time
    print(base_time)
    nx, ny = city_location[locations]
    #print(nx, ny)
    #url4 = url3
    #url4 += "base_date=" + base_date
    #url4 += "&base_time=" + str(base_time)
    #url4 += "&nx=" + str(nx)
    #url4 += "&ny=" + str(ny)
    #url4 += "&numOfRows=8&pageSize=8&pageNo=1&startPage=1&_type=xml"
    response = urllib.request.urlopen(url3 + "&base_date=" + base_date + "&base_time=" + str(base_time) + "&nx=" + str(nx) + "&ny=" + str(ny) + "&numOfRows=8&pageSize=8&pageNo=1&startPage=1&_type=xml")
    #print(url3 + "&base_date=" + base_date + "&base_time=" + str(base_time) + "&nx=" + str(nx) + "&ny=" + str(ny) + "&numOfRows=8&pageSize=8&pageNo=1&startPage=1&_type=xml")
    #print(response)
    soup = BeautifulSoup(response, "html.parser")
    category = soup.find_all("category")
    value = soup.find_all("fcstvalue")
    #print(category)
    POP = T3H = "0"
    #print(POP, T3H)
    for i in range(len(category)):
        #print(category[i].text)
        if category[i].text == "POP":
            POP = value[i].text
        elif category[i].text == "T3H":
            T3H = value[i].text
            break
    answer += "/" + POP + "/" + T3H
    print(answer)
    #print(POP, T3H)
    return answer
