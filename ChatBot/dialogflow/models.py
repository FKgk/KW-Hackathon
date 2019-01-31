from __future__ import unicode_literals

from django.db import models
from jsonfield import JSONField
from .fields import CommaSeparatedCharField

class User(models.Model):
    #start = models.CharField(max_length = 20, blank = True, null = True)
    chat_id = models.IntegerField(primary_key = True, unique = True)
    name = models.CharField(max_length = 20)
    gender = models.CharField(max_length = 20)
    locate = models.CharField(max_length = 20)
    #num = models.IntegerField(blank = False, unique = True)
    
    def __str__(self):
        return str(self.chat_id)
    
class Festival(models.Model):
    name = models.CharField(max_length = 20, unique = True)
    locate = models.CharField(max_length = 20)
    date = models.CharField(max_length = 20)
    img = models.CharField(max_length = 110)
    
    def __str__(self):
        return self.name
    
    

    