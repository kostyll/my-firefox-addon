import html
from html import *

_ = lambda x:x

def gen_popup_window():
    with HTML5 as out:
        with HEAD:
            CSS(href='thirdparty/bootstrap.min.css')
            CSS(href='thirdparty/bs2-tagsinput/dist/bootstrap-tagsinput.css')
            # JS(src='jquery-git2.js')
            # JS(src='bootstrap.min.js')
    with BODY:
        with DIV.container_fluid:
            with DIV.row_fluid:
                with DIV.row_fluid:
                    LABEL(_("URL"),for_="selected_text_url")
                    INPUT(type="text",id_="selected_text_url",class_="form-control")
                with DIV.row_fluid:
                    LABEL(_("Title"),for_="selected_text_title")
                    INPUT(type="text",id_="selected_text_title",class_="form-control")
                with DIV.span12:
                    LABEL(_("Selected text"),for_="selected_text")
                    with TEXTAREA(id_="selected_text",class_="form-control",rows=3).input_large:
                        pass
            with DIV.row_fluid:
                LABEL(_("All tags:"))
                with DIV(id_="all_tags"):
                    pass
            with DIV.row_fluid:
                LABEL(_("Selected tags:"),for_="selected_tags",class_="form-control")
                INPUT(id_="selected_tags",type="text",class_="form-control", data_role="tagsinput")
            with DIV.row_fluid:
                LABEL(_("All jobs:"))
                with DIV(id_="all_jobs"):
                    pass
            with DIV.row_fluid:
                LABEL(_("Selected jobs:"),for_="selected_jobs",class_="form-control")
                INPUT(id_="selected_jobs",type="text",class_="form-control",data_role="tagsinput")
            with DIV.row_fluid:
                LABEL(_("Test area"))
                with DIV(id_="test_div"):
                    pass
            A(_("Ok"),id_="submit_text_selection",class_="btn btn-primary")
        JS(src='popup_selection.js')
    return out

print gen_popup_window()
