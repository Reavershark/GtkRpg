import d2sqlite3;
import gtk.Builder;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import std.stdio;

void main(string[] args) {
    auto db = new Database("database.db");

    Main.init(args);

    Builder builder = new Builder();
    builder.addFromFile("app.glade");

    Window win = cast(Window)builder.getObject("window");
    win.addOnHide( delegate void(Widget aux){ Main.quit(); } );

    win.showAll();
    Main.run;
}
