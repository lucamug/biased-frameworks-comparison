Things that can go wrong ..., React edition.

This is the second post of the "Things that can go wrong ...".

If you haven't read the first post that is about Vue and Elm, you can find this at:

In this second installment I wrote the same example in React.

React is closer to Elm, compared to Vue, because both of them

* Generate html using functions (JSX)
* Use one-way data binding

While Vue:

* Is based on template (can also use JSX)
* Use two-way data binding

React is written in Javascript so all the issues related to type coercion that appear in Vue are also present in React. But React supports one-way data binding so the fix is simpler and more effective.

The first version is this one:

As you can see it suffers of the similar issue: Javascript concatenate numbers as if they were strings instead treating them as number.

The simple fix is at line 17, from
```
return { ...product, quantity: value };
```
to
```
return { ...product, quantity: Number(value) };
```
this way we force the state of the app to be correct.

Compared to the Elm version, the React version is not checking if the value in the input field is a number or a string. This allow to hit Cancel on the last digit, turning it into zero.

To obtain a similar behavior in Elm example we would need to explicitly add a check on the length of the string and if the string is empty, associate it with a zero.

# Consistency

In React

```
onChange={this.onChange(product.id)}
onClick={() => {this.changeQuantity(product.id, product.quantity + 1);}}
```

In Elm

```
onInput <| ChangeQuantity product.id
onClick <| ChangeQuantity product.id (String.fromInt (product.quantity + 1))
```

In Elm both the input field and the button send out the same message (`ChangeQuantity`) while in React they call two different functions (`onChange` and `changeQuantity`) and the syntax is different.

I wonder if a similar approach would be similar in React, I could not figure it out.

In Vue the input field is magically two-way bound:
```
<input type="number" v-model.number="product.quantity">
```
The button, compared to React and Elm, it changes the quantity in place without calling any function. This part of the two-way binding. In Elm this is impossible, because the View is not allowed to change the state of the system but can only generate messages.
```
<button @click="product.quantity += 1">
```

# Boilerplate

Constructors sometime, depending on the style of writing the code, require boilerplates on each component:
```
constructor() {
    super(props);
    this.handleClick1 = this.handleClick1.bind(this)
    this.handleClick2 = this.handleClick2.bind(this)
}
```

# More way to do one thing

In React it seems that "there are more way to do one thing" while Elm tend to follow the philosophy that "there is one way to do one thing". This also derive from the flexibility of a language such as Javascript.

For example to bind a class method you can use either `bind`, `public class fields syntax` or `arrow functions`.

Moreover working with React require a firm grasp on bind/this/arrow_functions/class_field_syntax concepts while these concepts are absent in Elm.

In this sense Vue is also simpler as it rely less on these concepts.

# Abundance of features and don'ts

Looking at the documentation I was overwhelmed by the abundance of features, for example:

React.memo, React.PureComponent, React.Component, React.cloneElement(), React.createFactory(), React.Children, React.Fragment, React.Suspense, componentDidMount(), getDerivedStateFromProps(), getSnapshotBeforeUpdate(), componentDidUpdate(), componentWillUnmount(), componentDidCatch(), shouldComponentUpdate(), Hooks, Concurrent Mode, Legacy Lifecycle Methods,etc.

# don'ts

And also by the list of "better not to do this way":

"The render() function should be pure", "[...] you should call super(props) [...] otherwise [...] can lead to bugs", "You should not call setState() in the constructor()", "Avoid introducing any side-effects or subscriptions in the constructor.", "Avoid copying props into state, [...] it creates bugs", "You may call setState() immediately in componentDidMount(). It will trigger an extra rendering", "You may call setState() immediately in componentDidUpdate() but note that it must be wrapped in a condition like in the example above, or you’ll cause an infinite loop", "You should not call setState() in componentWillUnmount() because the component will never be re-rendered"

# Typos

Similar to Vue, also React fail silently if we introduce certain typos, for example:
```
value={product.quanity}
```


http://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/

https://codesandbox.io/s/00w95xmnq0
https://codesandbox.io/s/oox55w58x9

https://alligator.io/react/new-way-to-handle-events/
