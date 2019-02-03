
React is closer to Elm than Vue because both of them

* Generate html using functions
* Use one-way data binding

React is written in Javascript so all the issues related to type coercion that appear in Vue are also present in React. Being one-way data binding the fix is much simpler and more effective.

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

In Vue the input field is magically two-way bound (with all the issues that we described in the previous post)
```
<input type="number" v-model.number="product.quantity">
```
The button is also magic because it change the quantity in place.
```
<button @click="product.quantity += 1">
```

# Verbosity

There are commands in React that are added by default, like for example:
```
super(props);
```
I wonder if these properties could be added by default instead of manually adding this line everywhere.

# More way to do one thing
## bind/this/super/arrow_functions/class_field_syntax madness

In React it seems that there are more way to do one thing and it could create some friction when reading someone else code. This also derive from the frequent updated of Javascript.

For example:

* You can create a component as Javascript class (`class Greeting extends React.Component`) or as `create-react-class` module

* To bind a class method you can use either `bind`, `public class fields syntax` or `arrow functions`.

* `React.PureComponent` and `React.Component`



For example, working with React require a firm grasp on bind/this/super/arrow_functions/class_field_syntax concepts....  

Elm tend to follow the philosophy that there is one way to do one thing and it has no concept of bind/this/super/arrow_functions/class_field_syntax.

In this sense Vue is simpler as it rely less on these concepts. Elm doesn't have these concepts.
