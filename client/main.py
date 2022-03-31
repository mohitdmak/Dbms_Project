import sys
import tkinter as tk
import tkinter.ttk as ttk
from tkinter.constants import *

import main_support

class Toplevel1:
    def __init__(self, top=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        _bgcolor = '#d9d9d9'  # X11 color: 'gray85'
        _fgcolor = '#000000'  # X11 color: 'black'
        _compcolor = '#d9d9d9' # X11 color: 'gray85'
        _ana1color = '#d9d9d9' # X11 color: 'gray85'
        _ana2color = '#ececec' # Closest X11 color: 'gray92'

        top.geometry("600x476+517+139")
        top.minsize(120, 1)
        top.maxsize(1540, 845)
        top.resizable(1,  1)
        top.title("Toplevel 0")
        top.configure(background="#d9d9d9")

        self.top = top

        self.Entry1 = tk.Entry(self.top)
        self.Entry1.place(relx=0.2, rely=0.132, height=40, relwidth=0.29)
        self.Entry1.configure(background="white")
        self.Entry1.configure(disabledforeground="#a3a3a3")
        self.Entry1.configure(font="TkFixedFont")
        self.Entry1.configure(foreground="#000000")
        self.Entry1.configure(insertbackground="black")

        self.reg_button = tk.Button(self.top, command= self.reg_command)
        self.reg_button.place(relx=0.067, rely=0.466, height=24, width=47)
        self.reg_button.configure(activebackground="#ececec")
        self.reg_button.configure(activeforeground="#000000")
        self.reg_button.configure(background="#d9d9d9")
        self.reg_button.configure(command=main_support.show_register)
        self.reg_button.configure(compound='left')
        self.reg_button.configure(disabledforeground="#a3a3a3")
        self.reg_button.configure(foreground="#000000")
        self.reg_button.configure(highlightbackground="#d9d9d9")
        self.reg_button.configure(highlightcolor="black")
        self.reg_button.configure(pady="0")
        self.reg_button.configure(text='''Register''')

        self.Entry2 = tk.Entry(self.top)
        self.Entry2.place(relx=0.2, rely=0.29, height=40, relwidth=0.29)
        self.Entry2.configure(background="white")
        self.Entry2.configure(disabledforeground="#a3a3a3")
        self.Entry2.configure(font="TkFixedFont")
        self.Entry2.configure(foreground="#000000")
        self.Entry2.configure(insertbackground="black")

        self.Label1 = tk.Label(self.top)
        self.Label1.place(relx=0.05, rely=0.132, height=44, width=74)
        self.Label1.configure(anchor='w')
        self.Label1.configure(background="#d9d9d9")
        self.Label1.configure(compound='left')
        self.Label1.configure(disabledforeground="#a3a3a3")
        self.Label1.configure(foreground="#000000")
        self.Label1.configure(text='''Enter name''')

        self.Label2 = tk.Label(self.top)
        self.Label2.place(relx=0.017, rely=0.311, height=22, width=84)
        self.Label2.configure(anchor='w')
        self.Label2.configure(background="#d9d9d9")
        self.Label2.configure(compound='left')
        self.Label2.configure(disabledforeground="#a3a3a3")
        self.Label2.configure(foreground="#000000")
        self.Label2.configure(text='''Enter username''')

        self.choose_label = tk.Label(self.top)
        self.choose_label.place(relx=0.15, rely=0.777, height=23, width=74)
        self.choose_label.configure(anchor='w')
        self.choose_label.configure(background="#d9d9d9")
        self.choose_label.configure(compound='left')
        self.choose_label.configure(disabledforeground="#a3a3a3")
        self.choose_label.configure(foreground="#000000")
        self.choose_label.configure(text='''Choose one''')

        self.add_button = tk.Button(self.top)
        self.add_button.place(relx=0.433, rely=0.666, height=24, width=77)
        self.add_button.configure(activebackground="#ececec")
        self.add_button.configure(activeforeground="#000000")
        self.add_button.configure(background="#d9d9d9")
        self.add_button.configure(compound='left')
        self.add_button.configure(disabledforeground="#a3a3a3")
        self.add_button.configure(foreground="#000000")
        self.add_button.configure(highlightbackground="#d9d9d9")
        self.add_button.configure(highlightcolor="black")
        self.add_button.configure(pady="0")
        self.add_button.configure(state='disabled')
        self.add_button.configure(text='''Addition''')

        self.sub_button = tk.Button(self.top)
        self.sub_button.place(relx=0.433, rely=0.777, height=24, width=77)
        self.sub_button.configure(activebackground="#ececec")
        self.sub_button.configure(activeforeground="#000000")
        self.sub_button.configure(background="#d9d9d9")
        self.sub_button.configure(compound='left')
        self.sub_button.configure(disabledforeground="#a3a3a3")
        self.sub_button.configure(foreground="#000000")
        self.sub_button.configure(highlightbackground="#d9d9d9")
        self.sub_button.configure(highlightcolor="black")
        self.sub_button.configure(pady="0")
        self.sub_button.configure(state='disabled')
        self.sub_button.configure(text='''Substitution''')

        self.with_button = tk.Button(self.top)
        self.with_button.place(relx=0.433, rely=0.889, height=24, width=77)
        self.with_button.configure(activebackground="#ececec")
        self.with_button.configure(activeforeground="#000000")
        self.with_button.configure(background="#d9d9d9")
        self.with_button.configure(compound='left')
        self.with_button.configure(disabledforeground="#a3a3a3")
        self.with_button.configure(foreground="#000000")
        self.with_button.configure(highlightbackground="#d9d9d9")
        self.with_button.configure(highlightcolor="black")
        self.with_button.configure(pady="0")
        self.with_button.configure(state='disabled')
        self.with_button.configure(text='''Withdrawl''')
    def reg_command(self):
        self.add_button.configure(state='enable')
        self.sub_button.configure(state='enable')
        self.with_button.configure(state='enable')

def start_up():
    main_support.main()

def main(*args):
    '''Main entry point for the application.'''
    global root
    root = tk.Tk()
    root.protocol( 'WM_DELETE_WINDOW' , root.destroy)
    global _top1, _w1
    _top1 = root
    _w1 = Toplevel1
    root.mainloop()


if __name__ == '__main__':
    main()




