import gtk.Main;
import gtk.MainWindow;
import gtk.Box;
import gtk.Stack;
import gtk.StackSwitcher;
import gdk.Event;
import gtk.Widget;

private MainWindow mainWin;

void main(string[] args) {
    Main.init(args);

    mainWin = new MainWindow("GtkRpg");

    //Button buttonPlay = new Button("Play");
    //Button buttonLoadout = new LoadoutButton("Loadout editor");
    //ExitButton buttonExit = new ExitButton("Exit");
    Stack stack = new Stack();
    StackSwitcher stackSwitcher = new StackSwitcher();
    stackSwitcher.setStack(stack);

    Box box = new Box(Orientation.VERTICAL, 30);
    //box.packStart(buttonPlay, true, true, 0);
    //box.packStart(buttonLoadout, true, true, 0);
    //box.packStart(buttonExit, true, true, 0);
    
    mainWin.setDefaultSize(200, 200);
    mainWin.add(box);
    mainWin.showAll();
    Main.run;
}

//class LoadoutButton : Button {
//
//    this(in string text) {
//        super(text);
//        addOnButtonRelease(&openLoadout);
//    }
//
//    private bool openLoadout(Event event, Widget widget) {
//        MainWindow loadoutWin = new MainWindow("Loadout editor");
//        loadoutWin.setDefaultSize(200, 200);
//        loadoutWin.add(new Button("Loadout editor"));
//        loadoutWin.showAll();
//
//        mainWin.close();
//        return true;
//    }
//}
//
//class ExitButton : Button {
//    this(in string text) {
//        super(text);
//        addOnButtonRelease(&exit);
//    }
//
//    private bool exit(Event event, Widget widget) {
//        Main.quit();
//        return true;
//    }
//}
