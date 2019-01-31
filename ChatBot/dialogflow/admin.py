from django.contrib import admin
from .models import User, Festival


admin.site.register(User)
admin.site.register(Festival)
'''
from .models import Pizza


@admin.register(Pizza)
class PizzaAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)
'''

