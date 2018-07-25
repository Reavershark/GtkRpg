import gtk.Main;
import gtk.MainWindow;
import gtk.Box;
import gtk.Stack;
import gtk.StackSwitcher;
import gtk.Label;

private MainWindow mainWin;

void main(string[] args) {
    Main.init(args);

    mainWin = new MainWindow("GtkRpg");

    Stack stack = new Stack();
    StackSwitcher stackSwitcher = new StackSwitcher();
    stackSwitcher.setStack(stack);
    
    stack.addTitled(new Label("Play menu"), "play", "Play");
    stack.addTitled(new Label("Loadout editor"), "loadout", "Loadout");
    stack.addTitled(new Label("Collection"), "collection", "Collection");

    Box box = new Box(Orientation.VERTICAL, 30);
    box.packStart(stackSwitcher, true, true, 0);
    box.packStart(stack, true, true, 0);
    
    mainWin.setDefaultSize(200, 200);
    mainWin.add(box);
    mainWin.showAll();
    Main.run;
}
