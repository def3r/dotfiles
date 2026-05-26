import os
from urllib.request import urlopen

# Initialize configuration loading
config.load_autoconfig(False)

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'mocha', True)
    c.colors.tabs.even.bg = "#181825"
    c.colors.tabs.even.fg = "#cdd6f4"
    c.colors.tabs.odd.bg = "#181825"
    c.colors.tabs.odd.fg = "#cdd6f4"

# Access the settings object
c = c

# config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36')

c.tabs.position = "left"
c.tabs.show = "multiple"
c.tabs.width = "10%"
# c.statusbar.show = "in-mode"
# c.completion.shrink = True

c.content.blocking.method = "adblock"
c.content.pdfjs = True
c.content.plugins = True

def uglytheme():
    c.colors.tabs.bar.bg = "#171717"
    c.colors.tabs.even.bg = "#090909"
    c.colors.tabs.odd.bg = "#090909"
    c.colors.tabs.selected.even.bg = "#babff1"
    c.colors.tabs.selected.even.fg = "black"
    c.colors.tabs.selected.odd.bg = "#babff1"
    c.colors.tabs.selected.odd.fg = "black"
    c.colors.tooltip.bg = "#171717"
    c.colors.tooltip.fg = "#babff1"
    c.colors.statusbar.command.bg = "#808040"
    c.colors.statusbar.command.fg = "white"
    c.colors.statusbar.insert.bg = "#fd8040"
    c.colors.statusbar.insert.fg = "black"
    c.colors.statusbar.normal.bg = "#171717"
    c.colors.statusbar.normal.fg = "#efefef"

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
c.tabs.padding = { "bottom": 4, "left": 5, "right": 5, "top": 4 }
c.tabs.indicator.padding = {"bottom": 2, "left": 0, "right": 4, "top": 2}
c.statusbar.padding = {"bottom": 4, "left": 0, "right": 0, "top": 4}

c.url.start_pages = ["https://google.com"]
c.url.default_page = "https://google.com"

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "duck": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "yt": "https://www.youtube.com/results?search_query={}"
}

c.editor.command = ["alacritty", "-e", "nvim", "{file}"]

config.unbind('d')

config.bind('tt', 'config-cycle tabs.show multiple never')
config.bind('st', 'config-cycle statusbar.show always never')
config.bind('x', 'tab-close')
config.bind('tn', 'open -t')
