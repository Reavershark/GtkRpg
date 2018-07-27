import d2sqlite3;
import gdk.Event;
import gtk.Builder;
import gtk.Button;
import gtk.Grid;
import gtk.Image;
import gtk.Label;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import std.stdio;

private Database* db;

void main(string[] args) {
    db = new Database("res/database.db");

    Main.init(args);

    Builder builder = new Builder();
    builder.addFromFile("res/app.glade");
    Window win = cast(Window)builder.getObject("window");
    win.addOnHide( delegate void(Widget aux){ Main.quit(); } );

    Grid collection = cast(Grid)builder.getObject("collectionGrid");
    Grid inspector = cast(Grid)builder.getObject("collectionInspector");
    fillCollection(collection, inspector);

    win.showAll();
    Main.run;
}

void fillCollection(Grid collection, Grid inspector) {
    string[] tables = ["equipment", "consumables"];

    foreach(string table; tables) {
        ResultRange results = db.execute("SELECT * FROM " ~ table); // ~ " WHERE collected = 1");
        foreach(Row row; results) {
            auto button = new CollectionButton(inspector, row.save());
            button.setLabel(row["name"].as!string);
            button.setImage(new Image("res/img/" ~ row["icon"].as!string));
            collection.attachNextTo(button, null, GtkPositionType.RIGHT, 1, 1);
        }
    }
}

class CollectionButton : Button {
    private Grid inspector;
    private Row row;

    this (Grid inspector, Row row) {
        super();
        this.inspector = inspector;
        this.row = row;
        setImagePosition(GtkPositionType.BOTTOM);
        addOnClicked(&updateInspector);
    }

    private void updateInspector(Button button) {
        inspector.removeAll();

        writeln(row);

        inspector.attach(new Label("Name: "), 0, 0, 1, 1);
        inspector.attach(new Label(row["name"].as!string), 1, 0, 1, 1);

        //inspector.attach(new Label("Power: "), 0, 1, 1, 1);
        //inspector.attach(new Label(row["power"].as!string), 1, 1, 1, 1);

        //inspector.attach(new Label("Description: "), 0, 2, 1, 1);
        //inspector.attach(new Label(row["description"].as!string), 1, 2, 1, 1);

        //inspector.attach(new Label("Effect: "), 3, 0, 1, 1);
        //inspector.attach(new Label(row["effect"].as!string), 3, 1, 1, 1);
        //inspector.attach(new Label("Amount: "), 4, 0, 1, 1);
        //inspector.attach(new Label(row["amount"].as!string), 4, 1, 1, 1);

        //inspector.attach(new Label("Type: "), 3, 0, 1, 1);
        //inspector.attach(new Label(row["type"].as!string), 3, 1, 1, 1);

        inspector.showAll();
    }
}
