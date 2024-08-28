from django.http import JsonResponse
from django.conf import settings

def show_allowed_hosts(request):
    return JsonResponse({'ALLOWED_HOSTS': settings.ALLOWED_HOSTS})
