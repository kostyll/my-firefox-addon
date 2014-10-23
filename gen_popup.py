import html
from html import *

def gen_popup_window():
    with HTML5 as out:
        with HEAD:
            CSS(href='bootstrap.min.css')
            JS(src='jquery-git2.js')
            JS(src='bootstrap.min.js')
    with BODY:
        with DIV.container_fluid:
            with TEXTAREA:
                out <<"LALALA"
            INPUT()
            A("bababa")
    return out

print gen_popup_window()
