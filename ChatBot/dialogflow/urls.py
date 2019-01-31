from django.urls import path
from . import views

app_name = 'dialogflow'

urlpatterns = [
    path('', views.index, name='index'),
    path('fulfillment/', views.fulfillment, name='fulfillment'),
    path('timer/', views.timer, name = 'timer'),
    path('apitest/', views.apitest, name = 'apitest'),
    path('database/', views.database, name = 'database'),
    path('getfes/', views.GetFestival, name ='getfes'),
]