import sys
import tkinter as tk
import tkinter.ttk as ttk
from tkinter.constants import *

import main

def main(*args):
    '''Main entry point for the application.'''
    global root
    root = tk.Tk()
    root.protocol( 'WM_DELETE_WINDOW' , root.destroy)
    global _top1, _w1
    _top1 = root
    _w1 = main.Toplevel1
    root.mainloop()

def show_register(*args):
    print('main_support.def show_register')
    for arg in args:
        print ('another arg:', arg)
    sys.stdout.flush()

if __name__ == '__main__':
    main.start_up()
