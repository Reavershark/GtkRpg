import gtk.Builder;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import std.stdio;

void main(string[] args) {
    Main.init(args);
    Builder builder = new Builder();
    builder.addFromFile("app.glade");

    Window win = cast(Window)builder.getObject("window");
    win.addOnHide( delegate void(Widget aux){ Main.quit(); } );

    win.showAll();
    Main.run;
}
