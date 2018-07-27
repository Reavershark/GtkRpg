import d2sqlite3;
import gdk.Event;
import gtk.Builder;
import gtk.Button;
import gtk.Grid;
import gtk.Image;
import gtk.Label;
import gtk.Main;
import gtk.SearchEntry;
import gtk.Widget;
import gtk.Window;
import std.conv;
import std.stdio;

private Database* db;

struct Equipment {
    string name;
    int power;
    string type;
    string icon;
    string description;
    bool collected;
}

struct Consumable {
    string name;
    int power;
    string effect;
    int amount;
    string icon;
    string description;
    bool collected;
}

void main(string[] args) {
    db = new Database("res/database.db");

    Main.init(args);

    Builder builder = new Builder();
    builder.addFromFile("res/gui.glade");
    Window win = cast(Window)builder.getObject("window");
    win.addOnHide( delegate void(Widget aux){ Main.quit(); } );

    Grid collection = cast(Grid)builder.getObject("collectionGrid");
    Grid inspector = cast(Grid)builder.getObject("collectionInspector");
    fillCollection(collection, inspector, "");

    SearchEntry search = cast(SearchEntry)builder.getObject("collectionSearch");
    void handleSearch(SearchEntry entry) {
        fillCollection(collection, inspector, entry.getText());
    }
    search.addOnSearchChanged(&handleSearch);

    win.showAll();
    Main.run;
}

void fillCollection(Grid collection, Grid inspector, string filter) {
    collection.removeAll();

    ResultRange results;
    int x = 0;
    int y = 0;
    int collumns = 8;

    results = db.execute("SELECT * FROM equipment WHERE name LIKE '%" ~ filter ~ "%'");
    foreach(Row row; results) {
        auto button = new CollectionEquipmentButton(inspector, row.as!Equipment());
        button.setLabel(row["name"].as!string);
        button.setImage(new Image("res/img/" ~ row["icon"].as!string));
        collection.attach(button, x, y, 1, 1);
        x++;
        if (x >= collumns) {
            x = 0;
            y++;
        }
    }

    results = db.execute("SELECT * FROM consumables WHERE name LIKE '%" ~ filter ~ "%'");
    foreach(Row row; results) {
        auto button = new CollectionConsumableButton(inspector, row.as!Consumable());
        button.setLabel(row["name"].as!string);
        button.setImage(new Image("res/img/" ~ row["icon"].as!string));
        collection.attach(button, x, y, 1, 1);
        x++;
        if (x >= collumns - 1) {
            x = 0;
            y++;
        }
    }

    collection.showAll();
}

class CollectionButton : Button {
    private Grid inspector;

    this(Grid inspector) {
        this.inspector = inspector;
        setImagePosition(GtkPositionType.BOTTOM);
    }

    private void fillInspector(string[] descriptions, string[] values) {
        inspector.removeAll();
        assert(descriptions.sizeof == values.sizeof);
        int i = 0;
        foreach(string desc; descriptions) {
           Label label = new Label(desc);
           label.setXalign(0);
           inspector.attach(label, 0, i, 1, 1);
           i++;
        }
        i = 0;
        foreach(string val; values) {
           Label label = new Label(val);
           label.setXalign(0);
           inspector.attach(label, 1, i, 1, 1);
           i++;
        }
        inspector.showAll();
    }
}

class CollectionConsumableButton : CollectionButton {
    private Consumable data;

    this (Grid inspector, Consumable data) {
        super(inspector);
        this.data = data;
        addOnClicked(&updateInspector);
    }

    private void updateInspector(Button button) {
        string[] descriptions = [
            "Name: ",
            "Power: ",
            "Description: ",
            "Effect: ",
            "Amount: "
        ];
        string[] values = [
            data.name,
            to!string(data.power),
            data.description,
            data.effect,
            to!string(data.amount)
        ];
        fillInspector(descriptions, values);
    }
}

class CollectionEquipmentButton : CollectionButton {
    private Equipment data;

    this (Grid inspector, Equipment data) {
        super(inspector);
        this.data = data;
        addOnClicked(&updateInspector);
    }

    private void updateInspector(Button button) {
        string[] descriptions = [
            "Name: ",
            "Power: ",
            "Description: ",
            "Type: "
        ];
        string[] values = [
            data.name,
            to!string(data.power),
            data.description,
            data.type
        ];
        fillInspector(descriptions, values);
    }
}
