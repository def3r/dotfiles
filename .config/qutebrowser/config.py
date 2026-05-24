# Initialize configuration loading
config.load_autoconfig(False)

# Access the settings object
c = c

c.tabs.position = "left"
c.tabs.show = "multiple"
c.tabs.width = "10%"
c.statusbar.show = "in-mode"
# c.completion.shrink = True

c.content.blocking.method = "adblock"
c.content.pdfjs = True
c.content.plugins = True

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True

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
