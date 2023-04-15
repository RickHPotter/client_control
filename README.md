# State Management

Okay, this is the key point for anyone to become a real Flutter Developer.

Knowing State Management is crucial for making and understanding good and large scale apps.

## Alura Side // TODO: EVOLVE THIS PROJECT INTO SOMETHING OF MINE

### 🛠️ This project is part of this [Alura course.](https://github.com/alura-cursos/alura_flutter_client_control/)

## 🔨 Project: Client Control

The Course project consists of a cliente management in a way that we can register clients, client types and attach such client type to certain clients using state management approach.

## ✔️ Techniques and Technologies

**We will learn about:** :

- `Provider`: What is a provider and its capability as a State Manager.
- `Consumer`: A Widget that acts a single source of truth.
- `Provider.of`: The way to access state values outside of the Widget Tree.
- `ChangeNotifier`: Makes it possible to prepare a model to work as a single source of truth.
- `notifyListeners()`: Notifies state changes to the listeners and its components.
- `MultiProvider`: Responsible for providing a way for multiple provider management in the Widget Tree.
- `Redux`: State Management Concepts and Principles based on Redux.
- `BloC`: How this State Management Design works.

## -- X -- SIDE-STUDY

### STATE

**State** is the condition of your app at any given moment. When the user taps a button that takes them to another screen, your app is in a different condition - that is, a different state. If the screen has an empty text field, typing something into that field takes your app to a different state. *State* is an information that may be read when the widget is formed and may change or adjusted throughout the app's existence.

**State Management** is the price you pay for interactivity. If your app responds to user input, you're managing state.

Flutter's State Management is divided into two conceptual categories, which are ->

- **Ephemeral State** -> Also called *UI State* or *Local State*, it is a sort of state associated with a particular widget, or we can say that it is a state contained within a single widget. It requires no techniques other than the famous `setState((){})` inside a *Stateful Widget*.
- **App State** -> It is a form os state that we wish to preserve throughout user sessions and distribute across different portions of our programme. As a result, this form of state may be applied globally. It is also called an *Application State* or *Shared State* at times.

A way to achieve an architecture that allows sharing state between widgets is to adopt ->

**Inherited Widget**, a built-in class that allows its child widgets to access its data. It's the basis for a lot of other state management widgets. By creating a class that extends `InheritedWidget` and give it some data, any child widget can access thatr data by calling `context.dependOnInheritedWidgetOfExactType<class>()`.

Advantages are that it's built-in, so no need to worry about external packages. Disadvantages are that it's too verbose and data has to be immutable.

To overcome the disadvantages, [*scoped_model*](https://pub.dev/packages/scoped_model) was an interesting solution which was then replaced by a better solution that even Google abide by ->

**Provider** was designed to wrap around *InheritedWidget*. In essence, *Provider* is a set of classes that simplifies building a state management solution on top of InheritedWidget.

Classes used by Provider include ->

- **ChangeNotifier** -> A class that adds and removes listeners, then notifies those listeners of any changes. You usually extend the class for models so you can send notifications when your model changes, by calling `notifyListeners()`.

- **ChangeNotifierProvider** -> A widget that wraps a class, implementing `ChangeNotifier` and uses the child widget for display. When changes are broadcast, the widget rebuilds its tree. The syntax looks like this ->

``` dart
changeNotifierProvider(
    create: (context) => MyModel(),
    child: <widget>,
);
```

*Provider* offers a central point to manage state, so that you don't need to manually update different widgets via setState() every time that state changes. Be reminded that `create` in `changeNotifierProvider()` doest not create a new model, instead it saves the model.

- **Consumer** -> A widget that listens for changes in a class that implements `ChangeNotifier`, then rebuilds the widgets below itself when it finds any. When building your widget tree, try to put a *Consumer* as deep as possible in the UI hierarchy, so updates don't recreate the whole widget tree.

``` dart
Consumer<MyModel>(
 builder: (context, model, child) {
 return Text('Hello ${model.value}');
 }
);
```

Note that if you only need access to the model and don't need notifications when the data changes, use `Provider.of, like this ->

``` dart
Provider.of<MyModel>(context, listen: false).<method_name>;
```

- **FutureProvider** -> Much like other providers, but uses the required `create` parameter that returns a `Future`, which is handy when a value is not readily available but will be in the future.

``` dart
FutureProvider(
    initialData: null,
    create: (context) => createFuture(),
    child: <widget>
);

Future<MyModel> createFuture() async {
    return Future.value(MyModel());
}
```

- **MultiProvider** -> To avoid messy nesting, you should use `MultiProvider` to create a list of providers and a single child.

``` dart
MultiProvider(
 providers: [
 Provider<MyModel>(create: (_) => Something()),
 Provider<MyDatabase>(create: (_) => SomethingMore()),
 ],
 child: <widget>
);
```

- **StreamProvider** -> Works the same way as `FutureProvider`, but when receiving data from a stream.

### SINGLE SOURCE OF TRUTH

First, be reminded that this explanation is extended using knowledge of the *Flutter Redux* package.

**Single Source of Truth** -> The state of the entire application is stored in a single store which is a tree model Object.

State is read-only, the only way to change the state is create an action (an object that describes what happens). Changes are made with pure functions, e.g, use a pure function to get the previous state of the same action, and return the new state.

EXAMPLE FLOW ->

1. *User* presses the *login* button.
2. *View* receives it.
3. *Dispatch* sends an *Action* to the *Middleware*.
4. *Action* logic is handled inside the *Middleware*.
5. *Middleware* sends the result (I guess) to the *Reducer*.
6. *Reducer* is responsible for updating again *Store*.
7. *Store* gets the new results to receive updates for the *View*.

In shorter words, an *AppState* defines, then a *UI* triggers *Actions* that are sent to the *Reducer*, which updates the *Store* that contains the *AppState*.

### WHAT IS A SINGLETON

**Singletons** are a very controversial and debated topic in the software development community.

The **singleton pattern** is a *software design pattern* that restricts the instantiation of a class to one "single" instance.

This pattern solves problems by allowing it to ->

- Ensure that a class only has one instance.
- Easily access the sole instance of a class.
- Control its instantiation.
- Restrict the number of instances.
- Access a global variable.

In other words, the *singleton pattern* ensures that only one instance of a class is ever created, making it easy to access it as a global variable.

This is the way to implement a singleton in Dart.

```dart
class Singleton {
  /// private constructor
  Singleton._();
  /// the one and only instance of this singleton
  static final instance = Singleton._();
}
```

By making the constructor private, we ensure that the class cannot be initiated outside the file where it is defined. As a result, the only way to access it is to call `Singleton.instance` in our code.

*Singletons* have drawbacks ->

- **Hard to test**. Way to fix is by using Dependency Injection, a *design pattern* in which an object reveives other objects that it depends on.
- **Implicit Dependencies**.
- **Lazy initialisation**, which can be expensive given the heavy processing. This can be tackled in two ways ->
    1. You can use *late* to defer the object initialisation until later (when it's actually used). Note that all global variables are *lazy-loaded* by default, and this is also true for static class variables. This means that they are only intialised when they are first used. On the other hand, local variables are initialised as soon as they are declared, unless they are declared as *late*.
    2. A less error-prone approach is using the package *get_it*, that makes it easy to register a lazy singleton, or *Riverpod*, since all providers are lazy by default.
- **Instance Lifecycle**. When we initialise a singleton instance, it will remain alive until the end the cycle, aka when the application is closed. We can't release it early even if we want to. A way to overcome this problem is by using *get_it* and *Riverpod*.
- **Thread Safety**. Usually not a concert in Dart, because all application code inside a Flutter app belongs to the *main isolate*, but when creating separate isolates to perform some extra heavy computations, we need to be more careful.

Advice is pretty straight-forward. Don't create your own *singletons*, unless there's a good motivation for that, like building your own package.

Prefer using packages like *get_it* and *Riverpod*.
