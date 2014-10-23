import html
from html import *

def gen_popup_window():
    with HTML5 as out:
        with HEAD:
            CSS(href='http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css')
            JS(src='http://code.jquery.com/jquery-git2.js')
            JS(src='http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/js/bootstrap.min.js')
    with BODY:
        with DIV.container_fluid:
            with TEXTAREA:
                out <<"LALALA"
            INPUT()
            A("bababa")
    return out

print gen_popup_window()
