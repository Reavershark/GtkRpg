import collection;
import d2sqlite3;
import gtk.Builder;
import gtk.Grid;
import gtk.Main;
import gtk.SearchEntry;
import gtk.Widget;
import gtk.Window;
import std.conv;

public Database* db;

void main(string[] args) {
    db = new Database("res/database.db");

    Main.init(args);

    Builder builder = new Builder();
    builder.addFromFile("res/gui.glade");
    Window win = cast(Window)builder.getObject("window");
    win.addOnHide( delegate void(Widget aux){ Main.quit(); } );

    Grid collection = cast(Grid)builder.getObject("collectionGrid");
    Grid inspector = cast(Grid)builder.getObject("collectionInspector");
    SearchEntry searchEntry = cast(SearchEntry)builder.getObject("collectionSearch");
    setupCollection(collection, inspector, searchEntry, db);

    win.showAll();
    Main.run;
}
