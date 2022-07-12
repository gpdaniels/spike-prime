#!/usr/bin/python3

# A Hub:
#    ___________________________ 
#   |                           |
#   |     ┌---┐          .-.    | 
#   |     | L |         ( B )   | 
#   |     └---┘          '-'    | 
#   |                           |
#   | A  [ ] [ ] [ ] [ ] [ ]  B |
#   |                           | 
#   |    [ ] [ ] [ ] [ ] [ ]    |
#   |                           | 
#   | C  [ ] [ ] [ ] [ ] [ ]  D |
#   |                           | 
#   |    [ ] [ ] [ ] [ ] [ ]    |
#   |                           | 
#   | E  [ ] [ ] [ ] [ ] [ ]  F | 
#   |                           |
#   |           .---.           |
#   |    .-----/     \-----.    |
#   |   ( <   :       :   > )   |
#   |    '-----\     /-----'    |
#   |           '---'           |
#   |___________________________| 

import argparse
import builtins
import importlib
import os
import pathlib
import runpy
import sys
import threading
import time
import tkinter
import tkinter.filedialog

# To allow the api libraries to interact with the simulator gui it has to be a singleton.
# This is one method of achieving that, more common is to put the code in a module.
class singleton(type):
    def __init__(self, *args, **kwargs):
        self.__instance = None
        super().__init__(*args, **kwargs)
    def __call__(self, *args, **kwargs):
        if self.__instance is None:
            self.__instance = super().__call__(*args, **kwargs)
            return self.__instance
        else:
            return self.__instance

# The core of the simulator, provides access to the simulated hardware and runs the graphical user interface.
class simulator_gui(metaclass=singleton):
    # Constructor creates the gui.
    def __init__(self, skip_animation = False, script_path = "", output_path = ""):
        self.skip_animation = skip_animation
        self.script_path = script_path
        self.output_path = output_path
        
        print("Initialising Lego hub simulator gui...")
        self.setup = False
        self.ready = False
        self.closing = False
        
        print("Creating the simulator window...")
        self.window = tkinter.Tk()
        self.window.title("Lego Hub simulator")
        self.window.geometry("1280x720+50+50")
        self.window.resizable(False, False)
        self.iconphoto_image = tkinter.PhotoImage(file = "./images/icon-spike.png")
        #self.iconphoto_image = tkinter.PhotoImage(file = "./images/icon-mindstorms.png")
        self.window.iconphoto(False, self.iconphoto_image)
        
        print("Enabling hidden file browsing...")
        # Create an impossible dummy dialog to avoid getting a dialog window (throws a TclError).
        try:
            self.window.tk.call('tk_getOpenFile', '-invalid_option')
        except tkinter.TclError:
            pass
        # Now the the internal state is initialised we can set some magic variables to avoid hidden files.
        self.window.tk.call('set', '::tk::dialog::file::showHiddenBtn', '1')
        self.window.tk.call('set', '::tk::dialog::file::showHiddenVar', '0')
        
        print("Adding a menu...")
        self.menu_main = tkinter.Menu()
        
        # Find all the api directories available.
        self.api_root = os.path.join(os.path.dirname(os.path.realpath(__file__)), "api")
        self.api_directories = [directory for directory in os.listdir(self.api_root) if os.path.isdir(os.path.join(self.api_root, directory))]
        
        # Add them all as possible api directories.
        self.api_path_option = tkinter.StringVar()
        self.menu_api = tkinter.Menu(self.menu_main, tearoff=False)
        for api_directory in self.api_directories:
            self.menu_api.add_radiobutton(label=api_directory, variable=self.api_path_option, value=api_directory)
        self.api_path_option.set(self.api_directories[0])
        self.menu_main.add_cascade(label="API", menu=self.menu_api)

        self.menu_main.add_separator()
        
        # Add a script loading button, and bind it to the shortcut ctrl-o.
        self.menu_main.add_command(label="Load Script", command=self.load_script)
        self.window.bind('<Control-o>', lambda event: self.load_script())
        
        self.menu_main.add_separator()
        
        # Add a script loading button, and bind it to the shortcut ctrl-o.
        self.menu_main.add_command(label="Save screenshot", command=self.save_screenshot)
        self.window.bind('<Control-s>', lambda event: self.save_screenshot())
        
        self.window.configure(menu=self.menu_main)
        
        # Setup hub state.
        print("Configuring initial hub state...")
        self.reset_state()
        
        print("Loading hub image...")
        self.background_image = tkinter.PhotoImage(file = "./images/prime.png")
        self.background_label = tkinter.Label(self.window, image=self.background_image)
        self.background_label.place(x=0, y=0)
        
        print("Loading bluetooth button...")
        self.bluetooth_image = tkinter.PhotoImage(file = "./tiles/bluetooth.png")
        self.bluetooth = tkinter.Label(self.window, image=self.bluetooth_image, bg=self.rgb_to_hex(255, 255, 255), borderwidth=0, width=55, height=55)
        self.bluetooth.place(x=224, y=41)
        def bluetooth_press():
            for callback in self.bluetooth_on_press:
                callback()        
        def bluetooth_release():
            for callback in self.bluetooth_on_release:
                callback()
        self.bluetooth.bind("<Button-1>", lambda event: bluetooth_press())
        self.bluetooth.bind("<ButtonRelease-1>", lambda event: bluetooth_release())
        
        print("Loading light images...")
        self.light_image = tkinter.PhotoImage(file = "./tiles/light.png")
        self.lights = [[None] * 5 for i in range(5)]
        for x in range(5):
            for y in range(5):
                self.lights[x][y] = tkinter.Label(self.window, image=self.light_image, bg=self.rgb_to_hex(255, 255, 255), borderwidth=0, width=42, height=42)
                self.lights[x][y].place(x=46 + (43 + 4) * x, y=129 + (43 + 4) * y)            
        
        print("Loading centre button...")
        self.button_image = tkinter.PhotoImage(file = "./tiles/button.png")
        self.button = tkinter.Label(self.window, image=self.button_image, bg=self.rgb_to_hex(255, 255, 255), borderwidth=0, width=88, height=88)
        self.button.place(x=117, y=383)
        def button_press():
            for callback in self.button_on_press:
                callback()
        def button_release():
            for callback in self.button_on_release:
                callback()
        self.button.bind("<Button-1>", lambda event: button_press())
        self.button.bind("<ButtonRelease-1>", lambda event: button_release())
        
        print("Loading left and right buttons...")
        self.left_image = tkinter.PhotoImage(file = "./tiles/left.png")
        self.left = tkinter.Label(self.window, image=self.left_image, borderwidth=0, width=73, height=46)
        self.left.place(x=44, y=404)
        def left_press():
            for callback in self.left_on_press:
                callback()            
        def left_release():
            for callback in self.left_on_release:
                callback()
        self.left.bind("<Button-1>", lambda event: left_press())
        self.left.bind("<ButtonRelease-1>", lambda event: left_release())
        self.right_image = tkinter.PhotoImage(file = "./tiles/right.png")
        self.right = tkinter.Label(self.window, image=self.right_image, borderwidth=0, width=73, height=46)
        self.right.place(x=205, y=404)            
        def right_press():
            for callback in self.right_on_press:
                callback()
        def right_release():
            for callback in self.right_on_release:
                callback()
        self.right.bind("<Button-1>", lambda event: right_press())
        self.right.bind("<ButtonRelease-1>", lambda event: right_release())
        
        def set_closing():
            self.closing = True
        self.window.protocol("WM_DELETE_WINDOW", set_closing)
        
        print("Setup done.")
        self.setup = True
        
    def rgb_to_hex(self, red, green, blue):
        return "#%02x%02x%02x" % (red, green, blue)  

    def hex_to_rgb(self, colour_code):
        return tuple(int(colour_code[i:i+2], 16) for i in (1, 3, 5))

    def mainloop(self):
        # Start the main loop of the gui.
        print("Starting the GUI...")
        if (self.skip_animation == False):
            self.animation_startup()
        else:
            self.set_image("09090:99999:99999:09990:00900")
        
        print("Starting the main loop...")
        self.ready = True
        if (not self.script_path == ""):
            self.load_script(self.script_path)
        while self.closing == False:
            self.window.update_idletasks()
            self.window.update()
            time.sleep(0.01)
        self.ready = False
        
        # Close the window
        print("Closing the GUI...")
        if (self.skip_animation == False):
            self.animation_shutdown()
        self.window.destroy()
        self.setup = False
        
        print("Done.")
            
    def load_script(self, script_path = ""):
        if (not self.ready == True):
            print("Simulator startup not complete.")
            return
        
        if (script_path == ""):
            print("Opening file dialog...")
            file = tkinter.filedialog.askopenfile(initialdir = str(pathlib.Path.cwd()), title = "Select file", mode ='r', filetypes =[('Python Files', '*.py')]) 
            if file is None:
                print("Cancelled loading file.")
                return;
            script_path = file.name
        
        print("Executing file '" + script_path + "'...")
        
        # Create a restricted version of the import function.
        def restricted_import(name, globals=None, locals=None, fromlist=(), level=0):
            print("Importing '" + name + "' from '" + globals["__name__"] + "'...")
            # If we are check for special "simulator_" imports.
            # We override simulator_gui imports with the gui class.
            if (name == "simulator_gui"):
                return self
            # We override other "simulator_" imports with the name after the underscore.
            if (name.startswith("simulator_")):
                return importlib.__import__(name.split("_")[1], globals, locals, fromlist, level)
            # A few modules that are always allowed, to help debugging.
            if (globals["__name__"].startswith(("zipimport", "runpy", "pkgutil", "_pydevd_bundle", "importlib"))):
                return importlib.__import__(name, globals, locals, fromlist, level)
            # Next check if we have already loaded it.
            if (name in self.loaded_modules):
                return self.loaded_modules[name]
            # Otherwise we only allow loading from the selected api path.
            try:
                # Try and load directly from the path.
                module_path = os.path.join(self.api_root, self.api_path_option.get(), name + ".py")
                module_loader = importlib.machinery.SourceFileLoader(name, module_path)
                module_spec = importlib.util.spec_from_loader(module_loader.name, module_loader)
                module_handle = importlib.util.module_from_spec(module_spec)
                module_loader.exec_module(module_handle)
                self.loaded_modules[name] = module_handle
                return module_handle
            except BaseException as exception:
                # If loading fails, restore the original import command and rethrow.
                builtins.__import__ = importlib.__import__
                raise exception
             
        # Override the normal import function with the limited version.   
        builtins.__import__ = restricted_import
        
        if (not self.output_path == ""):
            stdout_temp = sys.stdout
            sys.stdout = open(self.output_path, 'w')
        
        # Run the script.
        try:
            runpy.run_path(script_path, run_name='__main__')
        finally:
            if (not self.output_path == ""):
                sys.stdout = stdout_temp
            # Restore the hub state.
            self.reset_state()
            builtins.__import__ = importlib.__import__
            print("Finished file '" + script_path + "'.")

    def save_screenshot(self, screenshot_path = "screenshot.png"):
        print("Saving screenshot...")
        try:
            import mss
            import mss.tools
            with mss.mss() as sct:
                # The screen part to capture
                monitor = {"top": self.window.winfo_y(), "left": self.window.winfo_x(), "width": self.window.winfo_width(), "height": self.window.winfo_height()}
                # Grab the data.
                sct_img = sct.grab(monitor)
                # Save to the picture file.
                mss.tools.to_png(sct_img.rgb, sct_img.size, output=screenshot_path)
                print("Screenshot saved to '{}'.".format(screenshot_path))
        except:
            print("Failed to capture screenshot, ensure you have the mss package installed.")

    def reset_state(self):
        self.loaded_modules = dict()
        self.battery_charging = True
        self.battery_level = 1.0
        self.temperature = 0.0
        self.orientation = (0.0, 0.0, 0.0)
        self.accerometer = (0.0, 0.0, 0.0)
        self.gyroscope = (0.0, 0.0, 0.0)
        self.bluetooth_on_press = []
        self.bluetooth_on_release = []
        self.button_on_press = []
        self.button_on_release = []
        self.left_on_press = []
        self.left_on_release = []
        self.right_on_press = []
        self.right_on_release = []

    def add_bluetooth_callbacks(self, on_press, on_release):
        self.bluetooth_on_press.append(on_press)
        self.bluetooth_on_release.append(on_press)

    def add_button_callbacks(self, on_press, on_release):
        self.button_on_press.append(on_press)
        self.button_on_release.append(on_press)

    def add_left_callbacks(self, on_press, on_release):
        self.left_on_press.append(on_press)
        self.left_on_release.append(on_press)

    def add_right_callbacks(self, on_press, on_release):
        self.right_on_press.append(on_press)
        self.right_on_release.append(on_press)

    def get_bluetooth(self):
        return self.hex_to_rgb(self.bluetooth['bg'])
        
    def set_bluetooth(self, red, green, blue):
        assert((red >= 0) and (red <= 255))
        assert((green >= 0) and (green <= 255))
        assert((blue >= 0) and (blue <= 255))
        self.bluetooth.config(bg=self.rgb_to_hex(red, green, blue))
        self.bluetooth.update()

    def get_led(self):
        return self.hex_to_rgb(self.button['bg'])

    def set_led(self, red, green, blue):
        assert((red >= 0) and (red <= 255))
        assert((green >= 0) and (green <= 255))
        assert((blue >= 0) and (blue <= 255))
        self.button.config(bg=self.rgb_to_hex(red, green, blue))
        self.button.update()

    def get_pixel(self, x, y):
        assert((x >= 0) and (x < 5))
        assert((y >= 0) and (y < 5))
        light_colour = [
            self.rgb_to_hex(255, 255, 255),
            self.rgb_to_hex(255, 243, 193),
            self.rgb_to_hex(255, 239, 169),
            self.rgb_to_hex(255, 234, 145),
            self.rgb_to_hex(255, 230, 121),
            self.rgb_to_hex(255, 226, 97),
            self.rgb_to_hex(255, 222, 73),
            self.rgb_to_hex(255, 218, 49),
            self.rgb_to_hex(255, 214, 25),
            self.rgb_to_hex(255, 210, 0)
        ]
        return light_colour.index(self.lights[x][y]['bg'])

    def set_pixel(self, x, y, value):
        assert((x >= 0) and (x < 5))
        assert((y >= 0) and (y < 5))
        assert((value >= 0) and (value <= 9))
        light_colour = [
            self.rgb_to_hex(255, 255, 255),
            self.rgb_to_hex(255, 243, 193),
            self.rgb_to_hex(255, 239, 169),
            self.rgb_to_hex(255, 234, 145),
            self.rgb_to_hex(255, 230, 121),
            self.rgb_to_hex(255, 226, 97),
            self.rgb_to_hex(255, 222, 73),
            self.rgb_to_hex(255, 218, 49),
            self.rgb_to_hex(255, 214, 25),
            self.rgb_to_hex(255, 210, 0)
        ]
        self.lights[x][y].config(bg=light_colour[value])
        self.lights[x][y].update()

    def set_image(self, image_string):
        assert(len(image_string) == 29)
        assert(image_string[5] == ":")
        assert(image_string[11] == ":")
        assert(image_string[17] == ":")
        assert(image_string[23] == ":")
        for y in range(5):
            for x in range(5):
                assert(int(image_string[y * 6 + x]) >= 0)
                assert(int(image_string[y * 6 + x]) <= 9)
                self.set_pixel(x, y, int(image_string[y * 6 + x]))
                self.lights[x][y].update()
    
    def get_temperature(self):
        return self.temperature
        
    def set_temperature(self, temperature):
        self.temperature = temperature

    # Function to wrap raw samples with a wav header, returned as a byte array.
    def samples_to_wav(self, bytes_per_sample, number_of_channels, sample_rate, samples):
        # RIFF header (Chunk ID).
        data = b'RIFF'
        # Size.
        wave_size = 36 + len(samples) * bytes_per_sample
        data = data + wave_size.to_bytes(4, 'little')
        # Format.
        data = data + b'WAVE'
        # Format header (Sub-chunk ID).
        data = data + b'fmt '
        # Sub-chunk size (16 for PCM).
        fmt_size = 16
        data = data + fmt_size.to_bytes(4, 'little')
        # Compression code (1 for no compression).
        compression_code = 1
        data = data + compression_code.to_bytes(2, 'little')
        # Channel count.
        data = data + number_of_channels.to_bytes(2, 'little')
        # Sample rate.
        data = data + sample_rate.to_bytes(4, 'little')
        # Byte rate.
        byte_rate = bytes_per_sample * number_of_channels * sample_rate;
        data = data + byte_rate.to_bytes(4, 'little')
        # Block align.
        block_align = bytes_per_sample * number_of_channels
        data = data + block_align.to_bytes(2, 'little')
        # Bits per sample.
        bits_per_sample = bytes_per_sample * 8
        data = data + bits_per_sample.to_bytes(2, 'little')
        # Data header (Sub-chunk ID).
        data = data + b'data'
        # Sub-Chunk size.
        data_size = len(samples) * bytes_per_sample
        data = data + data_size.to_bytes(4, 'little')
        for sample in samples:
            if (isinstance(sample, int)):
                data = data + sample.to_bytes(bytes_per_sample, 'little', signed = True)
            elif (isinstance(sample, float)):
                scaled_sample = float(sample) * float(2**(bytes_per_sample * 8 - 1))
                data = data + int(scaled_sample).to_bytes(bytes_per_sample, 'little', signed = True)
            else:
                raise TypeError("Unexpected sample type, only int and float are supported.")
        return data

    def play_sound_windows(self, wav_file_as_byte_array):
        import winsound
        winsound.PlaySound(wav_file_as_byte_array, winsound.SND_MEMORY)

    def play_sound_darwin(self, wav_file_as_byte_array):
        from AppKit import NSSound
        from AppKit import NSObject
        from AppKit import NSData
        
        nssound = NSSound.alloc()
        data = NSData.alloc().initWithBytes_length_(wav_file_as_byte_array, len(wav_file_as_byte_array))
        nssound.initWithData_(data)
        nssound.setDelegate_(self)
        if (not nssound):
            raise IOError('Unable to load sound.')
        nssound.play()

    def play_sound_linux(self, wav_file_as_byte_array):
        class player():
            def __init__(self):
                import gi
                gi.require_version("Gst", "1.0")
                
                from gi.repository import GObject
                from gi.repository import Gst
                
                GObject.threads_init()
                Gst.init(None)
                
                self.buffer = None
                self.mainloop = GObject.MainLoop()

                # This creates a playbin pipeline and using the appsrc source we can feed it our stream data
                self.pipeline = Gst.ElementFactory.make("playbin", None)
                self.pipeline.set_property("uri", "appsrc://")

                # When the playbin creates the appsrc source it will call this callback and allow us to configure it
                self.pipeline.connect("source-setup", self.on_source_setup)

                # Creates a bus and set callbacks to receive errors
                self.bus = self.pipeline.get_bus()
                self.bus.add_signal_watch()
                self.bus.connect("message::eos", self.on_eos)
                self.bus.connect("message::error", self.on_error)

            def exit(self, msg):
                self.stop()
                exit(msg)

            def stop(self):
                # Stop playback and exit mainloop
                from gi.repository import Gst
                self.pipeline.set_state(Gst.State.NULL)
                self.mainloop.quit()
                self.buffer = None

            def play(self, data):
                from gi.repository import Gst
                self.buffer = data
                self.pipeline.set_state(Gst.State.PLAYING)
                self.mainloop.run()

            def on_source_setup(self, element, source):
                # When this callback is called the appsrc expects us to feed it more data
                source.connect("need-data", self.on_source_need_data)

            def on_source_need_data(self, source, length):
                # Attempt to read data from the stream
                data = self.buffer
                
                # If data is empty it's the end of stream
                if not data:
                    source.emit("end-of-stream")
                    return

                # Convert the Python bytes into a GStreamer Buffer and then push it to the appsrc
                from gi.repository import Gst
                buf = Gst.Buffer.new_wrapped(data)
                source.emit("push-buffer", buf)

            def on_eos(self, bus, msg):
                # Stop playback on end of stream
                self.stop()

            def on_error(self, bus, msg):
                # Print error message and exit on error
                error = msg.parse_error()[1]
                self.exit(error)
        player().play(wav_file_as_byte_array)

    def play_sound(self, path, skip_samples=0):
        handle = open(path, "rb")
        data = handle.read()
        samples = [int.from_bytes([data[i], data[i+1]], byteorder='little', signed=True) for i in range(0, len(data), 2)]
        assert(skip_samples < len(samples))
        wav = self.samples_to_wav(2, 1, 16000, samples[skip_samples:])
        from platform import system
        system = system()
        if (system == "Windows"):
            self.play_sound_windows(wav)
        elif (system == "Darwin"):
            self.play_sound_darwin(wav)
        elif (system == "Linux"):
            self.play_sound_linux(wav)
        else:
            NotImplementedError("Unknown system '{}' is not supported.".format(system))
        
    def animation_startup(self):
        for percent in range(100, 0, -10):
            self.set_led(255, 255, int(80.0 * (float(percent) / 100.0)))
            time.sleep(30.0 / 1000.0)
        self.set_led(255, 255, 255)
        frames = [
            ["00000:00000:09000:00000:00000", 25],
            ["00000:00000:07000:00000:00000", 242],
            ["00000:00000:07000:00009:00000", 15],
            ["00000:00000:07000:00007:00000", 204],
            ["00000:00000:07000:90007:00000", 9],
            ["00000:00000:07000:70007:00000", 159],
            ["00000:90000:07000:70007:00000", 6],
            ["00000:70000:07000:70007:00000", 52],
            ["00000:70000:07000:70007:00900", 4],
            ["00000:70000:07000:70007:00700", 45],
            ["00000:70900:07000:70007:00700", 121],
            ["00090:70800:07000:70007:00700", 37],
            ["00080:70800:07000:79007:00700", 34],
            ["00080:70700:07090:78007:00700", 31],
            ["00070:70700:07080:78007:90700", 29],
            ["09070:70700:07070:77007:80700", 87],
            ["08070:70700:07070:77007:80709", 27],
            ["08079:70700:07070:77007:70708", 23],
            ["07078:70700:07070:77907:70708", 21],
            ["07078:79700:07070:77707:70707", 19],
            ["07077:78700:07079:77707:70707", 17],
            ["07077:78700:07078:77707:79707", 75],
            ["07977:78700:07078:77707:78707", 14],
            ["07877:77700:07078:77797:78707", 13],
            ["07877:77709:07077:77787:78707", 12],
            ["07877:77708:97077:77787:77707", 11],
            ["07777:77708:87077:77787:77797", 60],
            ["07777:77798:87077:77777:77787", 9],
            ["97777:77787:87077:77777:77787", 8],
            ["87777:77787:87977:77777:77787", 28],
            ["99999:99999:99999:99999:99999", 215],
            ["09090:99999:99999:09990:00900", 500]
        ]
        sound_thread = threading.Thread(target=self.play_sound, args=["./sounds/startup"], kwargs={})
        sound_thread.start()
        for frame in frames:
            self.set_image(frame[0])
            time.sleep((frame[1] / 1000) / 2)
        sound_thread.join()

    # Shutdown animation.
    def animation_shutdown(self):
        frames = [
            ["99999:90009:90009:90009:99999", 40],
            ["55555:57775:57075:57775:55555", 40],
            ["00000:09990:09090:09990:00000", 40],
            ["00000:05550:05750:05550:00000", 40],
            ["00000:00000:00900:00000:00000", 40],
            ["00000:00000:00500:00000:00000", 40],
            ["00000:00000:00000:00000:00000", 40]
        ]
        sound_thread = threading.Thread(target=self.play_sound, args=["./sounds/menu_shutdown", 25000], kwargs={})
        sound_thread.start()
        for frame in frames:
            self.set_image(frame[0])
            time.sleep(frame[1] / 1000)
        sound_thread.join()

################################################################################

if __name__ == "__main__":
    print("Parsing arguments...")
    parser = argparse.ArgumentParser(description="Simulate a hub allowing local testing of micropython scripts.")
    parser.add_argument("-s", "--skip_animation", help="Reboot the hub before connecting\n", action='store_true')
    parser.add_argument("script_path", nargs='?', help="Script file name to run", default="")
    parser.add_argument("output_path", nargs='?', help="Output file to used for responses from the hub.\n", default="")
    arguments = parser.parse_args()
    
    gui = simulator_gui(arguments.skip_animation, arguments.script_path, arguments.output_path)
    gui.mainloop()
