import html
from html import *

_ = lambda x:x

def gen_popup_window():
    with HTML5 as out:
        with HEAD:
            CSS(href='bootstrap.min.css')
            # JS(src='jquery-git2.js')
            # JS(src='bootstrap.min.js')
    with BODY:
        with DIV.container_fluid:
            with DIV.row_fluid:
                with DIV.row_fluid:
                    LABEL(_("URL"),for_="selected_text_url")
                    INPUT(type="text",id_="selected_text_url",class_="form-control")
                with DIV.row_fluid:
                    LABEL(_("URL"),for_="selected_text_title")
                    INPUT(type="text",id_="selected_text_title",class_="form-control")
                with DIV.span12:
                    LABEL(_("Selected text"),for_="selected_text")
                    with TEXTAREA(id_="selected_text",class_="form-control",rows=5).input_large:
                        pass
            with DIV.row_fluid:
                with DIV(id_="tags"):
                    with DIV.span7:
                        pass
                    with DIV.span3:
                        LABEL(_("New tag:"),for_="new_tag",class_="form-control")
                        INPUT(id_="new_tag",type="text",class_="form-control")
            with DIV.row_fluid:
                with DIV(id_="jobs"):
                    with DIV.span7:
                        pass
                    with DIV.span3:
                        LABEL(_("New job:"),for_="new_job",class_="form-control")
                        INPUT(id_="new_job",type="text",class_="form-control")
            A(_("Ok"),id_="submit_text_selection",class_="btn btn-primary")
        JS(src='popup_selection.js')
    return out

print gen_popup_window()
