{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/vnd.mozilla.xul+xml" = ["firefox.desktop"];
      # "application/x-bittorrent" = ["firefox.desktop"];
      "application/x-qpwgraph-patchbay" = ["org.rncbc.qpwgraph.desktop"];
      "application/x-shellscript" = ["redvim.desktop"];
      "application/xhtml+xml" = ["org.qutebrowser.qutebrowser.desktop"];
      # "image/heic" = ["firefox.desktop"];
      # "image/jpeg" = ["satty.desktop"];
      # "image/jxl" = ["firefox.desktop"];
      # "image/png" = ["satty.desktop"];
      # "image/svg+xml" = ["firefox.desktop"];
      "inode/directory" = ["yazi.desktop"];
      "text/*" = ["redvim.desktop"];
      "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
      "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
      "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
      # "x-scheme-handler/matrix" = ["org.gnome.Fractal.desktop"];
    };
  };
}
